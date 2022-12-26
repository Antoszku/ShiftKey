extension ShiftsForDateDTO.ShiftDTO {
    struct LocalizedSpecialtyDTO: Decodable {
        let id: Int
        let specialtyId: Int
        let stateId: Int
        let name: String
        let abbreviation: String
        let specialty: Specialty

        struct Specialty: Decodable {
            let id: Int
            let name: String
            let color: String
            let abbreviation: String
        }
    }
}

extension ShiftsForDate.Shift.LocalizedSpeciality {
    init(dto: ShiftsForDateDTO.ShiftDTO.LocalizedSpecialtyDTO) {
        self.init(name: dto.name,
                  color: dto.specialty.color,
                  abbreviation: dto.abbreviation)
    }
}
