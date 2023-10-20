//
//  AccountSummaryCell.swift
//  Bankey
//
//  Created by Diego Sierra on 11/10/23.
//

import UIKit


class AccountSummaryCell: UITableViewCell {
    
    /*   By keeping the enum and the ViewModel struct inside of the AccountSummaryCell class, you're basically telling the reader of this code that you'd like them to know that these data types are VERY specific to the AccountSummaryCell class; i.e. they should only be reused for this type of cell. You could declare them in a separate file but this is more ideal. */
    
    enum AccountType: String {
        case Banking
        case CreditCard = "Credit Card"
        case Investment
    }
    
    struct ViewModel {
        let accountType: AccountType
        let accountName: String
    }
    
    let viewModel: ViewModel? = nil
    
    let typeLabel = UILabel()
    let nameLabel = UILabel()
    let divider = UIView()
    let balanceStackView = UIStackView()
    let balanceLabel = UILabel()
    let balanceAmountLabel = UILabel()
    let chevronImageView = UIImageView(image: UIImage(systemName: "chevron.right")?.withTintColor(appColor, renderingMode: .alwaysOriginal))
    
    static let reuseID = "AccountSummaryCell"
    static let rowHeight = CGFloat(112)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AccountSummaryCell {
    private func setup() {
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        typeLabel.adjustsFontForContentSizeCategory = true
        typeLabel.text = "Account type"
        contentView.addSubview(typeLabel) // If you don't do so in this way, and you follow the traditional 'addSubview(view)' method, things might not work right. This is how you do it for UITableViewCells
        
        divider.backgroundColor = appColor
        divider.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(divider)
        
        nameLabel.text = "Account Name"
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        contentView.addSubview(nameLabel)
        
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.text = "Some balance"
        balanceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        balanceLabel.textAlignment = .right
        
        balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceAmountLabel.attributedText = makeFormattedBalance(dollars: "929,466", cents: "56")
        balanceAmountLabel.textAlignment = .right
        
        balanceStackView.translatesAutoresizingMaskIntoConstraints = false
        balanceStackView.addArrangedSubview(balanceLabel)
        balanceStackView.addArrangedSubview(balanceAmountLabel)
        balanceStackView.axis = .vertical
        balanceStackView.spacing = 0
        contentView.addSubview(balanceStackView)
        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(chevronImageView)
        
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2 /* i.e. 16 */),
            typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            divider.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1),
            divider.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            divider.heightAnchor.constraint(equalToConstant: 4),
            divider.widthAnchor.constraint(equalToConstant: 60),
            
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: divider.bottomAnchor, multiplier: 2),
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            trailingAnchor.constraint(equalToSystemSpacingAfter: balanceStackView.trailingAnchor, multiplier: 4),
            balanceStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: nameLabel.trailingAnchor, multiplier: 0.5),
            balanceStackView.topAnchor.constraint(equalToSystemSpacingBelow: divider.topAnchor, multiplier: 0),
            
            chevronImageView.topAnchor.constraint(equalToSystemSpacingBelow: divider.topAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: chevronImageView.trailingAnchor, multiplier: 1)
        ])
    }
    
    
    //    A way to cutomise any kind of String in your app. Really useful for giving unique styles to text in your app. There are many attributes that you can experiment with.
    private func makeFormattedBalance(dollars: String, cents: String) -> NSMutableAttributedString {
        let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]
        
        let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
        let dollarString = NSMutableAttributedString(string: dollars, attributes: dollarAttributes)
        let centString = NSMutableAttributedString(string: cents, attributes: centAttributes)
        
        rootString.append(dollarString)
        rootString.append(centString)
        
        return rootString
    }
    
}

extension AccountSummaryCell {
    func configure(with vm: ViewModel) {
        typeLabel.text = vm.accountType.rawValue
        nameLabel.text = vm.accountName
        
        switch vm.accountType {
        case .Banking:
            divider.backgroundColor = appColor
            balanceLabel.text = "Current Balance"
        case .CreditCard:
            divider.backgroundColor = .systemOrange
            balanceLabel.text = "Current Balance"
        case .Investment:
            divider.backgroundColor = .systemPurple
            balanceLabel.text = "Value"
        }
    }
}



