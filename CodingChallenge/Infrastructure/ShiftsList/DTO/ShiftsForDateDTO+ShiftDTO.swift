import Foundation

extension ShiftsForDateDTO {
    struct ShiftDTO: Decodable {
        enum ShiftKindDTO: String, Decodable {
            case nightShift = "Night Shift"
            case dayShift = "Day Shift"
            case eveningShift = "Evening Shift"
        }

        let shiftId: Int
        @DateFormatted<ISO8601Strategy> var startTime: Date
        @DateFormatted<ISO8601Strategy> var endTime: Date
        @DateFormatted<NormalizedDateStrategy> var normalizedStartDateTime: Date
        @DateFormatted<NormalizedDateStrategy> var normalizedEndDateTime: Date
        let timezone: String
        let premiumRate: Bool
        let covid: Bool
        let shiftKind: Supportable<ShiftKindDTO>
        let withinDistance: Int
        let facilityType: FacilityTypeDTO
        let skill: SkillDTO
        let localizedSpecialty: LocalizedSpecialtyDTO
    }
}

extension ShiftsForDate.Shift {
    init(dto: ShiftsForDateDTO.ShiftDTO) {
        self.init(shiftId: dto.shiftId,
                  startTime: dto.startTime,
                  shiftType: .init(dto: dto),
                  normalizedStartDateTime: dto.normalizedStartDateTime,
                  normalizedEndDateTime: dto.normalizedEndDateTime,
                  localizedSpecialty: .init(dto: dto.localizedSpecialty),
                  facilityType: .init(dto: dto.facilityType),
                  premiumRate: dto.premiumRate,
                  withinDistance: dto.withinDistance,
                  skill: .init(dto: dto.skill))
    }
}

extension ShiftsForDate.Shift.ShiftType {
    init(dto: ShiftsForDateDTO.ShiftDTO) {
        switch dto.shiftKind {
        case let .supported(kind):
            switch kind {
            case .nightShift: self = .nightShift
            case .dayShift: self = .dayShift
            case .eveningShift: self = .eveningShift
            }
        case .unsupported:
            self = .unsupported
        }
    }
}
