//
//  ViewController.swift
//  MovieApp
//
//  Created by endava-bootcamp on 28.03.2023..
//

import UIKit
import MovieAppData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let details = MovieUseCase().getDetails(id: 111161)
    }


}

