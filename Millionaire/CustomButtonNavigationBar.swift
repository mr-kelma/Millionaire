//
//  CustomButtonNavigationBar.swift
//  Millionaire
//
//  Created by Sergio on 4.11.22.
//

import UIKit

extension UIViewController {

    func createCustomButton(selector: Selector) -> UIBarButtonItem {

        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "money"), for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }
}
