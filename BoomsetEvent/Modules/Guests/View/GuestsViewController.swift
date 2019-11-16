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
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "..."
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.text = "Guests"
        return label
    }()
    
    lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 2.0
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.titleView = titleStackView
        
        if let selectedEvent = self.selectedEvent {
            titleLabel.text = selectedEvent.event.name
        }
        
    }

}
