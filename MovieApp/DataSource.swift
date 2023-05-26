import Foundation
import Combine

class DataSource {
    let baseURL = "https://five-ios-api.herokuapp.com/api/v1/movie/"
    let token = "Zpu7bOQYLNiCkT32V3c9BPoxDMfxisPAfevLW6ps"
    
    func fetchMovieDetails(for id: Int) -> AnyPublisher<MovieDetails, Error> {
        let url = URL(string: "\(baseURL)\(id)/details")!
        var request = URLRequest(url: url)
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: MovieDetails.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

struct MovieDetails: Codable {
    let categories: [String]
    let crewMembers: [CrewMember]
    let duration: Int
    let id: Int
    let imageUrl: String
    let name: String
    let rating: Double
    let releaseDate: String
    let summary: String
    let year: Int
}

struct CrewMember: Codable {
    let name: String
    let role: String
}

public enum MovieCategoryModel: String, Equatable {

    case action
    case adventure
    case comedy
    case crime
    case drama
    case fantasy
    case romance
    case scienceFiction
    case thriller
    case western

}

public struct MovieCrewMemberModel: Equatable, Codable {
    public let name: String
    public let role: String
}
