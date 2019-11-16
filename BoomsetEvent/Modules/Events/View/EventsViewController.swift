//
//  EventsViewController.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/15/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import UIKit

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

//MARK: - Class Base Methods & Properties
class EventsViewController: UIViewController {

    var eventModels = [EventViewModel]()
    
    var presenter: EventsPresenterProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Events"
        
        setubTableView()
    }
    
    func setubTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 72
        tableView.register(UINib(nibName: EventsTableViewCell.className, bundle: nil), forCellReuseIdentifier: EventsTableViewCell.className)
        presenter?.fetchEvents()
    }

}

//MARK: - Protocol Methods
extension EventsViewController: EventsViewProtocol {
    
    func gotoGuests() {
        let vc = GuestsViewController.initViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showEventModels(_ eventModels: [EventViewModel]) {
        self.eventModels = eventModels
        self.tableView.reloadData()
    }
    
    func showProggress() {
        self.displayProgress()
    }
    
    func closeProggress() {
        self.dismissProgress()
    }
    
}

//MARK: - TableView DataSource&Delegate Methods
extension EventsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventsTableViewCell.className, for: indexPath) as! EventsTableViewCell
        cell.configure(with: eventModels[indexPath.row])
        return cell
    }
    
}
