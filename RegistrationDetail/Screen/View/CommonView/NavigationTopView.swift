//
//  NavigationTopView.swift
//  RegistrationFormDemo
//
//  Created by neosoft on 29/01/24.
//

import UIKit
import Foundation


class NavigationTopView: UIView {
//outlet
    @IBOutlet weak var backtapButton: UIButton!
    @IBOutlet weak var navigationTitle: UILabel!
}


extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
