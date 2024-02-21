//
//  CollectionViewCell.swift
//  CompositionalCollectionViewTest
//
//  Created by hansol on 2024/02/04.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    let titleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleToFill
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setUI() {
        addSubview(titleButton)

        NSLayoutConstraint.activate([
            titleButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }

}
