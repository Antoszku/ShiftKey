@testable import CodingChallenge

final class ShiftsListInteractorStub: ShiftsListInteractor {
    var setFavoriteCalled: Set<Int>?
    var getShiftsCalled: (ShiftFilter.ShiftType, String)?
    var returnShifts = [ShiftsForDatePresentable]()
    var getFavoritesCalled = false
    var returnSetFavorites = Set<Int>()

    func getShifts(type: ShiftFilter.ShiftType, address: String) async throws -> [CodingChallenge.ShiftsForDatePresentable] {
        getShiftsCalled = (type, address)
        return returnShifts
    }
    
    func setFavorites(_ favorites: Set<Int>) {
        setFavoriteCalled = favorites
    }
    
    func getFavorites() -> Set<Int> {
        getFavoritesCalled = true
        return returnSetFavorites
    }
}
