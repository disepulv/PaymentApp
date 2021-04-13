//
//  InstallmentViewCell.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//

import UIKit

class InstallmentViewCell: UITableViewCell {

    @IBOutlet weak var recommendedMessageLabel: UILabel!
    
    var installment: Installments.Installment.PayerCost! {
        willSet(newValue) {
            self.installment = newValue
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
        
        recommendedMessageLabel.text = installment.recommendedMessage
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
