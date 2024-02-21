//
//  ProductCell.swift
//  CompositionalCollectionViewTest
//
//  Created by hansol on 2024/02/04.
//

import UIKit

class ProductCell: UICollectionViewCell {
    let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let contentTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let starLabel: UILabel = {
        let label = UILabel()
        label.text = "⭐️"
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "평점"
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let reviewCountLabel: UILabel = {
        let label = UILabel()
        label.text = "(2,263)"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.gray
        return label
    }()
    
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "위치"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "169,400"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
         let stackView = UIStackView()
         stackView.axis = .horizontal
         stackView.spacing = 3
         stackView.alignment = .leading
         stackView.translatesAutoresizingMaskIntoConstraints = false
         return stackView
     }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setUI() {
        addSubview(productImageView)
        addSubview(contentTitleLabel)
        addSubview(stackView)
        addSubview(locationLabel)
        addSubview(priceLabel)
        
        stackView.addArrangedSubview(starLabel)
        stackView.addArrangedSubview(ratingLabel)
        stackView.addArrangedSubview(reviewCountLabel)
        
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            productImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            productImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            
            contentTitleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 10),
            contentTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            contentTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentTitleLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            locationLabel.topAnchor.constraint(equalTo: stackView.topAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 10),
            locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(equalTo: contentTitleLabel.trailingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        
    }
    
}

