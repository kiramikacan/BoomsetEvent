//
//  GuestsViewController.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import UIKit

//MARK: - Init Methods
extension GuestsViewController{
    static func initViewController()->UIViewController{
        let controller = GuestsViewController(nibName: "GuestsViewController", bundle: nil)
        
        return controller
    }
}

//MARK: - Class Base Methods & Properties
class GuestsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Guests"
    }

}
