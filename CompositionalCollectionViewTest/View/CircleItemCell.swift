//
//  CircleItemCell.swift
//  CompositionalCollectionViewTest
//
//  Created by hansol on 2024/02/21.
//

import UIKit

class CircleItemCell: UICollectionViewCell {
    let circleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "호텔1")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let circleItemLabel: UILabel = {
        let label = UILabel()
        label.text = "아이템"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        makeImageViewCircular()
    }


    private func setUI() {
        addSubview(circleImageView)
        addSubview(circleItemLabel)

        NSLayoutConstraint.activate([
            circleImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            circleImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            circleImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            circleImageView.heightAnchor.constraint(equalTo: circleImageView.widthAnchor),
            
            circleItemLabel.topAnchor.constraint(equalTo: circleImageView.bottomAnchor, constant: 10),
            circleItemLabel.centerXAnchor.constraint(equalTo: circleImageView.centerXAnchor),
            circleItemLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }

    func makeImageViewCircular() {
        circleImageView.layer.cornerRadius = circleImageView.frame.height / 2
    }
    

}



