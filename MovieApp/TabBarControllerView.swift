import Foundation
import MovieAppData
import PureLayout
import UIKit

class TabBarControllerView: UIViewController{
    var router: AppRouter
    
    init(router: AppRouter) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }
    
    func buildViews(){
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews(){
        router.setTabBarNavigation()
        self.navigationItem.title = "Movie List"
    }
    func styleViews(){
    }
    func defineLayoutForViews(){
    }
}

