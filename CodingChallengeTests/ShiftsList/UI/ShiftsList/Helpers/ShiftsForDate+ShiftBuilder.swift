import XCTest
@testable import CodingChallenge

extension ShiftsForDate.Shift {
    static func build(shiftId: Int = 0,
                      startTime: Date = Date(),
                      normalizedStartDateTime: Date = Date(),
                      normalizedEndDateTime: Date = Date(),
                      localizedSpecialty: LocalizedSpeciality = .build(),
                      facilityType: FacilityType = .build(),
                      premiumRate: Bool = true,
                      withinDistance: Int = 0,
                      skill: Skill = .build()) -> Self {
            .init(shiftId: shiftId,
                  startTime: startTime,
                  normalizedStartDateTime: normalizedStartDateTime,
                  normalizedEndDateTime: normalizedEndDateTime,
                  localizedSpecialty: localizedSpecialty,
                  facilityType: facilityType,
                  premiumRate: premiumRate,
                  withinDistance: withinDistance,
                  skill: skill)
    }
}

extension ShiftsForDate.Shift.Skill {
    static func build(name: String = "", color: String = "") -> Self {
            .init(name: name, color: color)
    }
}


extension ShiftsForDate.Shift.FacilityType {
    static func build(name: String = "", color: String = "") -> Self {
            .init(name: name, color: color)
    }
}

extension ShiftsForDate.Shift.LocalizedSpeciality {
    static func build(name: String = "", abbreviation: String = "") -> Self {
            .init(name: name, color: "", abbreviation: abbreviation)
    }
}
