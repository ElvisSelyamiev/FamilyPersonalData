//
//  Helper.swift
//  FamilyPersonalData
//
//  Created by Elvis on 25.10.2022.
//

import UIKit

extension UIColor {
    static let customBlue: UIColor = UIColor(red: 1/255, green: 167/255, blue: 253/255, alpha: 1)
    static let customRed: UIColor = UIColor(red: 220/255, green: 87/255, blue: 84/255, alpha: 1)
}

protocol DeleteDataDelegate: AnyObject {
    func deleteCell(cell: ChildrenCell)
}
