//
//  TableViewCell.swift
//  BreakingBad
//
//  Created by Kevin Reid on 10/12/2020.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func cell(details: Details) {
        nameLabel.text = details.name
        myImage.sd_setImage(with:URL(string: details.img),placeholderImage:#imageLiteral(resourceName: "PleaseWaitImageLoading.gif"), options: [.continueInBackground, .progressiveLoad])
    }

}
