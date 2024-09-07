//
//  LottoMateProvider.swift
//  LottoMate
//
//  Created by Mirae on 8/11/24.
//  회차별 복권 당첨 결과 페이지에서 사용

import Moya
import RxSwift
import RxRelay

class LottoMateViewModel {
    static let shared = LottoMateViewModel()
    
    var currentLottoRound = BehaviorRelay<Int?>(value: nil)
    var currentPensionLotteryRound = BehaviorRelay<Int?>(value: nil)
    
    var lottoResult = BehaviorRelay<LottoResultModel?>(value: nil)
    var pensionLotteryResult = BehaviorRelay<PensionLotteryResultModel?>(value: nil)
    var latestLotteryResult = BehaviorRelay<LatestLotteryWinningInfoModel?>(value: nil)
    var isLoading = BehaviorRelay<Bool>(value: true) // isLoading 값 사용 테스트 필요
    
    var selectedLotteryType = BehaviorSubject<LotteryType>(value: .lotto)
    var selectedSpeetoType = BehaviorSubject<Int>(value: 0)
    
    var lottoDrawRoundData = BehaviorSubject<[(Int, String)]?>(value: nil)
    
    private let apiClient = LottoMateClient()
    private let disposeBag = DisposeBag()
    
    private init() { }
    
    let lottoRoundTapEvent = BehaviorRelay<Bool?>(value: false)
    let speetoTypeTapEvent = BehaviorRelay<SpeetoType?>(value: .the2000)
    
    /// 최신 회차 복권 당첨 정보 가져오기
    func fetchLottoHome() {
        apiClient.getLottoHome()
            .subscribe(onNext: { [weak self] result in
                self?.latestLotteryResult.accept(result)
                
                let latestLottoRound = result.the645.drwNum
                self?.currentLottoRound.accept(latestLottoRound)
                
                let pensionLotteryRound = result.the720.drwNum
                self?.currentPensionLotteryRound.accept(pensionLotteryRound)
                
                print("fetching latest lottery result...: \(result)")
            }, onError: { error in
                print("Error fetching latest lottery result: \(error)")
            })
            .disposed(by: disposeBag)
    }
    /// 회차별 로또 정보 가져오기
    func fetchLottoResult(round: Int) {
        isLoading.accept(true)
        apiClient.getLottoResult(round: round)
            .subscribe(onNext: { [weak self] result in
                self?.lottoResult.accept(result)
                self?.isLoading.accept(false)
            }, onError: { error in
                print("Error fetching lotto result: \(error)")
                self.isLoading.accept(false)
            })
            .disposed(by: disposeBag)
    }
    /// 회차별 연금복권 정보 가져오기
    func fetchPensionLotteryResult(round: Int) {
        apiClient.getPensionLotteryResult(round: round)
            .subscribe(onNext: { [weak self] result in
                self?.pensionLotteryResult.accept(result)
            }, onError: { error in
                print("Error fetching pension lottery result: \(error)")
            })
            .disposed(by: disposeBag)
    }
    /// 회차 선택 픽커 뷰 데이터
    func drawRoundPickerViewData() {
        guard let latestLottoRound = latestLotteryResult.value?.the645.drwNum,
              let latestLottoDrawDate = latestLotteryResult.value?.the645.drwDate else { return }
        
        // 현재 값을 가져옵니다.
        var currentData: [(Int, String)] = []
        do {
            if let data = try lottoDrawRoundData.value() {
                currentData = data
            }
        } catch {
            print("Error getting current value: \(error)")
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // 최신 회차 날짜로부터 100회 전까지의 회차와 날짜 계산
        if let drawDate = dateFormatter.date(from: latestLottoDrawDate) {
            let previousDrawDates = calculatePreviousDrawDates(from: latestLottoRound, date: drawDate, numberOfRounds: 100)
            
            // 계산된 회차와 날짜를 currentData에 추가
            for (round, date) in previousDrawDates.sorted(by: { $0.key > $1.key }) {
                let formattedDate = dateFormatter.string(from: date)
                let newRoundData: (Int, String) = (round, formattedDate)
                currentData.append(newRoundData)
            }
        }
        
        // 옵셔널 값으로 새 데이터를 전송합니다.
        lottoDrawRoundData.onNext(currentData)
    }

    /// 마지막 아이템에 도달하면 호출되어 추가 데이터를 로드하는 메서드
    func loadMoreDrawRounds() {
        do {
            // 현재 lottoDrawRoundData의 값을 가져옵니다.
            var currentData: [(Int, String)] = []
            if let data = try lottoDrawRoundData.value() {
                currentData = data
            }

            // 마지막 튜플에서 마지막 회차 값을 가져옵니다.
            if let lastRound = currentData.last?.0, lastRound > 1 {
                let updatedLastRound = lastRound - 1
                let startRound = max(updatedLastRound - 100, 1)
                let newRounds = (startRound..<updatedLastRound).reversed()
                
                // 마지막 회차의 날짜 가져오기
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                // 마지막 회차의 날짜를 추출하고 7일 전으로 업데이트
                if let lastDrawDateString = currentData.last?.1,
                   var lastDrawDate = dateFormatter.date(from: lastDrawDateString) {
                    
                    // 날짜를 7일 전으로 이동
                    lastDrawDate = Calendar.current.date(byAdding: .day, value: -7, to: lastDrawDate) ?? lastDrawDate
                    
                    // 새로운 회차의 날짜를 계산
                    let previousDrawDates = calculatePreviousDrawDates(from: updatedLastRound, date: lastDrawDate, numberOfRounds: 100)
                    
                    // 새 회차 데이터를 튜플로 생성하여 배열에 추가
                    for (round, date) in previousDrawDates.sorted(by: { $0.key > $1.key }) {
                        let formattedDate = dateFormatter.string(from: date)
                        let newRoundData: (Int, String) = (round, formattedDate)
                        currentData.append(newRoundData)
                    }

                    // 새 데이터를 전송합니다.
                    lottoDrawRoundData.onNext(currentData)
                }
            }
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    // 특정 회차와 해당 회차 날짜로부터 이전 회차들의 날짜를 계산하는 함수
    func calculatePreviousDrawDates(from drawRound: Int, date: Date, numberOfRounds: Int) -> [Int: Date] {
        var drawDates: [Int: Date] = [:]
        var currentRound = drawRound
        var currentDate = date
        
        // 일주일씩 날짜를 빼면서 이전 회차들의 날짜를 계산
        for _ in 0..<numberOfRounds {
            drawDates[currentRound] = currentDate
            
            // 1주일(7일) 전으로 날짜를 이동
            if let newDate = Calendar.current.date(byAdding: .day, value: -7, to: currentDate) {
                currentDate = newDate
                currentRound -= 1
            }
        }
        
        return drawDates
    }
}
