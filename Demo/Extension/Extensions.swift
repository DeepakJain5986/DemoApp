//
//  Extensions.swift
//  Demo
//
//  Created by Deepak on 20/07/23.
//
import Foundation
import UIKit
import MBProgressHUD

extension NSMutableAttributedString {
    
    func setFontForText(textForAttribute: String, withColor color: UIColor, withFont customFont: UIFont) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        self.addAttribute(NSAttributedString.Key.font, value: customFont, range: range)
    }
    
    //MARK: Method for create one attributed string using product title and product description

    class func setAttributedTextwithSubTitle(_ title:String, withSubTitle text:String, withTextFont font:UIFont, withSubTextFont textFont:UIFont, withTextColor color:UIColor, withSubTextColor textColor:UIColor ,withTextAlignment textAlignmentType:NSTextAlignment) -> NSMutableAttributedString
    {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = textAlignmentType
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let attributed = NSMutableAttributedString(string: String(title))
        attributed.append(NSAttributedString(string: "\n"))
        attributed.append(NSAttributedString(string: text))

        let text_range = NSMakeRange(0, String(attributed.string).unicodeScalars.count)
        attributed.setFontForText(textForAttribute: title, withColor: color, withFont: font)
        attributed.setFontForText(textForAttribute: text, withColor: textColor, withFont: textFont)
        attributed.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: text_range)
        return attributed
    }
}

extension String {
    
    // MARK:- Email Validation Check
    func isValidEmail(_ testStr:String) -> Bool {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}

extension UIViewController{
    
    func showAlert(title:String , message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showIndicator(withTitle title: String, and Description:String) {
       let Indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
       Indicator.label.text = title
       Indicator.isUserInteractionEnabled = false
       Indicator.detailsLabel.text = Description
       Indicator.show(animated: true)
    }
    func hideIndicator() {
       MBProgressHUD.hide(for: self.view, animated: true)
    }
}












