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
        
        let testView = TestButtonView()
        self.view = testView
    }
}

#Preview {
    let preview = ViewController()
    return preview
}

