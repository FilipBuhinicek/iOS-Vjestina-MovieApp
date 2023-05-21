import Foundation
import PureLayout
import UIKit
import MovieAppData

class AppRouter {

    private let navigationController: UINavigationController
    private let listNavigationController = UINavigationController()
    private let favoritesNavigationController = UINavigationController()
    
    init(with navigationController: UINavigationController){
        self.navigationController = navigationController
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func start() {
        let tabBarController = UITabBarController()

        let movieListViewController = createCategoriesController()
        listNavigationController.setViewControllers([movieListViewController], animated: false)
        let favoriteMoviesViewController = createFavoritesController()
        favoritesNavigationController.setViewControllers([favoriteMoviesViewController], animated: false)

        tabBarController.viewControllers = [listNavigationController, favoritesNavigationController]

        navigationController.setViewControllers([tabBarController], animated: false)
    }

    func goToMovieDetails(movie: MovieModel) {
        let movieDetailsViewController = MovieDetailsViewController(movieId: movie.id, router: self)
        
        listNavigationController.pushViewController(movieDetailsViewController, animated: true)
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

}
