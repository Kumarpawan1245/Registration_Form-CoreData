//
//  RegistrationFormValidation.swift
//  RegistrationDetail
//
//  Created by neosoft on 05/02/24.


import Foundation

final class RegistrationValidation {

    static let shared = RegistrationValidation() // singlon
     private init() {}
    
    func validateBasicInfo(firstName: String?, lastName: String?, email: String?, password: String?, confirmPassword: String?, mobileNumber: String?) -> (Bool, String) {

        
        guard firstName != "" && lastName != "" && password != "" && confirmPassword != "" else {
            return (false,requiredFilledAlert)
        }

        guard firstName!.count > 3 && containsOnlyCharacters(firstName!) == true else {
            return (false,kAlertFirstName)
        }

        guard lastName!.count > 3 && containsOnlyCharacters(lastName!) == true else {
            return (false, kAlertLastName)
        }
        
        if mobileNumber != "" {
            guard mobileNumber!.count == 10 && containsOnlyNumbers(mobileNumber!) == true else {
                return (false, kAlertMobileValid)
            }
        }

        if email != "" {
            guard email?.isValidEmail == true else {
                return (false,kAlertValidEmail)
            }
        }

        guard password != "" else {
                return (false,pleaseEnterPassword)
            }
        
        guard confirmPassword != "" else {
               return (false,pleaseconfirmPassword)
           }
        
        guard password!.count > 3   else {
            return (false,kpassword)
        }
        
        if (confirmPassword != password){
            return (false,confirmpassmatch)
       }
        return (true,validationSuccessfull)
    }

    
    func validateEducationalInfo(education: String?, passingYear: String?, grade: String?, yearsExperience: String?, designation: String?, domain: String?) -> (Bool, String) {
        
//        guard education != pleaseEnterQualification && passingYear != "" else {
//            return (false,requiredFilledAlert)
//        }
        
        guard education !=  "" else {
            return (false,selectQuaAlert)
        }
        guard passingYear != "" else {
            return (false,validPassingYear)
        }

        guard grade != "" else {
               return (false,pleasegrade)
           }
        
        guard yearsExperience != "" else {
               return (false,Kalertexpe)
           }

        guard designation != "" else {
               return (false,Kalertdesign)
           }
        
        guard domain != "" else {
               return (false,Kaldomain)
           }
        
        if designation != "" {
            guard validateInput(designation!) == true else {
                return (false, validdesignation)
            }
        }
        
        if yearsExperience != "" {
            guard containsOnlyNumbers(yearsExperience!) == true else {
                return (false,entervalidyearsofexperience)
            }
        }
        
        if domain != "" {
            guard validateInput(domain!) == true else {
                return (false,entervaliddomain)
            }
        }
        
        return (true,validationSuccessfull)
    }
    
    func validateAddressInfo(address: String?, landmark: String?, pincode: String?, city: String?, state: String?) -> (Bool, String) {
        
        
        guard address != "" else {
            return (false,KalertAdress)
        }
        
        guard landmark != "" else {
            return (false,validAdressland)
        }
        
        guard city != "" else {
            return (false,"please enter the city")
        }
        
        guard state != "" else {
            return (false,"please enter the state")
        }
        
        guard pincode != "" else {
            return (false,KalertpinsAlert)
        }
        
        
        guard landmark != validAdressland else {
            return (false,validAdressland)
        }
        
        guard address!.count > 3 else {
            return (false,validLandMark)
        }
        
        guard landmark!.count > 3 else {
            return (false,validLandMark)
        }
        guard city!.count > 3 else {
            return (false,Kalertcity)
        }

        guard state != Kalertstate else {
            return (false,Kalertstate)
        }
        
//        guard state! != Kalertstate else {
//            return (false, Kalertstate)
//        }

        if city != "" {
            guard containsOnlyCharacters(city!) == true else {
                return (false, Kalertcity)
            }
        }
        
        if pincode != "" {
            guard containsOnlyNumbers(pincode!) == true && pincode?.count == 6 else {
                return (false, Kalertpin)
            }
        }
        return (true,validationSuccessfull)
    }
}


extension RegistrationValidation
{
    func containsOnlyCharacters(_ input: String) -> Bool {
        let characterSet = CharacterSet.letters
        return input.rangeOfCharacter(from: characterSet.inverted) == nil
    }
    
    func containsOnlyAllowedCharacters(_ input: String) -> Bool {
        let allowedCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()_+")
        let inputCharacterSet = CharacterSet(charactersIn: input)
        return allowedCharacterSet.isSuperset(of: inputCharacterSet)
    }
    
    func containsOneNumberAndOneSpecialChar(_ input: String) -> Bool {
        let numberRegex = numRegex
        let specialCharRegex = specialChra
        
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        let specialCharPredicate = NSPredicate(format: "SELF MATCHES %@", specialCharRegex)
        
        let containsNumber = numberPredicate.evaluate(with: input)
        let containsSpecialChar = specialCharPredicate.evaluate(with: input)
        
        return containsNumber && containsSpecialChar
    }
    
    func containsOnlyNumbers(_ input: String) -> Bool {
        let numericCharacterSet = CharacterSet.decimalDigits
        let inputCharacterSet = CharacterSet(charactersIn: input)
        return numericCharacterSet.isSuperset(of: inputCharacterSet)
    }
    
    func validateInput(_ input: String) -> Bool {
        let pattern = validInput
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: input.utf16.count)
        let matches = regex.matches(in: input, range: range)
        return matches.count > 0
    }

}
