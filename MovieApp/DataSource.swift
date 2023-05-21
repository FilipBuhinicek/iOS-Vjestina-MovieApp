import Foundation

class DataSource {
    let baseURL = "https://five-ios-api.herokuapp.com/api/v1/movie/"
    let token = "Bearer Zpu7bOQYLNiCkT32V3c9BPoxDMfxisPAfevLW6ps"
    
    func fetchMovieDetails(for id:Int,
                           completion: @escaping(Result<MovieDetails,Error>)->Void){
        let urlString = baseURL + "\(id)/details"
        guard let url = URL(string: urlString)
        else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.addValue(token, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request){
            data,response,error in if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let movieDetails = try decoder.decode(MovieDetails.self, from: data)
                    completion(.success(movieDetails))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
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

public enum MovieCategoryModel: String,Equatable {

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

public struct MovieCrewMemberModel: Equatable,Codable {

    public let name: String
    public let role: String

}
