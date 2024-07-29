//
//  ViewController.swift
//  LottoMate
//
//  Created by Mirae on 7/23/24.
//

import UIKit

class TestButtonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let testButtonView = TestButtonView()
        self.view = testButtonView
    }
}

#Preview {
    let preview = TestButtonViewController()
    return preview
}

