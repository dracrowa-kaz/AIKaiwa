//
//  ChatHistoryTableViewCell.swift
//  MagokoroButtonBeta
//
//  Created by 佐藤和希 on 2/3/17.
//  Copyright © 2017 kaz. All rights reserved.
//

import UIKit

class ChatHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var dataLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var contentTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(model:ChatRoomContentModel , isShowDate:Bool){
        if isShowDate {
            dataLabelHeight.constant = 50
        }
        contentTextLabel.text = model.chatContent
        contentTextLabel.sizeToFit()
    }
}
