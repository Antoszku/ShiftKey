import Foundation

extension ShiftsForDateDTO {
    struct ShiftDTO: Decodable {
        let shiftId: Int
        @DateFormatted<ISO8601Strategy> var startTime: Date
        @DateFormatted<ISO8601Strategy> var endTime: Date
        @DateFormatted<NormalizedDateStrategy> var normalizedStartDateTime: Date
        @DateFormatted<NormalizedDateStrategy> var normalizedEndDateTime: Date
        let timezone: String
        let premiumRate: Bool
        let covid: Bool
        let shiftKind: String
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
                  normalizedStartDateTime: dto.normalizedStartDateTime,
                  normalizedEndDateTime: dto.normalizedEndDateTime,
                  localizedSpecialty: .init(dto: dto.localizedSpecialty),
                  facilityType: .init(dto: dto.facilityType),
                  premiumRate: dto.premiumRate,
                  withinDistance: dto.withinDistance,
                  skill: .init(dto: dto.skill)
        )
    }
}
