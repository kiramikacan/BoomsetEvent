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
        
        let presenter = GuestsPresenter()
        let iterator = GuestsInteractor(apiWorker: GuestsApiWorker(), cacher: GuestsCacher())
        
        presenter.view = controller
        presenter.interactor = iterator
        iterator.presenter = presenter
        controller.presenter = presenter
        
        return controller
    }
}

//MARK: - Class Base Methods & Properties
class GuestsViewController: UIViewController {

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
        label.text = "Guests (0)"
        return label
    }()
    
    lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 2.0
        return stackView
    }()
    
    var viewMore: ViewMore!
    var isLoading = false {
        didSet {
            if isLoading {
                viewMore.startAnimating()
                self.tableView.tableFooterView = viewMore
            } else {
                viewMore.stopAnimating()
                self.tableView.tableFooterView = UIView(frame: .zero)
            }
        }
    }
    
    var selectedEvent: EventViewModel?
    var guestModels = [GuestViewModel]()
    var filteredGuestModels = [GuestViewModel]()
    
    var nextUrl: String? = nil
    var presenter: GuestsPresenterProtocol?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTitleView()
        setupSearchBar()
        setupViewMore()
        setubTableView()
    }
    
    func setupTitleView() {
        navigationItem.titleView = titleStackView
        
        if let selectedEvent = self.selectedEvent {
            titleLabel.text = selectedEvent.eventName
        }
    }
    
    func setupSearchBar()  {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    func setupViewMore() {
        // footer for load more
        viewMore = ViewMore(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 44))
        viewMore.setBackground(color: UIColor.clear)
        isLoading = false
    }
    
    func setubTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 208
        tableView.register(UINib(nibName: GuestsTableViewCell.className, bundle: nil), forCellReuseIdentifier: GuestsTableViewCell.className)
        
        fetchGuests()
    }
    
    func fetchGuests() {
        if let selectedEvent = self.selectedEvent {
            presenter?.fetchGuests(with: selectedEvent.eventId, nextUrl: nil)
        }
    }

    func fetchMoreGuests() {
        
        // dont fetch more data when user searching
        if let searchText = searchController.searchBar.text, searchText.isEmpty == false {
            return
        }
        
        guard let selectedEvent = self.selectedEvent else { return }
        
        guard let nextUrl = self.nextUrl else { return }
        
        if !isLoading {
            DispatchQueue.main.async {
                self.isLoading = true
                self.presenter?.fetchGuests(with: selectedEvent.eventId, nextUrl: nextUrl)
            }
        }
    }
    
    func updateGuestCount() {
        self.subtitleLabel.text = "Guests (\(guestModels.count))"
    }
    
}

//MARK: - Protocol Methods
extension GuestsViewController: GuestsViewProtocol {
    
    func showMoreGuestModels(_ guests: [GuestViewModel], next: String?) {
        self.nextUrl = next
        for guest in guests {
            self.guestModels.append(guest)
        }
        self.filteredGuestModels = guestModels
        self.tableView.reloadData()
        
        if self.isLoading {
            self.isLoading = false
        }
        
        self.updateGuestCount()
    }
    
    func showGuestModels(_ guestModels: [GuestViewModel], next: String?) {
        
        self.nextUrl = next
        
        self.guestModels = guestModels
        self.filteredGuestModels = guestModels
        
        self.tableView.reloadData()
        
        self.updateGuestCount()
    }
    
    func showProggress() {
        self.displayProgress()
    }
    
    func closeProggress() {
        self.dismissProgress()
        
        if self.isLoading {
            self.isLoading = false
        }
    }
}

//MARK: - TableView DataSource&Delegate Methods
extension GuestsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGuestModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GuestsTableViewCell.className, for: indexPath) as! GuestsTableViewCell
        if let eventModel = filteredGuestModels[safe: indexPath.row] {
            cell.configure(with: eventModel)
        }
        return cell
    }
    
}

//MARK: - Scroll Delegate Methods
extension GuestsViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if maximumOffset < 0 { return }
        if currentOffset > maximumOffset {
            fetchMoreGuests()
        }
    }
}

//MARK: - SearchResults Methods
extension GuestsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text , searchController.isActive {
            if searchText.isEmpty {
                filteredGuestModels = guestModels
            } else {
                filteredGuestModels = guestModels.filter{$0.getSearchableText().contains(searchText)}
            }
            tableView.reloadData()
        }
    }
}

//MARK: - SearchBar Methods
extension GuestsViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredGuestModels = guestModels
        tableView.reloadData()
    }
}
