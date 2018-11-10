//
//  RecomendationCollectionViewCell.swift
//  Next02
//
//  Created by Valmir Junior on 03/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

class RecomendationCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func prepare(with movie: Movie) {
        self.posterImageView.image = UIImage(named: movie.image ?? "")
        self.titleLabel.text = movie.title
    }
    
}
