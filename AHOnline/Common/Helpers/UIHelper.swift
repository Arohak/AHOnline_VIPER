//
//  UIHelper.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

import PKHUD
import ALThreeCircleSpinner

struct UIHelper {
    
    static func configurateApplicationApperance() {
        UIApplication.sharedApplication().statusBarHidden = false
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        let navBarAppearance = UINavigationBar.appearance()
//        navBarAppearance.setBackgroundImage(UIImage(), forBarMetrics: .Default)
//        navBarAppearance.shadowImage = UIImage()
//        navBarAppearance.translucent = true
        navBarAppearance.tintColor = RED
        navBarAppearance.titleTextAttributes = [NSForegroundColorAttributeName: RED, NSFontAttributeName : FONT_NAVBAR]
        
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.tintColor = RED
//        tabBarAppearance.barStyle = .Black
//        tabBarAppearance.translucent = false
//        tabBarAppearance.barTintColor = CLEAR
        
        let tabBarItem = UITabBarItem.appearance()
        tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: GRAY, NSFontAttributeName : FONT_TABBAR], forState: .Normal)
        tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: RED, NSFontAttributeName : FONT_TABBAR], forState: .Selected)
    }
    
    static func showHUD(message: String) {
        PKHUD.sharedHUD.contentView = PKHUDTextView(text: message)
        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = true
        PKHUD.sharedHUD.show()
        PKHUD.sharedHUD.hide(afterDelay: 2.0)
    }
    
    static func showAlert(message: String) {
        let alertController = UIAlertController(title: "AHOnline", message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        Wireframe.presentViewController(alertController)
    }
    
    static func showAlertHandler(message: String, handler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: "AHOnline", message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: handler))
        Wireframe.presentViewController(alertController)
    }
    
    static func showSpinner() {
//        ALThreeCircleSpinner.config()
//        ALThreeCircleSpinner.show()
    }
    
    static func hideSpinner() {
//        ALThreeCircleSpinner.hide()
    }
    
    static func isValidCountTextField(textField: UITextField, range: NSRange, string: String) -> Bool {
        var isValid = false
        var text = textField.text! as NSString
        text = text.stringByReplacingCharactersInRange(range, withString: string)
        var numvber: Int = 1
        if let text = Int(text as String) {
            numvber = text
        }
        let inverseSet = NSCharacterSet(charactersInString:"0123456789").invertedSet
        let components = string.componentsSeparatedByCharactersInSet(inverseSet)
        let filtered = components.joinWithSeparator("")
        (string == filtered) && numvber < 100 && numvber != 0 ? isValid = true : shakeWithView(textField)
        
        return isValid
    }
    
    static func isValidTextField(field: UITextField) -> Bool {
        var isValid = false
        let kText = field.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        !(kText == "") ? isValid = true : shakeWithView(field)
        
        return isValid
    }
    
    static func isValidTextView(view: UITextView) -> Bool {
        var isValid = false
        let kText = view.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        !(kText == "") ? isValid = true : shakeWithView(view)
        
        return isValid
    }
    
    static func isValidEmail(text: String) -> Bool {
        var isValid = false
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let email = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        isValid = email.evaluateWithObject(text)
        
        return isValid
    }
    
    static func isValidEmail(field: UITextField) -> Bool {
        var isValid = false
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let email = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        email.evaluateWithObject(field.text) ? isValid = true : shakeWithView(field)
        
        return isValid
    }
    
    static func isValidPasswordsEqual(passwordField: UITextField, confirmPasswordField: UITextField) -> Bool {
        var isValid = false
        let kPassword = passwordField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        let kConfirmPassword = confirmPasswordField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        if kPassword == kConfirmPassword && kPassword != "" && kConfirmPassword != "" && kPassword.characters.count > 3 && kConfirmPassword.characters.count > 3 {
            isValid = true
        } else {
            shakeWithView(passwordField)
            shakeWithView(confirmPasswordField)
        }
        
        return isValid
    }
    
    static func isValidAccountTextFiled(field: UITextField) -> Bool {
        var isValid = false

        let set = NSCharacterSet.decimalDigitCharacterSet().invertedSet
        let array = field.text!.componentsSeparatedByCharactersInSet(set)
        let numbers = array.joinWithSeparator("")
        
        if numbers.characters.count < 9 {
            shakeWithView(field)
            return false
        }
        
        var reversedString = ""
        let range = Range<String.Index>(numbers.startIndex..<numbers.endIndex)
        
        numbers.enumerateSubstringsInRange(range, options: [NSStringEnumerationOptions.Reverse, NSStringEnumerationOptions.ByComposedCharacterSequences]) { (substring, substringRange, enclosingRange, stop) -> () in
            reversedString += substring!
        }
        
        var oddSum = 0, evenSum = 0
        let reversedArray = reversedString.characters
        var i = 0
        
        for s in reversedArray {
            
            let digit = Int(String(s))!
            
            if i % 2 == 0 {
                evenSum += digit
            } else {
                oddSum += digit / 5 + (2 * digit) % 10
            }
            i += 1
        }
        (oddSum + evenSum) % 10 == 0 ? isValid = true : shakeWithView(field)
        
        return isValid
    }

    static func shakeWithView(view: UIView) {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let from_point = CGPointMake(view.center.x - 5, view.center.y)
        let from_value = NSValue(CGPoint: from_point)
        
        let to_point = CGPointMake(view.center.x + 5, view.center.y)
        let to_value = NSValue(CGPoint: to_point)
        
        shake.fromValue = from_value
        shake.toValue = to_value
        view.layer.addAnimation(shake, forKey: "position")
    }
    
    static func insertRowsInTable<T>(tableView: UITableView, objects: [T], inout inObjects: [T], reversable: Bool) {
        var indexPaths = Array<NSIndexPath>()
        let currentCount = inObjects.count
        for i in 0..<objects.count {
            indexPaths.append(NSIndexPath(forRow: currentCount+i, inSection:0))
        }
        let revObjects = objects.reverse()
        inObjects = reversable ? inObjects + revObjects : inObjects + objects
        
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Fade)
        tableView.endUpdates()
    }
    
    static func deleteRowsFromTable<T>(tableView: UITableView, inout objects: [T]) {
        var indexPaths = Array<NSIndexPath>()
        for i in 0..<objects.count {
            indexPaths.append(NSIndexPath(forRow: i, inSection:0))
        }
        objects.removeAll()
        
        tableView.beginUpdates()
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .None)
        tableView.endUpdates()
    }
}