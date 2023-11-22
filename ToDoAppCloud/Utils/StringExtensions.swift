//
//  StringExtensions.swift
//  ToDoAppCloud
//
//  Created by Shengjie Mao on 11/21/23.
//

import Foundation

extension String {
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    var isValidPassword : Bool {
        let passwordRegEx = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`']{8,}$"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPredicate.evaluate(with: self)
    }
}
