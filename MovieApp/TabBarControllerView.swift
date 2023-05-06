import Foundation
import MovieAppData
import PureLayout
import UIKit

class TabBarControllerView: UIViewController, UITabBarControllerDelegate{
    private var myTabBarController: UITabBarController!
    
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
        myTabBarController = MyTabBarController()
        addChild(myTabBarController)
        view.addSubview(myTabBarController.view)
    }
    func styleViews(){
        
    }
    func defineLayoutForViews(){
        myTabBarController.didMove(toParent: self)
        myTabBarController.delegate = self
        tabBarController(myTabBarController, didSelect: MovieCategoriesViewController())
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            if tabBarController.selectedIndex == 0 {
                title = "Movie List"
            } else {
                title = nil
            }
    }
}

