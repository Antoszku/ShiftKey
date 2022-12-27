import Foundation

extension ShiftsForDate {
    struct Shift: Equatable {
        enum ShiftType {
            case nightShift
            case dayShift
            case eveningShift
            case unsupported
        }

        let shiftId: Int
        let startTime: Date
        let shiftType: ShiftType
        let normalizedStartDateTime: Date
        let normalizedEndDateTime: Date
        let localizedSpecialty: LocalizedSpeciality
        let facilityType: FacilityType
        let premiumRate: Bool
        let withinDistance: Int
        let skill: Skill

        struct Skill: Equatable {
            let name: String
            let color: String
        }

        struct LocalizedSpeciality: Equatable {
            let name: String
            let color: String
            let abbreviation: String
        }

        struct FacilityType: Equatable {
            let name: String
            let color: String
        }
    }
}
