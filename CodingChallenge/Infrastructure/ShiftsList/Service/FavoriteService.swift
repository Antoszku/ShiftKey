protocol FavoriteService {
    func setFavorites(_ favorites: Set<Int>)
    func getFavorites() -> Set<Int>
}

final class DefalutFavoriteService: FavoriteService {
    private let service: FavoriteUserDefaultsService

    init(service: FavoriteUserDefaultsService = DefaultFavoriteUserDefaultsService()) {
        self.service = service
    }

    func setFavorites(_ favorites: Set<Int>) {
        service.setFavorites(favorites)
    }
    
    func getFavorites() -> Set<Int> {
        return service.getFavorites()
    }
}
