// pawan kumar

import UIKit
import IQKeyboardManagerSwift

class InfoViewController: UIViewController {
    
    // MARK: Outlet

    @IBOutlet var headerviewInfo: UIView!
    @IBOutlet weak var tblView_Info: UITableView!
    @IBOutlet weak var qualification_txtfld: UITextField!
    @IBOutlet weak var passing_txt: UITextField!
    @IBOutlet weak var grade_txt: UITextField!
    @IBOutlet weak var experince_txt: UITextField!
    @IBOutlet weak var design_txt: UITextField!
    @IBOutlet weak var domain_txt: UITextField!
    
    let viewmodel: validateEducationalInfoDelegate = RegistrationViewModel()
    private let dataBase = DataBaseManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        inialsetup()
    }

    private func inialsetup(){
        tblView_Info.delegate = self
        tblView_Info.dataSource = self
        passing_txt.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
        grade_txt.delegate = self
        design_txt.delegate = self
        domain_txt.delegate = self
        passing_txt.tintColor = .clear
        currentYearSetup()
       
    }
    
    private func currentYearSetup(){
        if let  datePicker = self.passing_txt.inputView as? UIDatePicker {
            let currentDate = Date()
            let calendar = Calendar.current
            let startOfCurrentYear = calendar.startOfDay(for: currentDate)
            let endOfCurrentYear = calendar.date(byAdding: .year , value: 0, to: startOfCurrentYear)
            datePicker.maximumDate = endOfCurrentYear
        }
    }
    
    
                                           
    @objc func doneButtonPressed() {
    if let  datePicker = self.passing_txt.inputView as? UIDatePicker {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    datePicker.preferredDatePickerStyle = .wheels
    self.passing_txt.text = dateFormatter.string(from: datePicker.date)
    }
    self.passing_txt.resignFirstResponder()
        }
    
    // MARK: Action
    
    @IBAction func back(_sender:UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectEducationTap(_ sender: UIButton) {
        guard  let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "SelectDropDownVC") as? SelectDropDownVC else {
            return
        }
        vc.infoAdress = "infoAdress"
        vc.callback = { (selectedClass) -> Void in
         self.qualification_txtfld.text = selectedClass
        }
        
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func previouClcik(_ sender: Any) {
        self.navigationController?.popViewController(animated:true)
    }
    
    @IBAction func nextClick(_ sender: Any) {
        let validationResult = viewmodel.validateEducationalInfo(education: qualification_txtfld.text, passingYear: passing_txt.text, grade: grade_txt.text, yearsExperience: experince_txt.text, designation: design_txt.text, domain: domain_txt.text)
    
        let status = validationResult.0
        let message = validationResult.1
        
        if status == true {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: Constants.Identifiers.AddressInfoVC) as? AddressInfoVC
            self.navigationController?.pushViewController(vc!, animated: true)
        }else {
            createAlert(title:Constants.ScreenNames.warningString, message: message)
        }
        saveAlldetail()
    }

    func saveAlldetail()
    {
        let user  =  EducationBackGround(education:qualification_txtfld.text ?? "",passingYear:passing_txt.text ?? "",grade: grade_txt.text ?? "", experience:experince_txt.text ?? "", designation: design_txt.text ?? "" , domaindata: domain_txt.text ?? "")
           dataBase.educationData(user)
    }
    }

 
// MARK: delegate and dataSource

extension InfoViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       return headerviewInfo
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 550
    }
}





































extension InfoViewController: UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 1 ||  textField.tag == 2 ||  textField.tag == 3
        {
            do {
                
                let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                let regex = try NSRegularExpression(pattern: "^([a-zA-Z0-9]{0,10})$", options: [])
                if regex.firstMatch(in: text, options: [], range: NSMakeRange(0, text.count)) != nil {
                    return true
                }
            }
            catch {
                print("ERROR")
            }
            return false
        }
        else
        {
            return true
        }
    }
}


