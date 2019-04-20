//
//  Functions.swift
//  Trackee
//
//  Created by Pramodya Abeysinghe on 7/4/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import UIKit

class Functions {
    
}

extension UIViewController {
    
    // alert
    func simpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func simpleAlert(title: String, message: String, toFocus:UITextField) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            toFocus.becomeFirstResponder()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    // dismiss keyboard
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}

extension String {
    var isNotEmpty: Bool {
        return !isEmpty
    }
    
    var isNumber: Bool {
        return Double(self) != nil
    }
}

extension Date {
    func startOfMonth(month: Int, year: Int) -> Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = month
        components.year = year
        let newDate = calendar.date(from: components)!
        
        let date = calendar.date(from: calendar.dateComponents([.year, .month], from: calendar.startOfDay(for: newDate)))!

        return calendar.date(byAdding: DateComponents(day: 1), to: date)!
    }
    
    func endOfMonth(month: Int, year: Int) -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: 0), to: self.startOfMonth(month: month, year: year))!
    }
}

extension UIButton{
    func roundedOnLeftButton(){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topLeft , .bottomLeft],
                                     cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    
    func roundedOnRightButton(){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topRight , .bottomRight],
                                     cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
}
