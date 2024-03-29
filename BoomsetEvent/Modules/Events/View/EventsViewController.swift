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
        let iterator = EventsInteractor(apiWorker: EventsApiWorker(), cacher: EventsCacher())
        
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
    var filteredEventModels = [EventViewModel]()
    
    var presenter: EventsPresenterProtocol?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Events"
        
        setupSearchBar()
        setubTableView()
    }
    
    func setupSearchBar()  {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by name"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    func setubTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 72
        tableView.register(UINib(nibName: EventsTableViewCell.className, bundle: nil), forCellReuseIdentifier: EventsTableViewCell.className)
        
        fetchEvents()
    }
    
    func fetchEvents() {
        presenter?.fetchEvents()
    }

}

//MARK: - Protocol Methods
extension EventsViewController: EventsViewProtocol {
    
    func gotoGuests(with selectedEvent: EventViewModel) {
        let vc = GuestsViewController.initViewController(selectedEvent: selectedEvent)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showEventModels(_ eventModels: [EventViewModel]) {
        self.eventModels = eventModels
        self.filteredEventModels = eventModels
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
        return filteredEventModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventsTableViewCell.className, for: indexPath) as! EventsTableViewCell
        if let eventModel = filteredEventModels[safe: indexPath.row] {
            cell.configure(with: eventModel)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let eventModel = filteredEventModels[safe: indexPath.row] {
            presenter?.handleEventSelection(with: eventModel)
        }
    }
    
}

//MARK: - SearchResults Methods
extension EventsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text , searchController.isActive {
            if searchText.isEmpty {
                filteredEventModels = eventModels
            } else {
                filteredEventModels = eventModels.filter{$0.eventName.contains(searchText)}
            }
            tableView.reloadData()
        }
    }
}

//MARK: - SearchBar Methods
extension EventsViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredEventModels = eventModels
        tableView.reloadData()
    }
}
