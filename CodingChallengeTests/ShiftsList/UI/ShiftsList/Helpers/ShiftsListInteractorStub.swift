@testable import CodingChallenge

final class ShiftsListInteractorStub: ShiftsListInteractor {
    var getShiftsCalled: (ShiftFilter.ShiftType, String)?
    var returnShifts = [ShiftsForDatePresentable]()

    func getShifts(type: ShiftFilter.ShiftType, address: String) async throws -> [CodingChallenge.ShiftsForDatePresentable] {
        getShiftsCalled = (type, address)
        return returnShifts
    }
}
