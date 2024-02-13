//
//  DataBaseManager.swift
//  RegistrationDetail
//
//  Created by neosoft on 06/02/24.


import Foundation
import UIKit
import CoreData

class DataBaseManager
{
    
    private var context : NSManagedObjectContext
    {
        return  (UIApplication.shared.delegate as!  AppDelegate).persistentContainer.viewContext
    }

    func adduser(_ user: UserModel)
    {
        let userEtity = UserEntity(context: context)
        userEtity.firstName = user.firstName
        userEtity.lastName = user.lastName
        userEtity.phoneNum = user.phoneNum
        userEtity.email = user.email
        userEtity.passworddata = user.passwordata
        userEtity.imagename  = user.imageName
        
        do
        {
            try context.save()
        }
        catch
        {
            print("Saving error:",error)
            
        }
    }
    
    func updateUser(user:UserModel,userEntity:UserEntity)
     {
         userEntity.firstName = user.firstName
         userEntity.lastName = user.lastName
         userEntity.phoneNum = user.phoneNum
         userEntity.email = user.email
         userEntity.passworddata = user.passwordata
         userEntity.imagename  = user.imageName
          contextsave()
   }
     

    func educationData(_ user:EducationBackGround)
     {
        let educationEntity = EducationEntity(context: context)
        educationEntity.education = user.education
        educationEntity.passingYear = user.passingYear
        educationEntity.grade = user.grade
        educationEntity.domainchoose = user.domaindata
        educationEntity.experince = user.experience
         contextsave()
    }

    
    
    func fetchdata() ->[UserEntity]
    {
        var user : [UserEntity] = []
        do
        {
            user =  try context.fetch(UserEntity.fetchRequest())
            
        }
        catch
        {
            print("fetchErroe error:",error)
        }
        return user
    }

    // delete
    func deleteData(userEntity:UserEntity )
    {
        let imgeUrl = URL.documentsDirectory.appending(component:userEntity.imagename ?? "").appendingPathExtension("png")
        do
        {
            try FileManager.default.removeItem(at: imgeUrl)
        }
        catch
        {
            print("remove image dd:",error)
        }
       
             context.delete(userEntity)
             contextsave()
    }
    
    func contextsave()
    {
        do
        {
            try context.save()
        }
        
        catch
        {
            print("Saving error:",error)
        }
    }
}
