extension ShiftsForDateDTO.ShiftDTO {
    struct LocalizedSpecialtyDTO: Decodable, Equatable {
        let id: Int
        let specialtyId: Int
        let stateId: Int
        let name: String
        let abbreviation: String
        let specialty: Specialty
        struct Specialty: Decodable, Equatable {
            let id: Int
            let name: String
            let color: String
            let abbreviation: String
        }
    }
}
