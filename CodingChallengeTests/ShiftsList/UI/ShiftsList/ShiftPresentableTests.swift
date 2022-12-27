import XCTest
@testable import CodingChallenge

final class ShiftPresentableTests: XCTestCase {

    func test_init_withBasicValues() {
        let startDate = Date(timeIntervalSince1970: 7 * 60 * 60 + 30 * 60)
        let endDate = Date(timeIntervalSince1970: 13 * 60 * 60)
        let expectedId = 123
        let expectedWorkingHours = "7:30am - 1:00pm"
        let expectedAbbreviation = "expectedAbbreviation"
        let expectedFacilityType = "expectedFacilityType"
        let expectedSkill = "SKILL"
        let expectedSkillColor = "expectedSkillColor"
        let expectedPremiumRate = true
        let expectedDistance = "11 miles"

        let sut = ShiftPresentable(shift: .build(shiftId: expectedId,
                                                 normalizedStartDateTime: startDate,
                                                 normalizedEndDateTime: endDate,
                                                 localizedSpecialty: .build(abbreviation: expectedAbbreviation),
                                                 facilityType: .build(name: expectedFacilityType),
                                                 premiumRate: expectedPremiumRate,
                                                 withinDistance: 11,
                                                 skill: .build(name: "skill", color: expectedSkillColor)))


        XCTAssertEqual(sut.id, expectedId)
        XCTAssertEqual(sut.workingHours, expectedWorkingHours)
        XCTAssertEqual(sut.abbreviation, expectedAbbreviation)
        XCTAssertEqual(sut.facilityType, expectedFacilityType)
        XCTAssertEqual(sut.skill, expectedSkill)
        XCTAssertEqual(sut.skillColor, expectedSkillColor)
        XCTAssertEqual(sut.premiumRate, expectedPremiumRate)
        XCTAssertEqual(sut.distance, expectedDistance)
    }
}
