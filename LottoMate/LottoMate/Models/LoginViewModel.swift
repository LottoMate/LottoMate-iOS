//
//  SignInViewModel.swift
//  LottoMate
//
//  Created by Mirae on 10/11/24.
//

import Foundation
import GoogleSignIn

final class LoginViewModel {
    static let shared = LoginViewModel()
    
    func googleSignIn() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { signInResult, error in
                
                if let error = error {
                    print("Error during Google Sign-In: \(error.localizedDescription)")
                    return
                }
                
                guard let signInResult = signInResult else {
                    print("No sign-in result available")
                    return
                }
                
                // Handle successful sign-in
                let user = signInResult.user
                let emailAddress = user.profile?.email
                let fullName = user.profile?.name
            }
        } else {
            print("googleSignIn() - No root view controller found!")
        }
    }
}
