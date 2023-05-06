import Foundation
import MovieAppData
import PureLayout
import UIKit

class FavoritesViewController: UIViewController {
    func buildView() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
    }
    
    func createViews() {
    }
    
    func styleViews() {
        view.backgroundColor = .white
    }
    
    func defineLayoutForViews() {}
}
