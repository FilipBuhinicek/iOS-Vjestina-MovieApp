import Foundation
import MovieAppData
import PureLayout
import UIKit

class TabBarControllerView: UIViewController{
    private var router: AppRouter!
    
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
        router = AppRouter(with: self.navigationController!)
        router.setTabBarNavigation()
        self.navigationItem.title = "Movie List"
    }
    func styleViews(){
    }
    func defineLayoutForViews(){
    }
}

