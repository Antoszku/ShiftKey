import XCTest
@testable import CodingChallenge

final class ShiftPresentableTests: XCTestCase {

    func test_init_shiftPresentable() {
        let expectedId = 123
        let expectedStartTime = "expectedStartTime"
        let expectedEndTime = "expectedEndTime"
        let expectedAbbreviation = "expectedAbbreviation"
        let expectedFacilityType = "expectedFacilityType"
        let expectedFacilityTypeColor = "expectedFacilityTypeColor"
        let expectedSpecialty = "expectedSpecialty"
        let expectedPremiumRate = true
        let expectedWithinDistance = 11

        let sut = ShiftPresentable(shift: .build(shiftId: expectedId,
                                                 normalizedStartDateTime: expectedStartTime,
                                                 normalizedEndDateTime: expectedEndTime,
                                                 localizedSpecialty: .build(name: expectedSpecialty, abbreviation: expectedAbbreviation),
                                                 facilityType: .build(name: expectedFacilityType, color: expectedFacilityTypeColor),
                                                 premiumRate: expectedPremiumRate,
                                                 withinDistance: expectedWithinDistance))


        XCTAssertEqual(sut.id, expectedId)
        XCTAssertEqual(sut.startTime, expectedStartTime)
        XCTAssertEqual(sut.endTime, expectedEndTime)
        XCTAssertEqual(sut.abbreviation, expectedAbbreviation)
        XCTAssertEqual(sut.facilityType, expectedFacilityType)
        XCTAssertEqual(sut.facilityTypeColor, expectedFacilityTypeColor)
        XCTAssertEqual(sut.specialty, expectedSpecialty)
        XCTAssertEqual(sut.premiumRate, expectedPremiumRate)
        XCTAssertEqual(sut.withinDistance, expectedWithinDistance)

    }
}

private extension ShiftsForDate.Shift {
    static func build(shiftId: Int = 0,
                      normalizedStartDateTime: String = "",
                      normalizedEndDateTime: String = "",
                      localizedSpecialty: LocalizedSpeciality = .build(),
                      facilityType: FacilityType = .build(),
                      premiumRate: Bool = true,
                      withinDistance: Int = 0) -> Self {
            .init(shiftId: shiftId,
                  normalizedStartDateTime: normalizedStartDateTime,
                  normalizedEndDateTime: normalizedEndDateTime,
                  localizedSpecialty: localizedSpecialty,
                  facilityType: facilityType,
                  premiumRate: premiumRate,
                  withinDistance: withinDistance
        )
    }
}

private extension ShiftsForDate.Shift.FacilityType {
    static func build(name: String = "", color: String = "") -> Self {
            .init(name: name, color: color)
    }
}

private extension ShiftsForDate.Shift.LocalizedSpeciality {
    static func build(name: String = "", abbreviation: String = "") -> Self {
            .init(name: name, color: "", abbreviation: abbreviation)
    }
}
