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
    
    var selectedEvent: EventViewModel?
    var guestModels = [GuestViewModel]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTitleView()
        setubTableView()
    }
    
    func setupTitleView() {
        navigationItem.titleView = titleStackView
        
        if let selectedEvent = self.selectedEvent {
            titleLabel.text = selectedEvent.event.name
        }
    }
    
    func setubTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 72
        tableView.register(UINib(nibName: GuestsTableViewCell.className, bundle: nil), forCellReuseIdentifier: GuestsTableViewCell.className)
    }

}

//MARK: - TableView DataSource&Delegate Methods
extension GuestsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guestModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GuestsTableViewCell.className, for: indexPath) as! GuestsTableViewCell
        if let eventModel = guestModels[safe: indexPath.row] {
            cell.configure(with: eventModel)
        }
        return cell
    }
    
}
