//
//  EventsTableViewCell.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {

    static let className = "EventsTableViewCell"
    
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with eventModel: EventViewModel) {
        eventNameLabel.text = eventModel.eventName
        
        eventDateLabel.text = "\(eventModel.getStartDateString()) - \(eventModel.getEndDateString())"
    }
    
}
