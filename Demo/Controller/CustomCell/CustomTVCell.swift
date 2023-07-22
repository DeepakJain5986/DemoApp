//
//  CustomTVCell.swift
//  Demo
//
//  Created by Deepak on 21/07/23.
//

import UIKit

class CustomTVCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    
    static var identifier: String { return String(describing: self) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
