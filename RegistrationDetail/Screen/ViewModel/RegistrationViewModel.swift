//
//  RegistrationViewModel.swift
//  RegistrationDetail
//  Created by neosoft on 05/02/24.


import Foundation


protocol validateRegisterdInfoDelegate {

    func validateregistredInfo(firstName: String?, lastName: String?, mobileNumber: String?, email: String?, password: String?, confirmPassword: String?) -> (Bool, String)
}

 protocol validateEducationalInfoDelegate {
    func validateEducationalInfo(education: String?, passingYear: String?, grade: String?, yearsExperience: String?, designation: String?, domain: String?) -> (Bool, String)
}

protocol validateAddressInfoDelegate {
    func validateAddressInfo(address: String?, landmark: String?, city: String?, state: String?, pincode: String?) -> (Bool, String)
}

class RegistrationViewModel: validateRegisterdInfoDelegate, validateEducationalInfoDelegate , validateAddressInfoDelegate {
    
    // MARK: FUNCTIONS
    
    func validateregistredInfo(firstName: String?, lastName: String?, mobileNumber: String?, email:  String?, password: String?, confirmPassword:String?) -> (Bool, String) {
        
        let result = RegistrationValidation.shared.validateBasicInfo(firstName: firstName, lastName: lastName, email: email, password: password, confirmPassword: confirmPassword, mobileNumber: mobileNumber)
        return result
    }
    
    func validateEducationalInfo(education: String?, passingYear: String?, grade: String?, yearsExperience: String?, designation: String?, domain: String?) -> (Bool, String) {
        
        let result = RegistrationValidation.shared.validateEducationalInfo(education: education, passingYear: passingYear, grade: grade, yearsExperience: yearsExperience, designation: designation, domain: domain)
        
        return result
    }
    
    func validateAddressInfo(address: String?, landmark: String?, city: String?, state: String?, pincode: String?) -> (Bool, String) {
        let result = RegistrationValidation.shared.validateAddressInfo(address: address, landmark: landmark, pincode: pincode, city: city, state: state)
         return result
    }
}
