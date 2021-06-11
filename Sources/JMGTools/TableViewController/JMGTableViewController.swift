//
//  JMGTableViewController.swift
//  LittleFreeLibrary
//
//  Created by Will Wang on 5/24/21.
//

import UIKit

/**
 Convenient list component where a Header class is not required.
 
 ## Generics ##
 T: the cell type that this list will register and dequeue.
 
 U: the item type that each cell will visually represent.
 */

@available(iOS 11.0, tvOS 11.0, *)
open class JMGTableViewController<T: JMGTableViewCell<U>, U>: JMGTableHeaderController<T, U, UITableViewHeaderFooterView> {
}
