//
//  EventsViewController.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/15/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Events"
    }

}

//MARK: - Init Methods
extension EventsViewController{
    static func initViewController()->UINavigationController{
        let controller = EventsViewController(nibName: "EventsViewController", bundle: nil)
        let navController = UINavigationController(rootViewController: controller)
        return navController
    }
}
