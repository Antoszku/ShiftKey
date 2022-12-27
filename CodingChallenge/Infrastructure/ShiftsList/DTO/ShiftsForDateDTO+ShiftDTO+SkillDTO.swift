extension ShiftsForDateDTO.ShiftDTO {
    struct SkillDTO: Decodable {
        let id: Int
        let name: String
        let color: String
    }
}

extension ShiftsForDate.Shift.Skill {
    init(dto: ShiftsForDateDTO.ShiftDTO.SkillDTO) {
        self.init(name: dto.name, color: dto.color)
    }
}
