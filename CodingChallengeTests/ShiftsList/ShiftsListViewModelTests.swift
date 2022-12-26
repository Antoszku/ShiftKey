import XCTest
@testable import CodingChallenge

final class ShiftsListViewModelTests: XCTestCase {
    func test_onAppear_callInteractorGetShifts() async {
        let interactor = ShiftsListInteractorStub()
        let sut = ShiftsListViewModel(interactor: interactor)

        await sut.onAppear()

        XCTAssertTrue(interactor.getShiftsCalled)
    }
}
