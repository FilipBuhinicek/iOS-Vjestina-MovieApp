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
        
        titleLabel.autoPinEdge(toSuperviewEdge: .top)
        titleLabel.autoPinEdge(toSuperviewEdge: .leading)
        titleLabel.autoPinEdge(toSuperviewEdge: .trailing)
        
        
        subtitleLabel.autoPinEdge(toSuperviewEdge: .leading)
        subtitleLabel.autoPinEdge(toSuperviewEdge: .trailing)
        subtitleLabel.autoPinEdge(.top, to: .bottom, of: titleLabel)
        subtitleLabel.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
}
