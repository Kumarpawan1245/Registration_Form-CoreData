//
//  ResigtrationModel.swift
//  RegistrationDetail
//  Created by neosoft on 05/02/24.
  
import Foundation
import UIKit



struct UserModel
{
    let firstName : String
    let lastName : String
    let phoneNum : String
    let email : String
    let passwordata : String
    let confirmPassword:String
    var imageName:String
  }

struct EducationBackGround
{
    let education : String
    let passingYear : String
    let grade : String
    let experience : String
    let designation : String
    let domaindata : String
      
  }

enum Education: String, CaseIterable {
    case ssc = "SSC"
    case hns = "HSC/Diploma"
    case graduate = "Graduate"
    case postGraduate = "Post Graduate"
}

enum States: String, CaseIterable {
    case maharashtra = "Maharashtra"
    case gujarat = "Gujarat"
    case karnataka = "Karnataka"
    case madhyaPradesh = "Madhya Pradesh"
    case delhi = "Delhi"
    case others = "Others"
}

struct ResigtrationModel
{
    var dataArray =  ["firstName*", "LastName*","phone Number*","Email*"]
    var dataImage = [
        UIImage(named:"profilepic"),
        UIImage(named:"profilepic"),
        UIImage(named:"phoneicon"),
        UIImage(named:"email")
        ]
}

