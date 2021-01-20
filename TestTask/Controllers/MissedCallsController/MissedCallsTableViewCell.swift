//
//  MissedCallsTableViewCell.swift
//  TestTask
//
//  Created by Stanislav Slipchenko on 15.01.2021.
//

import UIKit

class MissedCallsTableViewCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var dataView: UIView!
    
    @IBOutlet weak var callIconImageView: UIImageView!
    @IBOutlet weak var callDurationLabel: UILabel!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactAddressLabel: UILabel!
    @IBOutlet weak var dateOfCallLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        
        callIconImageView.image = nil
        callDurationLabel.text = nil
        contactNameLabel.text = nil
        contactAddressLabel.text = nil
        dateOfCallLabel.text = nil
    }
}
