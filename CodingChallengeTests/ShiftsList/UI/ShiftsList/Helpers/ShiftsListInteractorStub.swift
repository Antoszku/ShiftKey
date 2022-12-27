@testable import CodingChallenge

final class ShiftsListInteractorStub: ShiftsListInteractor {
    var getShiftsCalled = false
    var returnShifts = [ShiftsForDatePresentable]()

    func getShifts() async -> [ShiftsForDatePresentable] {
        getShiftsCalled = true
        return returnShifts
    }
}
