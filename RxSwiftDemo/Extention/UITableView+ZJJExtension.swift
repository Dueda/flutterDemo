//
//  UITableView+ZJJExtension.swift
//  RxSwiftDemo
//
//  Created by dueda on 2021/4/10.
//

import UIKit

extension UITableView {

    func registCell(_ cellClass: UITableViewCell.Type) {
        let identifier = String(describing: cellClass)
        register(cellClass, forCellReuseIdentifier: identifier)
    }
    func dequeueRerusableCell<T: UITableViewCell>(with cellClass: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: cellClass)
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }
    func registNib<T: UITableViewCell>(_ cellClass: T) {
        let identifier = self.getClassName(cellClass)
        register(UINib.init(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    func dequeueRerusableNibCell<T: UITableViewCell>(with cellClass: T, for indexPath: IndexPath) -> T {
        let identifier = self.getClassName(cellClass)
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }
    
    func getClassName<T:UITableViewCell>(_ cellClass: T) -> String {
        let project_cls_name: String = NSStringFromClass(type(of: cellClass))
        let range = (project_cls_name as NSString).range(of: ".")
        let cls_name = (project_cls_name as NSString).substring(from: range.location + 1) as String
        return cls_name
    }
}


