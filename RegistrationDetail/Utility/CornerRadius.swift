

import UIKit

class LightShadow1: UIView {
    required public init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 6
    }
}

class DarkShadowView1: UIView {
    required public init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0.5, height: 0)
        self.layer.shadowRadius = 5
    }
}


open class FullCornerRadiusWithBorder: UIView {
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.layer.masksToBounds = true
        self.layer.cornerRadius=self.layer.frame.height/2
        self.layer.borderColor = UIColor(red: 0.949, green: 0.953, blue: 0.969, alpha: 1).cgColor
        self.layer.borderWidth = 1.0
    }
}

open class FullCornerRadiusWithBorderOnView: UIView {
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.layer.masksToBounds = true
        self.layer.cornerRadius=self.layer.frame.height/2
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
    }
}


open class CornerRadiusWithBorder2: UIView {
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2.0
    }
}

open class CornerRadiusWithBorder4: UIView {
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 4
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.0
    }
}



open class CornerRadiusOnView: UIView {
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8.0
    }
}

open class CornerRadiusOnView2: UIView {
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
    }
}








open class CornerRadiusButton: UIButton {
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8
    }
}

open class CornerRadiusButtonWithBorder: UIButton {
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.borderWidth = 1.0
    }
}


open class CornerRadiusViewWithBorderhalf:UIView{
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
    }
}
open class CornerRadiusTextViewWithBorderhalf: UITextView{
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
    }
}
open class CornerRadiusButtonWithBorderhalf: UIButton{
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
    }
}

extension UIImageView {
 public func maskCircle() {
     self.contentMode = UIView.ContentMode.scaleAspectFill
   self.layer.cornerRadius = self.frame.height / 2
   self.layer.masksToBounds = false
   self.clipsToBounds = true
 }
}


extension String {
    
    
//    var trim:String {
//        return self.trimmingCharacters(in: .whitespaces)
//    }

    var isBlank:Bool {
        return self.trim.isEmpty
    }
    
    var isAlphanumeric:Bool {
        return !isBlank && rangeOfCharacter(from: .alphanumerics) != nil
    }
    
    var isAlpha:Bool {
        let allowed = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let characterSet = CharacterSet(charactersIn: allowed)
        return !isBlank && rangeOfCharacter(from: characterSet) != nil
    }
    
//    var isValidEmail:Bool {
//        //        let emailRegEx = "[A-Z0-9a-z_%+-]+.@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
//        let emailRegEx = "[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}"
//        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        return predicate.evaluate(with:self)
//    }
    
    var isValidPhoneNo:Bool {
        let phoneCharacters = CharacterSet(charactersIn: "+0123456789").inverted
        let arrCharacters = self.components(separatedBy: phoneCharacters)
        return self == arrCharacters.joined(separator: "")
    }
}

extension UIViewController {
    
func createAlert (title:String, message:String)
    {
        let okcallback: (()->())?
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
        })
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
    
    
    
    @objc func ok() {
        self.resignFirstResponder()
    }
    
    @objc func cancel() {
        self.resignFirstResponder()
    }
    
    func isValidEmail(testStr:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}


