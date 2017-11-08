//
//  AddItemTableViewControllerDelegate.swift
//  BucketList
//
//  Created by Kevin Pham on 11/7/17.
//  Copyright © 2017 Kevin Pham. All rights reserved.
//

import Foundation

protocol AddItemTableViewControllerDelegate: class {
    
    func itemSaved (by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath?)
    
    func CancelButtonPressed (by controller: AddItemTableViewController)


}

