extension ShiftsForDateDTO {
    struct ShiftDTO: Decodable {
        let shiftId: Int
        let startTime: String
        let endTime: String
        let normalizedStartDateTime: String
        let normalizedEndDateTime: String
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
                  normalizedStartDateTime: dto.normalizedStartDateTime,
                  normalizedEndDateTime: dto.normalizedEndDateTime,
                  localizedSpecialty: .init(dto: dto.localizedSpecialty),
                  facilityType: .init(dto: dto.facilityType),
                  premiumRate: dto.premiumRate,
                  withinDistance: dto.withinDistance
        )
    }
}
