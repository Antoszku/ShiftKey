import XCTest
@testable import CodingChallenge

final class ShiftsListViewModelTests: XCTestCase {

    private let eightDaysInterval: TimeInterval = 8 * 24 * 60 * 60

    func test_onAppear_callInteractorGetShifts() async {
        let interactor = ShiftsListInteractorStub()
        let sut = ShiftsListViewModel(interactor: interactor)

        await sut.onAppear()

        XCTAssertTrue(interactor.getShiftsCalled)
    }

    func test_init_weeks() {
        let expectedWeeks = [WeekOfAYear(date: Date()),
                             WeekOfAYear(date: Date(timeIntervalSinceNow: 7 * 24 * 60 * 60))]
        let sut = ShiftsListViewModel()

        XCTAssertEqual(sut.weeks, expectedWeeks)
    }

    func test_init_currentDay() {
        let sut = ShiftsListViewModel()

        XCTAssertEqual(sut.currentDay, DayOfAYearIdentifiable(date: Date()))
    }

    func test_init_stateIsLoading() {
        let sut = ShiftsListViewModel()

        XCTAssertEqual(sut.state, .loading)
    }

    func test_init_activeTab() {
        let sut = ShiftsListViewModel()

        XCTAssertEqual(sut.activeTab, WeekOfAYearIdentifable(date: Date()))
    }

    func test_onAppear() async {
        let expectedShifts = [ShiftsForDatePresentable.build()]
        let interactor = ShiftsListInteractorStub()
        let sut = ShiftsListViewModel(interactor: interactor)
        interactor.returnShifts = expectedShifts

        await sut.onAppear()

        XCTAssertEqual(sut.state, .sections(expectedShifts))
    }

    func test_isDayEnable_returnTrue_whenSameDayAsToday() async {
        let sut = ShiftsListViewModel()

        XCTAssertTrue(sut.isDayEnable(DayOfAYear(date: Date())))
    }

    func test_isDayEnable_returnFalse_whenIsEightDayFromToday() async {
        let sut = ShiftsListViewModel()

        XCTAssertFalse(sut.isDayEnable(DayOfAYear(date: Date(timeIntervalSinceNow: eightDaysInterval))))
    }

    func test_isDayEnable_returnFalse_whenIsDayBeforeToday() async {
        let sut = ShiftsListViewModel()

        XCTAssertFalse(sut.isDayEnable(DayOfAYear(date: Date(timeIntervalSinceNow: -24 * 60 * 60))))
    }

    func test_onAppear_doNotShowSectionsWithDatesAfter8DayFromToday() async {
        let expectedShift = ShiftsForDatePresentable.build()
        let interactor = ShiftsListInteractorStub()
        let sut = ShiftsListViewModel(interactor: interactor)
        interactor.returnShifts = [expectedShift,
                                       .build(dayOfAYear: .init(date: Date(timeIntervalSinceNow: eightDaysInterval)))
        ]

        await sut.onAppear()

        XCTAssertEqual(sut.state, .sections([expectedShift]))
    }

}

private extension ShiftsForDatePresentable {
    static func build(dayOfAYear: DayOfAYear = .init(date: Date()),
                      weekId: WeekOfAYearIdentifable = .init(date: Date()),
                      headerTitle: String = "",
                      shifts: [ShiftPresentable] = []) -> Self {
        self.init(dayOfAYear: dayOfAYear, weekId: weekId, headerTitle: headerTitle, shifts: shifts)
    }
}
