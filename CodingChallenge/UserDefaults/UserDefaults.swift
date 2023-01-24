import Foundation

protocol FavoriteUserDefaultsService {
    func setFavorites(_ favorites: Set<Int>)
    func getFavorites() -> Set<Int>
}

struct UserDefaultsName {
    static let favoritesShifts = "favoritesShifts"
}

final class DefaultFavoriteUserDefaultsService: FavoriteUserDefaultsService {

    private let userDefaults: FooUserDefaults

    init(userDefaults: FooUserDefaults = DefaultFooUserDefaults()) {
        self.userDefaults = userDefaults
    }

    func setFavorites(_ favorites: Set<Int>) {
        let arrayFavorites = Array(favorites)
        UserDefaults.standard.set(arrayFavorites, forKey: UserDefaultsName.favoritesShifts)
    }

    func getFavorites() -> Set<Int> {
        guard let favorites = userDefaults.get(forKey: UserDefaults.k)

        return Set(favorites)
    }
}

protocol FooUserDefaults {
    func set(_ array: [Any], forKey key: String)
    func get(forKey: String) -> Any?
    func get(forKey key: String) -> [Int]?
}

class DefaultFooUserDefaults {
    func set(_ array: [Any], forKey key: String) {
        UserDefaults.standard.set(array, forKey: key)
    }

    func get(forKey key: String) -> [Int]? {
        return UserDefaults.standard.object(forKey: key) as? [Int]
    }

    func get(forKey key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
}
