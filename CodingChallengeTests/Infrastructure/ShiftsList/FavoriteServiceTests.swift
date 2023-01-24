@testable import CodingChallenge
import XCTest

final class FavoriteServiceTests: XCTestCase {

    func test_setFavorite() {
        let service = FavoriteUserDefaultsServiceStub()
        let sut = DefalutFavoriteService(service: service)

        sut.setFavorites([])

        XCTAssertEqual(service.setFavoritesCalled, [])
    }

    func test_setFavorite_calledWithCorrectValues() {
        let expectedValues = Set([1, 2])
        let service = FavoriteUserDefaultsServiceStub()
        let sut = DefalutFavoriteService(service: service)

        sut.setFavorites(expectedValues)

        XCTAssertEqual(service.setFavoritesCalled, expectedValues)
    }

    func test_getFavorites() {
        let expectedValues = Set([3, 4])
        let service = FavoriteUserDefaultsServiceStub()
        service.returnGetFavorites = expectedValues
        let sut = DefalutFavoriteService(service: service)

        XCTAssertEqual(sut.getFavorites(), expectedValues)
    }
}

final class FavoriteUserDefaultsServiceStub: FavoriteUserDefaultsService {
    var setFavoritesCalled: Set<Int>?
    var returnGetFavorites: Set<Int> = []

    func setFavorites(_ favorites: Set<Int>) {
        setFavoritesCalled = favorites
    }

    func getFavorites() -> Set<Int> {
        return returnGetFavorites
    }
}
