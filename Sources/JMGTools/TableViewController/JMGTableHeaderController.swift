//
//  JMGTableHeaderController.swift
//  LittleFreeLibrary
//
//  Created by Will Wang on 5/24/21.
//


import UIKit

/**
 ListHeaderController helps register, dequeues, and sets up cells with their respective items to render in a standard single section list.

 ## Generics ##
 T: the cell type that this list will register and dequeue.
 
 U: the item type that each cell will visually represent.
 
 H: the header type above the section of cells.
 
 */
@available(iOS 11.0, tvOS 11.0, *)
open class JMGTableHeaderController<T: JMGTableViewCell<U>, U, H: UITableViewHeaderFooterView>: JMGTableHeaderFooterController<T, U, H, UITableViewHeaderFooterView> {
}
