
import XCTest
import SwiftUI
@testable import CodingChallenge

final class ShiftDetailsPresentableTests: XCTestCase {

    func test_init() {
        let expectedSpeciality = "Speciality"
        let expectedDistance = "Within 13 miles"
        let expectedDistanceIcon = Image(systemName: "mappin.and.ellipse")
        let expectedDateIcon = Image(systemName: "calendar.circle")
        let expectedAbbreviation = "expectedAbbreviation"
        let expectedAbbreviationIcon = Image(systemName: "cross.circle.fill")
        let expectedSkill = "expectedSkill"
        let expectedSkillIcon = Image(systemName: "book.fill")
        let expectedPremiumRateIcon = Image(systemName: "star.circle.fill")
        let expectedPremiumRate = "Premium Rate"

        let sut = ShiftDetailsPresentable(shift: .build(localizedSpecialty: .build(name: expectedSpeciality, abbreviation: expectedAbbreviation),
                                                        facilityType: .build(name: "TPE"),
                                                        withinDistance: 13,
                                                        skill: .build(name: "expectedSkill")))

        XCTAssertEqual(sut.speciality, expectedSpeciality)
        XCTAssertEqual(sut.distance, expectedDistance)
        XCTAssertEqual(sut.distanceIcon, expectedDistanceIcon)
        XCTAssertEqual(sut.dateIcon, expectedDateIcon)
        XCTAssertEqual(sut.abbreviation, expectedAbbreviation)
        XCTAssertEqual(sut.abbreviationIcon, expectedAbbreviationIcon)
        XCTAssertEqual(sut.skill, expectedSkill)
        XCTAssertEqual(sut.skillIcon, expectedSkillIcon)
        XCTAssertEqual(sut.premiumRateIcon, expectedPremiumRateIcon)
        XCTAssertEqual(sut.premiumRate, expectedPremiumRate)
    }

    func test_init_expectedShift() {
        XCTAssertEqual(ShiftDetailsPresentable(shift: .build(shiftType: .dayShift)).shiftType, "Day Shift")
        XCTAssertEqual(ShiftDetailsPresentable(shift: .build(shiftType: .dayShift)).shiftTypeIcon, Image(systemName: "sun.max.fill"))
        XCTAssertEqual(ShiftDetailsPresentable(shift: .build(shiftType: .eveningShift)).shiftType, "Evening Shift")
        XCTAssertEqual(ShiftDetailsPresentable(shift: .build(shiftType: .eveningShift)).shiftTypeIcon, Image(systemName: "sun.and.horizon.fill"))
        XCTAssertEqual(ShiftDetailsPresentable(shift: .build(shiftType: .nightShift)).shiftType, "Night Shift")
        XCTAssertEqual(ShiftDetailsPresentable(shift: .build(shiftType: .nightShift)).shiftTypeIcon, Image(systemName: "moon.fill"))
        XCTAssertEqual(ShiftDetailsPresentable(shift: .build(shiftType: .unsupported)).shiftType, "Unknown")
        XCTAssertEqual(ShiftDetailsPresentable(shift: .build(shiftType: .unsupported)).shiftTypeIcon, Image(systemName: "clock.fill"))
    }

    func test_init_premiumRate() {
        XCTAssertTrue(ShiftDetailsPresentable(shift: .build(premiumRate: true)).isPremiumRate)
        XCTAssertFalse(ShiftDetailsPresentable(shift: .build(premiumRate: false)).isPremiumRate)
    }


    func test_init_date() {
        let startTime = Date(timeIntervalSince1970: 0)
        let normalizedStartDateTime = Date(timeIntervalSince1970: 6 * 60 * 60 + 15 * 60)
        let normalizedEndDateTime = Date(timeIntervalSince1970: 23 * 60 * 60 + 45 * 60)

        let sut = ShiftDetailsPresentable(shift: .build(startTime: startTime,
                                                        normalizedStartDateTime: normalizedStartDateTime,
                                                        normalizedEndDateTime: normalizedEndDateTime))
        XCTAssertEqual(sut.date, "Thu Jan 1 6:15am - 11:45pm")
    }
}
