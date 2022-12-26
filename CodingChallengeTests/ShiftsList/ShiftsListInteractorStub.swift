@testable import CodingChallenge

final class ShiftsListInteractorStub: ShiftsListInteractor {
    var getShiftsCalled = false

    func getShifts() async -> [ShiftsForDatePresentable] {
        getShiftsCalled = true
        return []
    }
}
