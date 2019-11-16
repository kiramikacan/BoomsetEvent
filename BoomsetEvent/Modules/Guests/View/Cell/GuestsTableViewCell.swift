//
//  GuestsTableViewCell.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import UIKit

class GuestsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var cellPhoneLabel: UILabel!
    @IBOutlet weak var workPhoneLabel: UILabel!
    
    static let className = "GuestsTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .none
        
        setupProfileImageUI()
    }

    func setupProfileImageUI() {
        profileImageView.roundCorners(radius: profileImageView.frame.size.height/2, borderWidth: 1)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with guestModel: GuestViewModel) {
        
        profileImageView.loadProfileImageWith(url: guestModel.profileImageUrl)
        
        fullNameLabel.text = guestModel.getFullName()
        jobTitleLabel.text = guestModel.jobTitle
        companyLabel.text = guestModel.company
        mailLabel.text = guestModel.email
        phoneLabel.text = guestModel.phone
        cellPhoneLabel.text = guestModel.cellPhone
        workPhoneLabel.text = guestModel.workPhone
    }
    
}
