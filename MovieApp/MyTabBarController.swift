import Foundation
import MovieAppData
import PureLayout
import UIKit

class MyTabBarController: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let favoriteMovies = FavoritesViewController()
        let movieList = MovieCategoriesViewController()
        
        let homeImage = UIImage(systemName: "house.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let emptyHomeImage = UIImage(systemName: "house")
        movieList.tabBarItem = UITabBarItem(title: "Movie List", image: emptyHomeImage, selectedImage: homeImage)
        movieList.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        let emptyFavoriteImage = UIImage(systemName: "heart")
        let favoriteImage = UIImage(systemName: "heart.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        favoriteMovies.tabBarItem = UITabBarItem(title: "Favorite", image: emptyFavoriteImage, selectedImage: favoriteImage)
        favoriteMovies.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        
        viewControllers = [movieList, favoriteMovies]
        
    }
    
    func handleGoToMovieDetials(movieId: Int){
        let detailsVC = MovieDetailsViewController(movieId: movieId)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
