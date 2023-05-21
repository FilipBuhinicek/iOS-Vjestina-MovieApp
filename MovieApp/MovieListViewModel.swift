import Foundation

class MovieListViewModel {
    
    private let dataSource: DataSource
    
    init(dataSource: DataSource = DataSource()) {
        self.dataSource = dataSource
    }
}
