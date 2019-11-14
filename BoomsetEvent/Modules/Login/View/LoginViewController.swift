//
//  LoginViewController.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/15/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

//MARK: Init Methods
extension LoginViewController{
    static func initViewController()->LoginViewController{
        let controller = LoginViewController(nibName: "LoginViewController", bundle: nil)
        return controller
    }
}
