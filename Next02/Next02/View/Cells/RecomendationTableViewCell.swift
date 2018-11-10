//
//  RecomendationTableViewCell.swift
//  Next02
//
//  Created by Valmir Junior on 03/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

class RecomendationTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: RecomendationCollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func prepare(with items: [Movie]) {
        self.collectionView.recomendations = items
    }
}
