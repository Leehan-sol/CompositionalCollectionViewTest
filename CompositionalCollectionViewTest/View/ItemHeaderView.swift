//
//  ItemHeaderView.swift
//  CompositionalCollectionViewTest
//
//  Created by hansol on 2024/02/21.
//

import UIKit

class ItemHeaderView: UICollectionReusableView {
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "테마가 있는"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subLabel: UILabel = {
        let label = UILabel()
        label.text = "추천여행"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUI() {
        addSubview(headerLabel)
        addSubview(subLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            subLabel.leadingAnchor.constraint(equalTo: headerLabel.trailingAnchor, constant: 5),
            subLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
