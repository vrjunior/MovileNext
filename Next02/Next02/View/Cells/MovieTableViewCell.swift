//
//  MovieTableViewCell.swift
//  Next02
//
//  Created by Valmir Junior on 03/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    // MARK - IBOutlets
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sinopseLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    // MARK - Super methods
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func prepare(with movie: Movie) {

        self.titleLabel.text = movie.title
        self.sinopseLabel.text = movie.sinopse
        self.ratingLabel.text = String(movie.rating ?? 0)
        self.posterImageView.image = UIImage(named: movie.image ?? "")
    }
}
