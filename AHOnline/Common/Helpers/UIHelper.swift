//
//  UIHelper.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

import PKHUD
import SwiftSpinner
import ALThreeCircleSpinner

struct UIHelper {
    
    static func configurateApplicationApperance() {
        UIApplication.shared.isStatusBarHidden = false
        UIApplication.shared.statusBarStyle = .lightContent
        
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
        tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: GRAY, NSFontAttributeName : FONT_TABBAR], for: .normal)
        tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: RED, NSFontAttributeName : FONT_TABBAR], for: .selected)
        
        let cell = UITableViewCell.appearance()
        cell.tintColor = RED
    }
    
    static func showHUD(message: String) {
        PKHUD.sharedHUD.contentView = PKHUDTextView(text: message)
        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = true
        PKHUD.sharedHUD.show()
        PKHUD.sharedHUD.hide(afterDelay: 2.0)
    }
    
    static func showAlert(message: String) {
        let alertController = UIAlertController(title: "caption".localizedString, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ok".localizedString, style: .cancel, handler: nil))
        Wireframe.presentViewController(vc: alertController)
    }
    
    static func showAlertHandler(message: String, handler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: "caption".localizedString, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ok".localizedString, style: .cancel, handler: handler))
        Wireframe.presentViewController(vc: alertController)
    }
    
    static func showSpinner(type: Int = 0) {
        switch type {
        case 0:
            ALThreeCircleSpinner.show(color: RED)
            
        case 1:
            SwiftSpinner.show(progress: 0.2, title: "loading".localizedString)
            
        default:
            break
        }
    }
    
    static func hideSpinner(type: Int = 0) {
        switch type {
        case 0:
            ALThreeCircleSpinner.hide()
            
        case 1:
            SwiftSpinner.hide()
            
        default:
            break
        }
    }
    
    static func isValidPhoneTextField(field: UITextField) -> Bool {
        var isValid = false
        var kText = field.text!.trimmingCharacters(in: .whitespaces)
        kText.characters.count == 12 && kText.hasPrefix("+374") ? isValid = true : shakeWithView(view: field)
        
        return isValid
    }
    
    static func isValidPhoneText(text: String) -> Bool {
        let kText = text.trimmingCharacters(in: .whitespaces)
        
        return kText.characters.count == 12 && kText.hasPrefix("+374")
    }
    
    static func isValidCountTextField(textField: UITextField, range: NSRange, string: String) -> Bool {
        var isValid = false
        var text = textField.text! as NSString
        text = text.replacingCharacters(in: range, with: string) as NSString
        var numvber: Int = 1
        if let text = Int(text as String) {
            numvber = text
        }
        let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let components = string.components(separatedBy: inverseSet)
        let filtered = components.joined(separator: "")
        (string == filtered) && numvber < CA_COUNT && numvber != 0 ? isValid = true : shakeWithView(view: textField)
        
        return isValid
    }
    
    static func isValidTextField(field: UITextField) -> Bool {
        var isValid = false
        let kText = field.text!.trimmingCharacters(in: .whitespaces)
        !kText.isEmpty ? isValid = true : shakeWithView(view: field)
        
        return isValid
    }
    
    static func isValidTextView(view: UITextView) -> Bool {
        var isValid = false
        let kText = view.text!.trimmingCharacters(in: .whitespaces)
        !(kText == "") ? isValid = true : shakeWithView(view: view)
        
        return isValid
    }
    
    static func isValidEmail(text: String) -> Bool {
        var isValid = false
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let email = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        isValid = email.evaluate(with: text)
        
        return isValid
    }
    
    static func isValidText(text: String) -> Bool {
        let kText = text.trimmingCharacters(in: .whitespaces)
        
        return !kText.isEmpty
    }
    
    static func isValidEmail(field: UITextField) -> Bool {
        var isValid = false
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let email = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        email.evaluate(with: field.text) ? isValid = true : shakeWithView(view: field)
        
        return isValid
    }
    
    static func isValidPasswordsEqual(passwordField: UITextField, confirmPasswordField: UITextField) -> Bool {
        var isValid = false
        let kPassword = passwordField.text!.trimmingCharacters(in: .whitespaces)
        let kConfirmPassword = confirmPasswordField.text!.trimmingCharacters(in: .whitespaces)
        if kPassword == kConfirmPassword && kPassword != "" && kConfirmPassword != "" && kPassword.characters.count > 3 && kConfirmPassword.characters.count > 3 {
            isValid = true
        } else {
            shakeWithView(view: passwordField)
            shakeWithView(view: confirmPasswordField)
        }
        
        return isValid
    }
    
    static func isValidAccountTextFiled(field: UITextField) -> Bool {
        var isValid = false

        let set = NSCharacterSet.decimalDigits.inverted
        let array = field.text!.components(separatedBy:set)
        let numbers = array.joined(separator: "")
        
        if numbers.characters.count < 9 {
            shakeWithView(view: field)
            return false
        }
        
        var reversedString = ""
        let range = Range<String.Index>(numbers.startIndex..<numbers.endIndex)
        
        numbers.enumerateSubstrings(in: range, options: [NSString.EnumerationOptions.reverse, NSString.EnumerationOptions.byComposedCharacterSequences]) { (substring, substringRange, enclosingRange, stop) -> () in
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
        (oddSum + evenSum) % 10 == 0 ? isValid = true : shakeWithView(view: field)
        
        return isValid
    }

    static func shakeWithView(view: UIView) {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let from_point = CGPoint(x: view.center.x - 5, y: view.center.y)
        let from_value = NSValue(cgPoint: from_point)
        
        let to_point = CGPoint(x: view.center.x + 5, y: view.center.y)
        let to_value = NSValue(cgPoint: to_point)
        
        shake.fromValue = from_value
        shake.toValue = to_value
        view.layer.add(shake, forKey: "position")
    }
    
    static func insertRowsInTable<T>(tableView: UITableView, objects: [T], inObjects: inout [T], reversable: Bool) {
        var indexPaths = Array<IndexPath>()
        let currentCount = inObjects.count
        for i in 0..<objects.count {
            indexPaths.append(IndexPath(row: currentCount+i, section:0))
        }
        let revObjects = objects.reversed()
        inObjects = reversable ? inObjects + revObjects : inObjects + objects
        
//        tableView.beginUpdates()
        tableView.insertRows(at: indexPaths, with: .none)
//        tableView.endUpdates()
    }
    
    static func deleteRowsFromTable<T>(tableView: UITableView, objects: inout [T]) {
        var indexPaths = Array<IndexPath>()
        for i in 0..<objects.count {
            indexPaths.append(IndexPath(row: i, section:0))
        }
        objects.removeAll()
        
//        tableView.beginUpdates()
        tableView.deleteRows(at: indexPaths, with: .none)
//        tableView.endUpdates()
    }
    
    static func insertRowsInCollection<T>(collectionView: UICollectionView, objects: [T], inObjects: inout [T], reversable: Bool) {
        var indexPaths = Array<IndexPath>()
        let currentCount = inObjects.count
        for i in 0..<objects.count {
            indexPaths.append(IndexPath(row: currentCount+i, section:0))
        }
        let revObjects = objects.reversed()
        inObjects = reversable ? inObjects + revObjects : inObjects + objects
        
        collectionView.insertItems(at: indexPaths)
    }
    
    static func deleteRowsFromCollection<T>(collectionView: UICollectionView, objects: inout [T]) {
        var indexPaths = Array<IndexPath>()
        for i in 0..<objects.count {
            indexPaths.append(IndexPath(row: i, section:0))
        }
        objects.removeAll()
        
        collectionView.deleteItems(at: indexPaths)
    }
}
