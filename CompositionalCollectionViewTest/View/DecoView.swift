//
//  DecoView.swift
//  CompositionalCollectionViewTest
//
//  Created by hansol on 2024/02/21.
//

import UIKit

class DecoView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUI() {
        self.backgroundColor = .systemGray6
    }
}
