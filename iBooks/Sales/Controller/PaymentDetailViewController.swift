//
//  PaymentDetailViewController.swift
//  iBooks
//
//  Created by Chase Choi on 14/01/2018.
//  Copyright © 2018 Chase Choi. All rights reserved.
//

import UIKit

class PaymentDetailViewController: UITableViewController {
    @IBOutlet weak var dateInputTextfield: UITextField!
    var datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    
    var currentAmount = 0.0
    var discount = 0.0 
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var vipLevelLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var currentAmountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // update current amount
        currentAmountLabel.text = String(format: "%.2f", currentAmount)
        discountLabel.text = "0.0"
        
        vipLevelLabel.isHidden = true
        
        // ref: https://stackoverflow.com/questions/28708574/how-to-remove-extra-empty-cells-in-tableviewcontroller-ios-swift
        tableView.tableFooterView = UIView()
        
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        datePicker.backgroundColor = .white
        
        dateInputTextfield.inputView = datePicker
        
        // set up tool bar
        createToolbar()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        setUpDefaultTime()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.showCustomerList.rawValue {
            
            let tableViewController = segue.destination as! CustomerTableViewController
            tableViewController.delegate = self
        }
    }
    
    func setUpDefaultTime() {
        dateInputTextfield.text = dateFormatter.string(from: Date())
    }
    
    func createToolbar() {
//        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let todayButton = UIBarButtonItem(title: "今天", style: .plain, target: self, action: #selector(todayButtonPressed))
        
        // customize tip label
        let tip = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width/3, height: 40))
        tip.text = "请选择购买日期"
        let labelButton = UIBarButtonItem(customView: tip)
        
        let doneButton = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(dismissKeyboard))
        
        // set padding space
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        // add buttons to the tool bar
        toolBar.setItems([todayButton, flexibleSpace, labelButton, flexibleSpace, doneButton], animated: true)
        
        // display the tool bar above the keyboard
        dateInputTextfield.inputAccessoryView = toolBar
        
    }
    
    /// When the datePicker's value is cahnged, put the date info into dateInputTextfield
    @objc func datePickerValueChanged() {
        
        // update the content of textfield
        dateInputTextfield.text = dateFormatter.string(from: datePicker.date)
    }
    /// set date picker to today's info
    @objc func todayButtonPressed() {
        datePicker.setDate(Date(), animated: true)
        dateInputTextfield.text = dateFormatter.string(from: Date())
    }
    
    /// When the user hit the done button, dismiss the keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

// ref: https://stackoverflow.com/questions/9444743/dismiss-pushed-view-from-within-navigation-controller
extension PaymentDetailViewController: CustomerListViewControllerDelegate {
    func customerListViewControllerDelegate(_ controller: CustomerTableViewController, finishSelecting user: User) {
        self.navigationController?.popViewController(animated: true)
        
            userNameLabel.text = user.name
            vipLevelLabel.text = user.vip
            vipLevelLabel.isHidden = false
    }
    
}


