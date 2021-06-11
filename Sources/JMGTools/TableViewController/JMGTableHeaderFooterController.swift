//
//  JMGTableHeaderFooterController.swift
//  LittleFreeLibrary
//
//  Created by Will Wang on 5/24/21.
//

import UIKit

/**
 ListHeaderFooterController helps register, dequeues, and sets up cells with their respective items to render in a standard single section list.
 
 ## Generics ##
 T: the cell type that this list will register and dequeue.
 
 U: the item type that each cell will visually represent.
 
 H: the header type above the section of cells.
 
 F: the footer type below the section of cells
 
 */
@available(iOS 11.0, tvOS 11.0, *)
open class JMGTableHeaderFooterController<T: JMGTableViewCell<U>, U, H: UITableViewHeaderFooterView, F: UITableViewHeaderFooterView>: UITableViewController {
    
    /// An array of U objects this list will render. When using items.append, you still need to manually call reloadData.
    open var items = [U]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    fileprivate let cellId = "cellId"
    fileprivate let headerViewId = "headerViewId"
    fileprivate let footerViewId = "headerViewId"
    
    /// Return an estimated height for proper indexPath using systemLayoutSizeFitting.
    open func estimatedCellHeight(for indexPath: IndexPath, cellWidth: CGFloat) -> CGFloat {
        let cell = T()
        let largeHeight: CGFloat = 1000
        cell.frame = .init(x: 0, y: 0, width: cellWidth, height: largeHeight)
        cell.item = items[indexPath.item]
        cell.layoutIfNeeded()
        
        return cell.systemLayoutSizeFitting(.init(width: cellWidth, height: largeHeight)).height
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        #if os(iOS)
        if #available(iOS 13.0, *) {
            tableView.backgroundColor = .systemBackground
        } else {
            tableView.backgroundColor = .white
        }
        #endif
        
        tableView.register(T.self, forCellReuseIdentifier: cellId)
        tableView.register(H.self, forHeaderFooterViewReuseIdentifier: headerViewId)
        tableView.register(F.self, forHeaderFooterViewReuseIdentifier: footerViewId)
    }
    
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! T
        cell.item = items[indexPath.row]
        cell.parentController = self
        return cell
    }
    
    
    /// Override this to manually set up your header with custom behavior.
    open func setupHeader(_ header: H) {}
    
    open func setupFooter(_ footer: F) {}
    
    open override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerViewId)
        if let header = header as? H {
            setupHeader(header)
        }
        return header
    }
    
    open override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: footerViewId)
        if let footer = footer as? F {
            setupFooter(footer)
        }
        return footer
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
//    /// If you don't provide this, headers and footers for UICollectionViewControllers will be drawn above the scroll bar.
//    override open func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
//        view.layer.zPosition = -1
//    }
    
    public override init(style: UITableView.Style) {
        super.init(style: style)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("You most likely have a Storyboard controller that uses this class, please remove any instance of JMGListHeaderController or sublasses of this component from your Storyboard files.")
    }
    
}


