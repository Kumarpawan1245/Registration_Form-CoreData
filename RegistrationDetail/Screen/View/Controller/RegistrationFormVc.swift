// pawan kumar

import UIKit
import Foundation
import IQKeyboardManagerSwift
import CoreData

class RegistrationFormVc: UIViewController {

    // MARK: Outlet
    @IBOutlet weak var impTopHeader: UIImageView!
    @IBOutlet weak var navigationTopView: UIView!
    @IBOutlet weak var heaederView: UIView!
    @IBOutlet weak var malebtn: UIButton!
    @IBOutlet weak var femalemalebtn: UIButton!
    
    @IBOutlet weak var profilepicbtn: UIButton!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var tableviewRegistation: UITableView!
    
    @IBOutlet weak var confirmpasswordTxt: UITextField!
    @IBOutlet weak var maleselectedImg: UIImageView!
    @IBOutlet weak var femaleselectedImg: UIImageView!
    @IBOutlet weak var hidebtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    // MARK: Array definedataset
    var resigtrationModel =  ResigtrationModel()
    let viewmodel: validateRegisterdInfoDelegate = RegistrationViewModel()
    var firstName = ""
    var lastName = ""
    var emailAdree = ""
    var phoneNum = ""
    private var  imageselected = false
    private let dataBase = DataBaseManager()
    var user: UserEntity?
    override func viewDidLoad() {
        super.viewDidLoad()
        createTableview()
        customView()
        setUI()
    }

    // MARK: delegate self defined
    private func createTableview()
    {
        tableviewRegistation.dataSource = self
        tableviewRegistation.delegate = self
        tableviewRegistation.register(UINib(nibName: RegistrationcellCell.identifier, bundle: nil), forCellReuseIdentifier: RegistrationcellCell.identifier)
    }


    // MARK: Intialsetup
    private func setUI() {
        setUpButtons()
        passwordTxt.isSecureTextEntry = true
        confirmpasswordTxt.isSecureTextEntry = true
        malebtn.isSelected = false
        femalemalebtn.isSelected = true
        maleselectedImg.image = UIImage(named:Constants.ScreenNames.selectedgender)
        femaleselectedImg.image = UIImage(named:Constants.ScreenNames.unselctedgender)
        impTopHeader.maskCircle()
    }
    
    
    // MARK: Registerded the customView_Navigation
    private func customView()
    {
        let customView = Bundle.main.loadNibNamed("NavigationTopView", owner: self, options: nil)?.first as! NavigationTopView
        navigationTopView.addSubview(customView)
        customView.navigationTitle.text = Constants.ScreenNames.registertxt
    }

    
    private func setUpButtons() {
        nextBtn.clipsToBounds = true
        hidebtn.setImage(UIImage(named:Constants.ScreenNames.show_pass), for: .normal) // show
        showpass = false
    }
    
    
    @IBAction func changeGender(sender: UIButton) {
        switch sender {
        case malebtn:
            maleselectedImg.image = UIImage(named:Constants.ScreenNames.selectedgender)
            femaleselectedImg.image = UIImage(named:Constants.ScreenNames.unselctedgender)
        case femalemalebtn:
            femaleselectedImg.image = UIImage(named: Constants.ScreenNames.selectedgender)
            maleselectedImg.image = UIImage(named:Constants.ScreenNames.unselctedgender)
         default:
            break
        }
    }
    
    
    
    @IBAction func securePassword(sender: UIButton) {
        if showpass == false
        {
            passwordTxt.isSecureTextEntry = false
            hidebtn.setImage(UIImage(named:Constants.ScreenNames.hide_pass), for: .normal) // hide
        }
        else {
            passwordTxt.isSecureTextEntry = true
            hidebtn.setImage(UIImage(named:Constants.ScreenNames.show_pass), for: .normal) // show
        }
        showpass = !showpass
        
    }
    
    @IBAction func profilepicClick(_ sender: UIButton) {
        ImagePickerManager().pickImage(self){ image in
            self.impTopHeader.image = image
            self.imageselected = true
            
        }
    }

    @IBAction func nextbt(_ sender: UIButton) {
        let validationResult = viewmodel.validateregistredInfo(firstName:firstName.trim, lastName: lastName.trim, mobileNumber:phoneNum.trim, email: emailAdree.trim, password: passwordTxt.text?.trim, confirmPassword: confirmpasswordTxt.text?.trim)
        
        let status = validationResult.0 //
        let message = validationResult.1
        
        if status == true {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: Constants.Identifiers.InfoViewController) as? InfoViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }else {
            createAlert(title:Constants.ScreenNames.warningString, message: message)
        }
        saveAlldetail()
    }

    func saveAlldetail()
    {
        let imageName = UUID().uuidString
        var  newuser  =  UserModel(firstName:firstName,lastName:lastName,phoneNum:phoneNum,email: emailAdree,passwordata:passwordTxt.text!, confirmPassword: confirmpasswordTxt.text!, imageName:imageName)
        if let  user
        {
            newuser.imageName = user.imagename ?? ""
            dataBase.updateUser(user: newuser, userEntity:user)
            saveToDirectly(imageName: user.imagename ?? "")
        }
        else
        {
            
            saveToDirectly(imageName: imageName)
            dataBase.adduser(newuser)
        }
    }

    
    func saveToDirectly(imageName:String)
      {
        let fileUrl = URL.documentsDirectory.appending(component:imageName).appendingPathExtension("png")
        if let data = impTopHeader.image?.pngData()
        {
            do {
                try data.write(to: fileUrl)
            }
            catch
            {
                print("Saving image to document directoy error:",error)
                
            }
        }
    }
}



extension RegistrationFormVc: UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      if section == 0
        {
          return resigtrationModel.dataArray.count}
         else{return 0}
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = self.tableviewRegistation.dequeueReusableCell(withIdentifier: "RegistrationcellCell")  as! RegistrationcellCell
        if indexPath.section == 0
        {
            cell.lblTitlName.text = resigtrationModel.dataArray[indexPath.row]
            cell.detailIconImage.image = resigtrationModel.dataImage[indexPath.row]
            switch indexPath.row
            {
            case 0:
                cell.detailTextfiled.text = firstName
                cell.detailTextfiled.attributedPlaceholder = NSAttributedString(string:Constants.placeholder.placeHolderFirst,attributes: [NSAttributedString.Key.foregroundColor:UIColor.lightGray])
            case 1:
                cell.detailTextfiled.text = self.lastName.trim
                cell.detailTextfiled.attributedPlaceholder = NSAttributedString(string:Constants.placeholder.placeHolderlast,attributes: [NSAttributedString.Key.foregroundColor:UIColor.lightGray])
            case 2:
                cell.detailTextfiled.text = self.phoneNum.trim
//                cell.detailTextfiled.keyboardType = .phonePad
                cell.indexPath = indexPath
                cell.detailTextfiled.attributedPlaceholder = NSAttributedString(string:Constants.placeholder.placeHolderphone,attributes: [NSAttributedString.Key.foregroundColor:UIColor.lightGray])
            case 3:
                cell.detailTextfiled.text = self.emailAdree.trim
                cell.detailTextfiled.attributedPlaceholder = NSAttributedString(string:Constants.placeholder.placeHolderemail,attributes: [NSAttributedString.Key.foregroundColor:UIColor.lightGray])
            default:
                print("")
            }

            cell.callBack = {
             data in
             switch indexPath.row {
             case 0:
                 self.firstName = data
             case 1:
             self.lastName = data
             case 2:
             self.phoneNum = data
             case 3:
             self.emailAdree = data
             default:
              print("index")
             }
         }
            return cell
        }
        else
        {
         return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return heaederView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1
        {
            return 250
        }
        else
        {
            return 0.0
        }
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
        {
            return UITableView.automaticDimension
        }
        else
        {
            return 0
        }
    }
}



