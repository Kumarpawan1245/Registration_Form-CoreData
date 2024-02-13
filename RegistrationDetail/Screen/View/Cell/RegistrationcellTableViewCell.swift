
import UIKit
import  IQKeyboardManagerSwift

class RegistrationcellCell: UITableViewCell,UITextFieldDelegate {
    static let identifier = "RegistrationcellCell"

    @IBOutlet weak var lblTitlName: UILabel!
    @IBOutlet weak var detailTextfiled: UITextField!
    @IBOutlet weak var detailIconImage: UIImageView!
    var indexPath: IndexPath?
   
    var callBack:((_ data:String)->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        detailTextfiled.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.callBack?(detailTextfiled.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard let indexPath = indexPath else {
                return true
            }
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return newText.count <= 10 && newText.rangeOfCharacter(from:CharacterSet.decimalDigits.inverted) == nil
        } 
}
