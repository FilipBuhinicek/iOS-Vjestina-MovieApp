import Foundation
import PureLayout
import UIKit
import MovieAppData

class AppRouter: NSObject, UITabBarControllerDelegate{

    private let navigationController: UINavigationController!
    
    init(with navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func setTabBarNavigation() {
        let tabBarController = UITabBarController()
        tabBarController.delegate = self

        let movieListViewController = createCategoriesController()
        let favoriteMoviesViewController = createFavoritesController()

        tabBarController.viewControllers = [movieListViewController, favoriteMoviesViewController]

        navigationController.setViewControllers([tabBarController], animated: false)
    }

    func goToMovieDetails(movie: MovieModel) {
        let movieDetailsViewController = MovieDetailsViewController(movieId: movie.id, router: self)
        
        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }

    private func createFavoritesController() -> UIViewController {
        let favoriteMovies = FavoritesViewController(router: self)

        let emptyFavoriteImage = UIImage(systemName: "heart")
        let favoriteImage = UIImage(systemName: "heart.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        favoriteMovies.tabBarItem = UITabBarItem(title: "Favorite", image: emptyFavoriteImage, selectedImage: favoriteImage)
        favoriteMovies.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)

        return favoriteMovies
    }

    private func createCategoriesController() -> UIViewController {
        let movieList = MovieCategoriesViewController(router: self)
        let homeImage = UIImage(systemName: "house.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let emptyHomeImage = UIImage(systemName: "house")
        movieList.tabBarItem = UITabBarItem(title: "Movie List", image: emptyHomeImage, selectedImage: homeImage)
        movieList.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        
        return movieList
    }
 
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let navigationController = tabBarController.navigationController {
            if tabBarController.selectedIndex == 0 {
                navigationController.navigationBar.topItem?.title = "Movie List"
            } else {
                navigationController.navigationBar.topItem?.title = nil
            }
        }
    }
}
