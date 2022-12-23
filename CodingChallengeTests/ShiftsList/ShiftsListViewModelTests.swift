import XCTest
@testable import CodingChallenge

class ShiftsListViewModelTests: XCTestCase {
    func test_onAppear_callInteractorGetShifts() async {
        let interactor = ShiftsListInteractorStub()
        let sut = ShiftsListViewModel(interactor: interactor)

        await sut.onAppear()

        XCTAssertTrue(interactor.getShiftsCalled)
    }
}

class ShiftsListInteractorStub: ShiftsListInteractor {
    var getShiftsCalled = false

    func getShifts() async -> ShiftsForDatePresentable {
        getShiftsCalled = true
        return ShiftsForDatePresentable()
    }
}
