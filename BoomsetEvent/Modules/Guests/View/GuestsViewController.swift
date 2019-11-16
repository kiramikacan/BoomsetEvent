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
    static func initViewController(selectedEvent: EventViewModel)->UIViewController{
        let controller = GuestsViewController(nibName: "GuestsViewController", bundle: nil)
        controller.selectedEvent = selectedEvent
        return controller
    }
}

//MARK: - Class Base Methods & Properties
class GuestsViewController: UIViewController {

    var selectedEvent: EventViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let selectedEvent = self.selectedEvent {
            self.navigationItem.title = selectedEvent.event.name
        }
        
    }

}
