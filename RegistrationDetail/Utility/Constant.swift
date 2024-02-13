//
//  Constant.swift
//  RegistrationDetail
//
//  Created by neosoft on 05/02/24.
//

import Foundation
import UIKit



struct Constants {

    struct Identifiers {
        static let RegistrationFormVc = "RegistrationFormVc"
        static let InfoViewController = "InfoViewController"
        static let AddressInfoVC = "AddressInfoVC"
    }
    
    struct ScreenNames
    {
       // RegistrationFormVc
        static let firstNameicon = "profilepic"
        static let lastNameicon = "profilepic"
        static let mobicon = "phoneicon"
        static let email = "email"
        static let camera = "camera"
        static let lock = "lock"
        static let show_pass = "show_pass"
        static let hide_pass = "hide_pass"
        static let selectedgender = "selectedgender"
        static let unselctedgender = "unselctedgender"
        static let registertxt = "Register"
        static let warningString = "Warning"
       
        
       // InfoViewController
        let arrowDropDown = "arrowDropDown"
        static let successString = "Success"
        static let successMessageString = "Registration complete"
        let cancel = "cancel"
        //AdressVc
        let lanmark = "lanmark"
    }
    
    struct placeholder
    {
        // RegistrationFormVc
        static let placeHolderFirst = "Enter you first name here"
        static let placeHolderlast = "Enter you last name here"
        static let placeHolderphone = "Enter you 10 digit here"
        static let placeHolderemail = "your mail goes here here"
    }
    
    struct Color {
        static let primaryColor = UIColor(hexString: "#2b3261")
    }
    
    struct FontSize {
        static let title = 32
        static let subtitle = 18
        static let body = 14
    }
}
