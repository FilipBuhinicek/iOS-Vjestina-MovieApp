import Foundation
import UIKit

class MovieDetailsViewModel {

    private let dataSource: DataSource
    //private let movieUseCase: MovieUseCaseProtocol
    private let dateFormatter: DateFormatter
    private var movieDetails: MovieDetails?

    init(dataSource: DataSource = DataSource(), dateFormatter: DateFormatter = DateFormatter()) {
        self.dataSource = dataSource
        self.dateFormatter = dateFormatter
    }
    
    func loadMovieDetails(movieId: Int) {
        //movieDetails = movieUseCase.getDetails(id: movieId)
        dataSource.fetchMovieDetails(for: movieId) { result in
            switch result {
            case .success(let details):
                self.movieDetails = details
                
            case .failure(_): break
            }
        }
    }

    var imageURL: String? {
        movieDetails?.imageUrl
    }

    var movieRatings: String {
        String(Double(movieDetails?.rating ?? 0.0))
    }

    var movieName: String? {
        movieDetails?.name
    }

    var releaseDate: String? {
        dateFormatter.dateFormat = "yyyy-MM-dd"

        guard let releaseDate = movieDetails?.releaseDate,
              let date = dateFormatter.date(from: releaseDate)
        else { return nil }

        dateFormatter.dateFormat = "MM/dd/yyyy"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate + " (US)"
    }

    var duration: String {
        var string = ""
        let length: Int = movieDetails?.categories.count ?? 0
        for i in 0..<length {
            if movieDetails?.categories[i] == MovieCategoryModel.action.rawValue {
                string = string + "Action, "
            }
            if movieDetails?.categories[i] == MovieCategoryModel.adventure.rawValue {
                string = string + "Adventure, "
            }
            if movieDetails?.categories[i] == MovieCategoryModel.comedy.rawValue {
                string = string + "Comedy, "
            }
            if movieDetails?.categories[i] == MovieCategoryModel.crime.rawValue {
                string = string + "Crime, "
            }
            if movieDetails?.categories[i] == MovieCategoryModel.drama.rawValue {
                string = string + "Drama, "
            }
            if movieDetails?.categories[i] == MovieCategoryModel.fantasy.rawValue {
                string = string + "Fantasy, "
            }
            if movieDetails?.categories[i] == MovieCategoryModel.romance.rawValue {
                string = string + "Romance, "
            }
            if movieDetails?.categories[i] == MovieCategoryModel.scienceFiction.rawValue {
                string = string + "Science fiction, "
            }
            if movieDetails?.categories[i] == MovieCategoryModel.thriller.rawValue {
                string = string + "Thriller, "
            }
            if movieDetails?.categories[i] == MovieCategoryModel.western.rawValue {
                string = string + "Western, "
            }
        }
        let duration = formatTime(minutes: movieDetails?.duration ?? 0)

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
        movieDetails?.summary
    }

    var crewMembers: Int {
        movieDetails?.crewMembers.count ?? 0
    }

    func crewMember(at indexPath: IndexPath) -> CrewMemberConfig? {
        (movieDetails?.crewMembers[indexPath.item])
            .map(CrewMemberConfig.init(crewMember:))
    }
}

struct CrewMemberConfig {
    let crewMember: MovieCrewMemberModel
    var name: String { crewMember.name }
    var role: String { crewMember.role }
}
