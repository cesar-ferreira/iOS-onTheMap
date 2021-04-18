//
//  TabBarViewController.swift
//  onTheMap
//
//  Created by César Ferreira on 17/04/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    private var TabTitles = [
        "Map",
        "List"
    ]

    private var tabIcons = [
        UIImage(systemName: "map.fill"),
        UIImage(systemName: "rectangle.grid.1x2.fill")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        if let tabBarItems = tabBar.items {
            for (index, item) in tabBarItems.enumerated() {
                item.title = TabTitles[index]
                item.image = tabIcons[index]
            }
        }
    }
}
