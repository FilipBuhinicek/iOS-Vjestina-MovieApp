import Foundation
import UIKit
import Combine

class MovieDetailsViewModel: ObservableObject {

    private let dataSource: DataSource
    private let dateFormatter: DateFormatter
    @Published var movieDetails: MovieDetails = MovieDetails(categories: ["a", "b"], crewMembers: [CrewMember(name: "Filip", role: "ios")], duration: 1, id: 0, imageUrl: "", name: "", rating: 1, releaseDate: "", summary: "", year: 1)
    private var cancellables: Set<AnyCancellable> = []

    private var router: AppRouter
        
    init(router: AppRouter, dataSource: DataSource = DataSource(), dateFormatter: DateFormatter = DateFormatter()) {
        self.router = router
        self.dataSource = dataSource
        self.dateFormatter = dateFormatter
    }
    
    func loadMovieDetails(movieId: Int) {
            dataSource.fetchMovieDetails(for: movieId)
                .sink { [weak self] completion in
                    guard case let .failure(error) = completion else { return }
                    // Handle error
                    print("Failed to fetch movie details:", error)
                } receiveValue: { [weak self] movieDetails in
                    guard let self else { return }

                    self.movieDetails = movieDetails
                }
                .store(in: &cancellables)
        }

    var movieRatings: String {
        String(Double(movieDetails.rating ?? 0.0))
    }

    var movieName: String? {
        movieDetails.name
    }

    var releaseDate: String? {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: movieDetails.releaseDate)

        dateFormatter.dateFormat = "MM/dd/yyyy"
        let formattedDate = dateFormatter.string(from: date ?? Date())
        return formattedDate + " (US)"
    }

    

    var summary: String? {
        movieDetails.summary
    }

    var crewMembers: Int {
        movieDetails.crewMembers.count
    }
}

// MARK: - Navigation
extension MovieDetailsViewModel {
    func pop() {
        router.goBack()
    }
}
