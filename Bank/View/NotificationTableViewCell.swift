//
//  NotificationTableViewCell.swift
//  Bank
//
//  Created by 仲立 on 2023/7/31.
//  Copyright © 2023 仲立. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        statusView.layer.cornerRadius = 6
        
    }
    
    func setDate(notification: NotificationModel) {
        statusView.isHidden = notification.status
        titleLabel.text = notification.title
        timeLabel.text = notification.updateDateTime
        contactLabel.text = notification.message        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
