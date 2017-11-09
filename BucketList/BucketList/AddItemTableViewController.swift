//
//  AddItemTableViewController.swift
//  BucketList
//
//  Created by Kevin Pham on 11/7/17.
//  Copyright © 2017 Kevin Pham. All rights reserved.
//

import UIKit

//=============================================//
//==========="Top view controller"=============//
//=============================================//


class AddItemTableViewController: UITableViewController{

    
    weak var delegate: AddItemTableViewControllerDelegate?
    
    var item: String?
    var indexPath: NSIndexPath?
    
    
    @IBOutlet weak var itemTextField: UITextField!
    
    
    @IBAction func CancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.CancelButtonPressed(by: self)
    }
    
    
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let text = itemTextField.text!
        delegate?.itemSaved(by: self, with: text, at: indexPath)
        // by pressing "save" this func happens:
            // passing the "text" and "indexPath"
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTextField.text = item
        // Do any additional setup after loading the view.
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
