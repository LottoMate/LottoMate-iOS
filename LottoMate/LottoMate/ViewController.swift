//
//  ViewController.swift
//  LottoMate
//
//  Created by Mirae on 7/23/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let testHomeView = TestHomeView()
        self.view = testHomeView
    }
}

#Preview {
    let preview = ViewController()
    return preview
}

