import Foundation
import MovieAppData
import PureLayout
import UIKit

class FavoritesViewController: UIViewController {
    private var router: AppRouter
        
    init(router: AppRouter) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
