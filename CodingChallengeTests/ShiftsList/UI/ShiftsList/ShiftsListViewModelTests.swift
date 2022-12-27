@testable import CodingChallenge
import XCTest

final class ShiftsListViewModelTests: XCTestCase {
    private let eightDaysInterval: TimeInterval = 8 * 24 * 60 * 60

    func test_onAppear_callInteractorGetShifts() async {
        let interactor = ShiftsListInteractorStub()
        let sut = makeSut(interactor: interactor)

        await sut.onAppear()

        XCTAssertEqual(interactor.getShiftsCalled?.0, .forDay)
        XCTAssertEqual(interactor.getShiftsCalled?.1, "Dallas, TX")
    }

    func test_init_weeks() {
        let expectedWeeks = [WeekOfAYear(date: Date()),
                             WeekOfAYear(date: Date(timeIntervalSinceNow: 7 * 24 * 60 * 60))]
        let sut = makeSut()

        XCTAssertEqual(sut.weeks, expectedWeeks)
    }

    func test_init_currentDay() {
        let sut = makeSut()

        XCTAssertEqual(sut.currentDay, DayOfAYearIdentifiable(date: Date()))
    }

    func test_init_stateIsLoading() {
        let sut = makeSut()

        XCTAssertEqual(sut.state, .loading)
    }

    func test_init_activeTab() {
        let sut = makeSut()

        XCTAssertEqual(sut.activeTab, WeekOfAYearIdentifable(date: Date()))
    }

    func test_onAppear() async {
        let expectedShifts = [ShiftsForDatePresentable.build()]
        let interactor = ShiftsListInteractorStub()
        let sut = makeSut(interactor: interactor)
        interactor.returnShifts = expectedShifts

        await sut.onAppear()

        XCTAssertEqual(sut.state, .sections(expectedShifts))
    }

    func test_isDayEnable_returnTrue_whenSameDayAsToday() async {
        let sut = makeSut()

        XCTAssertTrue(sut.isDayEnable(DayOfAYear(date: Date())))
    }

    func test_isDayEnable_returnFalse_whenIsEightDayFromToday() async {
        let sut = makeSut()

        XCTAssertFalse(sut.isDayEnable(DayOfAYear(date: Date(timeIntervalSinceNow: eightDaysInterval))))
    }

    func test_isDayEnable_returnFalse_whenIsDayBeforeToday() async {
        let sut = makeSut()

        XCTAssertFalse(sut.isDayEnable(DayOfAYear(date: Date(timeIntervalSinceNow: -24 * 60 * 60))))
    }

    func test_onAppear_doNotShowSectionsWithDatesAfter8DayFromToday() async {
        let expectedShift = ShiftsForDatePresentable.build()
        let interactor = ShiftsListInteractorStub()
        let sut = makeSut(interactor: interactor)
        interactor.returnShifts = [expectedShift,
                                   .build(dayOfAYear: .init(date: Date(timeIntervalSinceNow: eightDaysInterval)))]

        await sut.onAppear()

        XCTAssertEqual(sut.state, .sections([expectedShift]))
    }

    func test_onShiftSelected() {
        let shift = ShiftPresentable.build()
        let sut = makeSut()

        sut.onShiftSelected(shift)

        XCTAssertEqual(sut.selectedShift, shift)
    }

    private func makeSut(interactor: ShiftsListInteractor = ShiftsListInteractorStub()) -> ShiftsListViewModel {
        return ShiftsListViewModel(interactor: interactor)
    }
}

private extension ShiftPresentable {
    static func build() -> Self {
        .init(id: 0,
              workingHours: "",
              abbreviation: "",
              facilityType: "",
              skill: "",
              skillColor: "",
              premiumRate: true,
              distance: "",
              details: .init(shift: .build()))
    }
}

private extension ShiftsForDatePresentable {
    static func build(dayOfAYear: DayOfAYear = .init(date: Date()),
                      weekId: WeekOfAYearIdentifable = .init(date: Date()),
                      headerTitle: String = "",
                      shifts: [ShiftPresentable] = []) -> Self
    {
        self.init(dayOfAYear: dayOfAYear, weekId: weekId, headerTitle: headerTitle, shifts: shifts)
    }
}
