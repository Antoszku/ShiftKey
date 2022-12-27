import XCTest
@testable import CodingChallenge

final class ShiftsForDatePresentableTests: XCTestCase {
    func test_init() {
        let date = Date(timeIntervalSince1970: 0)
        let sut = ShiftsForDatePresentable(domain: .build(date: date))
        
        XCTAssertEqual(sut.id, DayOfAYearIdentifiable(date: date))
        XCTAssertEqual(sut.weekId, WeekOfAYearIdentifable(date: date))
        XCTAssertEqual(sut.headerTitle, "THU JAN 1")
    }
    
    func test_init_withCorrectHeaderTitle() {
        let dayInterval: TimeInterval = 24 * 60 * 60
        let date = Date(timeIntervalSince1970: dayInterval * 32)
        let sut = ShiftsForDatePresentable(domain: .build(date: date))
        
        XCTAssertEqual(sut.id, DayOfAYearIdentifiable(date: date))
        XCTAssertEqual(sut.headerTitle, "MON FEB 2")
    }
    
    func test_init_withCorrectNumberOfShifts() {
        let sut = ShiftsForDatePresentable(domain: .build(shifts: [.build(), .build()]))
        
        XCTAssertEqual(sut.shifts.count, 2)
    }
}

private extension ShiftsForDate {
    static func build(date: Date = Date(), shifts: [Shift] = []) -> Self {
        .init(date: date, shifts: shifts)
    }
}
