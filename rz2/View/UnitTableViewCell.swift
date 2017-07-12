//
//  UnitTableViewCell.swift
//  rz2
//
//  Created by Fabrício Sperotto Sffair on 2017-07-12.
//  Copyright © 2017 Fabrício Sperotto Sffair. All rights reserved.
//
//  Célula contendo o nome da unidade
//

import UIKit

class UnitTableViewCell: UITableViewCell {

    var name: String? {
        didSet {
            self.setupUI()
        }
    }
    @IBOutlet weak var unitNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        self.unitNameLabel.text = self.name
    }
}
