//
//  DetailsTableViewController.swift
//  BreakingBad
//
//  Created by Kevin Reid on 10/12/2020.
//

import UIKit

class DetailsTableViewController: UITableViewController {
    var person: Details?
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var occupationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var appearanceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setup()
    }
    
    
    func setup() {
        tableView.allowsSelection = false
        hideTableViewSeparator()
        displayPersonDetails()
    }
    
    func displayPersonDetails() {
        image.sd_setImage(with:URL(string: person!.img),placeholderImage:#imageLiteral(resourceName: "PleaseWaitImageLoading.gif"), options: [.continueInBackground, .progressiveLoad])
        nameLabel.text = person?.name
        occupationLabel.text = "Occupation: "
        statusLabel.text = "Status: "+person!.status
        nicknameLabel.text = "Nickname: "+person!.nickname
        
        for index in 0...((person?.occupation.count)!) - 1 {
            occupationLabel.text! += "\n\u{2022}" + (person?.occupation[index])!
        }
        
        getAppearance()
    }
    
    func getAppearance() {
        if let apperance = person?.appearance {
            var comma: String = ","
            var i = 0
            for series in apperance  {
                i+=1
                if i >= apperance.count {
                    comma = ""
                }
                appearanceLabel.text!  += " " + String((series)) + comma
            }
        }
    }
    
    func hideTableViewSeparator() {
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }

}
