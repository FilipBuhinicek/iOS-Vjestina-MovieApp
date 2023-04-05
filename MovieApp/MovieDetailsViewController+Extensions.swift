//
//  MovieDetailsViewController+Extensions.swift
//  MovieApp
//
//  Created by endava-bootcamp on 05.04.2023..
//

import Foundation
import MovieAppData
import PureLayout
import UIKit

extension MovieDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        details?.crewMembers.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCell
        let data = details?.crewMembers[indexPath.item]
        cell.titleLabel.text = data?.name
        cell.subtitleLabel.text = data?.role
        return cell
    }
}
extension MovieDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 16
        let screenWidth = collectionView.bounds.width
        let cellWidth = (screenWidth - 4 * spacing) / 3
        let cellHeigth: CGFloat = 40
        return CGSize(width: cellWidth, height: cellHeigth)
    }
}
