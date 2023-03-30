//
//  MyCell.swift
//  MovieApp
//
//  Created by endava-bootcamp on 30.03.2023..
//

import Foundation
import MovieAppData
import PureLayout

class MyCell: UICollectionViewCell {
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 12)
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = .black
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        
        let spacing: CGFloat = 16
        let labelWidth = (contentView.bounds.width - spacing * 4)/3
        
        titleLabel.autoPinEdge(toSuperviewEdge: .top)
        titleLabel.autoPinEdge(toSuperviewEdge: .leading)
        subtitleLabel.autoPinEdge(toSuperviewEdge: .leading)
        subtitleLabel.autoPinEdge(.top, to: .bottom, of: titleLabel)
        titleLabel.autoSetDimensions(to: CGSize(width: labelWidth, height: 20))
        subtitleLabel.autoSetDimensions(to: CGSize(width: labelWidth, height: 20))
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
}
