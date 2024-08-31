//
//  GoogleLoginTestView.swift
//  LottoMate
//
//  Created by Mirae on 8/29/24.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController {
    
    let googleLogin: UIButton = {
        let button = UIButton()
        button.setTitle("구글 로그인", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        googleLogin.frame.size = CGSize(width: 150, height: 48)
        googleLogin.center = view.center
        googleLogin.addTarget(self, action: #selector(login(_:)), for: .touchUpInside)
        view.addSubview(googleLogin)
    }
    
    @objc func login(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }
            
            // If sign in succeeded, display the app's main content View.
            let email = signInResult?.user.profile?.email ?? ""
            let name = signInResult?.user.profile?.name ?? ""
            
            let user = signInResult?.user
            let idToken = user?.idToken?.tokenString
            let accessToken = user?.accessToken.tokenString
            let refreshToken = user?.refreshToken.tokenString
            
            print(email)
            print(name)
        }
    }
}
