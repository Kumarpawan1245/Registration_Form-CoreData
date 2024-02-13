

import UIKit
import  IQKeyboardManagerSwift

class AddressInfoVC: UIViewController {
    
    // MARK: IBOUTLETS
    
    // VIEW
    @IBOutlet weak var viewAddress: UIView!
    @IBOutlet weak var viewLandmark: UIView!
    @IBOutlet weak var viewCity: UIView!
    @IBOutlet weak var viewState: UIView!
    @IBOutlet weak var viewPincode: UIView!
    
    // TEXTFIELD
    @IBOutlet weak var tfAddress: UITextField!
    @IBOutlet weak var tfLandmark: UITextField!
    @IBOutlet weak var tfCity: UITextField!
    @IBOutlet weak var tfPincode: UITextField!
    
    // BUTTON
    @IBOutlet weak var btnNext: UIButton!
    
    // LABEL
    @IBOutlet weak var lblState: UILabel!
    
    // PickerView
    @IBOutlet weak var pickerState: UIPickerView!
    
    // SCROLLVIEW
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    // MARK: PROPERTIES
    let viewmodel: validateAddressInfoDelegate = RegistrationViewModel()
    var didTapPicker:Bool = false
    var textFields: [UITextField] = []
    
    // MARK: FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        textFields = [tfAddress, tfLandmark, tfCity, tfPincode]
        for textField in textFields {
            textField.delegate = self
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        updateUI()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func updateUI() {
        pickerState.delegate = self
        pickerState.dataSource = self
        
        tfAddress.delegate = self
        tfLandmark.delegate = self
        tfCity.delegate = self
        tfPincode.delegate = self
        
        pickerState.isHidden = true
        
        viewAddress.layer.borderWidth = 1.0
        viewAddress.layer.borderColor = UIColor.black.cgColor
        
        viewLandmark.layer.borderWidth = 1.0
        viewLandmark.layer.borderColor = UIColor.black.cgColor
        
        viewCity.layer.borderWidth = 1.0
        viewCity.layer.borderColor = UIColor.black.cgColor
        
        viewState.layer.borderWidth = 1.0
        viewState.layer.borderColor = UIColor.black.cgColor
        
        viewPincode.layer.borderWidth = 1.0
        viewPincode.layer.borderColor = UIColor.black.cgColor
        
        btnNext.backgroundColor = Constants.Color.primaryColor
        btnNext.setTitleColor(UIColor.white, for: .normal)
        btnNext.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(Constants.FontSize.subtitle))
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardFrame.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        var visibleRect = self.view.frame
        visibleRect.size.height -= keyboardFrame.height
    }

    @objc func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    @IBAction func btnDidTapNext(_ sender: UIButton) {
        let validationResult = viewmodel.validateAddressInfo(address: tfAddress.text, landmark: tfLandmark.text, city: tfCity.text, state: lblState.text, pincode: tfPincode.text)
                
        let status = validationResult.0
        let message = validationResult.1
        
        if status == true {
            createAlert(title:Constants.ScreenNames.successString, message: message)
        }else {
            createAlert(title:Constants.ScreenNames.successString, message: message)
        }
    }
    
    @IBAction func pickerDidTapState(_ sender: UIButton) {
        if didTapPicker == false {
            didTapPicker = true
            pickerState.isHidden = false
        }else {
            didTapPicker = false
            pickerState.isHidden = true
        }
    }
    
    @IBAction func btndidTapBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: PICKERVIEW METHODS
extension AddressInfoVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return States.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return States.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedValue = States.allCases[row].rawValue
        lblState.text = "\(selectedValue)"
        lblState.textColor = UIColor.black
    }
}


// MARK: UITEXTFIELD DELEGATE
extension AddressInfoVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if !textFields.isEmpty {
            let activeTextFieldRect = textField.convert(textField.bounds, to: scrollView)
            scrollView.scrollRectToVisible(activeTextFieldRect, animated: true)
        }
    }
}
