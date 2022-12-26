extension ShiftsForDateDTO.ShiftDTO {
    struct FacilityTypeDTO: Decodable {
        let id: Int
        let name: String
        let color: String
    }
}

extension ShiftsForDate.Shift.FacilityType {
    init(dto: ShiftsForDateDTO.ShiftDTO.FacilityTypeDTO) {
        self.init(name: dto.name, color: dto.color)
    }
}
