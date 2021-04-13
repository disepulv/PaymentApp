//
//  CardIssuerViewCell.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//

import UIKit
import Kingfisher

class CardIssuerViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    
    var cardIssuer: CardIssuers.CardIssuer.Result! {
        willSet(newValue) {
            self.cardIssuer = newValue
        }
        didSet {
            self.configure()
        }
    }
    
    public func configure() {
        let colorView = UIView()
        colorView.backgroundColor = Constants.Colors.defaultBGColor
        selectedBackgroundView = colorView
        backgroundColor = Constants.Colors.defaultCellBGColor
        
        nameLabel.text = cardIssuer.name
        
        logoImageView.contentMode = .scaleAspectFit
        guard let secureThumbnail = cardIssuer.secureThumbnail, !secureThumbnail.isEmpty else {
            logoImageView.image = Constants.Images.defaultCard
            return
        }
        
        let logo = URL(string: secureThumbnail)
        let resource = ImageResource(downloadURL: logo!, cacheKey: secureThumbnail)
        logoImageView.kf.setImage(with: resource,
                                  placeholder: Constants.Images.defaultCard,
                                  options: [.transition(.fade(1))],
                                  progressBlock: nil) { result in
        }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
