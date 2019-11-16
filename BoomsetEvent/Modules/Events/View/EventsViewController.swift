//
//  EventsViewController.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/15/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {

    var eventResponse: EventResponse?
    var events = [Event]()
    
    var presenter: EventsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Events"
        
        presenter?.fetchEvents()
    }

}

extension EventsViewController: EventsViewProtocol {
    
    func setEventResponse(_ response: EventResponse) {
        self.eventResponse = response
        self.events = response.results
    }
    
    func showProggress() {
        self.displayProgress()
    }
    
    func closeProggress() {
        self.dismissProgress()
    }
    
}

//MARK: - Init Methods
extension EventsViewController{
    static func initViewController()->UINavigationController{
        let controller = EventsViewController(nibName: "EventsViewController", bundle: nil)
        let navController = UINavigationController(rootViewController: controller)
        
        let presenter = EventsPresenter()
        let iterator = EventsInteractor(apiWorker: EventsApiWorker())
        
        presenter.view = controller
        presenter.interactor = iterator
        iterator.presenter = presenter
        controller.presenter = presenter
        
        return navController
    }
}
