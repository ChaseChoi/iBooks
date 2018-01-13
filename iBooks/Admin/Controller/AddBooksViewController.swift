//
//  AddBooksViewController.swift
//  iBooks
//
//  Created by Chase Choi on 07/01/2018.
//  Copyright © 2018 Chase Choi. All rights reserved.
//

import UIKit
import Dispatch

struct viewTags {
    static let numInput = 7667
    static let priceInput = 7666
}

protocol AddBooksViewControllerDelegate: class {
    func addBooksViewController(_ controller: AddBooksViewController, finishAdding bookItem: Book)
}

class AddBooksViewController: UITableViewController, UIGestureRecognizerDelegate {
    var bookItem: Book?
    
    var delegate: AddBooksViewControllerDelegate?
    
    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var isbnLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBOutlet weak var numOfBooksTextfield: InputTextField!
    @IBOutlet weak var priceTextfield: InputTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // dynamic cell height
        tableView.estimatedRowHeight = tableView.rowHeight 
        tableView.rowHeight = UITableViewAutomaticDimension
        
        setUpAddTargetIsNotEmptyTextFields()
        setupUI()
        
        // dismiss keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(sender:)))
        tap.delegate = self 
        self.view.addGestureRecognizer(tap)
        
        // add next button above keyboard
        let nextToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        nextToolBar.barStyle = UIBarStyle.default
        nextToolBar.items = [
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "下一栏", style: UIBarButtonItemStyle.plain, target: self, action: #selector(nextField))]
        nextToolBar.sizeToFit()
        priceTextfield.inputAccessoryView = nextToolBar
        
        // add pre button above keyboard
        let preToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        preToolBar.barStyle = UIBarStyle.default
        preToolBar.items = [
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "上一栏", style: UIBarButtonItemStyle.plain, target: self, action: #selector(previousField))]
        numOfBooksTextfield.inputAccessoryView = preToolBar
        
    }

    @objc func nextField() {
        if let nextTextfield = self.view.viewWithTag(viewTags.numInput) as? InputTextField {
               nextTextfield.becomeFirstResponder()
        }
    }
    @objc func previousField() {
        if let preTextfield = self.view.viewWithTag(viewTags.priceInput) as? InputTextField {
                preTextfield.becomeFirstResponder()
        }
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        // handling code
        self.view.endEditing(true)
    }
    
    func setupUI() {
        coverImageView.image = UIImage(named: "coverPlaceholder")
        if let url = bookItem?.imageURL {
            coverImageView.loadImage(url: url)
        }
        if let title = bookItem?.title {
            titleLabel.text! = title
        }
        if let isbn = bookItem?.isbn {
            isbnLabel.text! = isbn
        }
        if let author = bookItem?.authors {
            authorLabel.text! = author
        }
        if let publisher = bookItem?.publisher {
            publisherLabel.text! = publisher
        }
        if let category = bookItem?.categories {
            categoryLabel.text! = category
        }
    }
    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func done() {
        let hudView = HUDView.hud(inView: navigationController!.view, animated: true)
        hudView.text = "完成"
        // delay to finish the hud
        let delayInSeconds = 0.6
        afterDelay(delayInSeconds) {
            self.delegate?.addBooksViewController(self, finishAdding: self.bookItem!)
        }
    }
    
    func setUpAddTargetIsNotEmptyTextFields() {
        doneButton.isEnabled = false
        
        priceTextfield.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
        numOfBooksTextfield.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
    }
    
    @objc func textFieldsIsNotEmpty(sender: InputTextField) {
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        
        guard
            let price = priceTextfield.text, !price.isEmpty,
            let number = numOfBooksTextfield.text, !number.isEmpty else {
                doneButton.isEnabled = false
                return
        }
        doneButton.isEnabled = true
    }
    
    
}
extension AddBooksViewController {
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}

