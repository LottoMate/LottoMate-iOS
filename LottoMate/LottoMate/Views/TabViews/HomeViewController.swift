//
//  HomeTabView.swift
//  LottoMate
//
//  Created by Mirae on 7/26/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    let viewModel = LottoMateViewModel()
    
    override func loadView() {
        view = TestButtonView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HomeViewController loaded.")
        
        if let testButtonView = view as? TestButtonView {
            testButtonView.defaultSolidButton.addTarget(self, action: #selector(showWinningNumbersDetail), for: .touchUpInside)
        }
    }
    
    @objc func showWinningNumbersDetail() {
        let detailViewController = WinningNumbersDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
