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

    var duration: String {
        var string = ""
        let length: Int = movieDetails.categories.count ?? 0
        for i in 0..<length {
            if movieDetails.categories[i] == MovieCategoryModel.action.rawValue {
                string = string + "Action, "
            }
            if movieDetails.categories[i] == MovieCategoryModel.adventure.rawValue {
                string = string + "Adventure, "
            }
            if movieDetails.categories[i] == MovieCategoryModel.comedy.rawValue {
                string = string + "Comedy, "
            }
            if movieDetails.categories[i] == MovieCategoryModel.crime.rawValue {
                string = string + "Crime, "
            }
            if movieDetails.categories[i] == MovieCategoryModel.drama.rawValue {
                string = string + "Drama, "
            }
            if movieDetails.categories[i] == MovieCategoryModel.fantasy.rawValue {
                string = string + "Fantasy, "
            }
            if movieDetails.categories[i] == MovieCategoryModel.romance.rawValue {
                string = string + "Romance, "
            }
            if movieDetails.categories[i] == MovieCategoryModel.scienceFiction.rawValue {
                string = string + "Science fiction, "
            }
            if movieDetails.categories[i] == MovieCategoryModel.thriller.rawValue {
                string = string + "Thriller, "
            }
            if movieDetails.categories[i] == MovieCategoryModel.western.rawValue {
                string = string + "Western, "
            }
        }
        let duration = formatTime(minutes: movieDetails.duration ?? 0)

        string = string.trimmingCharacters(in: [" ", ","])
        string.append(" ")
        string.append(duration)

        return string
    }

    private func formatTime(minutes: Int) -> String {
        let hours = minutes / 60
        let minute = minutes % 60
        return String(format: "%2dh %2dm", hours,minute)
    }

    var summary: String? {
        movieDetails.summary
    }

    var crewMembers: Int {
        movieDetails.crewMembers.count
    }
}

struct CrewMemberConfig {
    let crewMember: CrewMember
    var name: String { crewMember.name }
    var role: String { crewMember.role }
}

// MARK: - Navigation
extension MovieDetailsViewModel {
    func pop() {
        router.goBack()
    }
}
