extension ShiftsForDateDTO.ShiftDTO {
    struct SkillDTO: Decodable {
        enum Name: String, Decodable {
            case longTermCare = "Long Term Care"
            case ER
            case acuteCare = "Acute Care"
            case medAndSurg = "Med/Surg"
            case outpatientClinic = "Outpatient Clinic"
            case dentalClinic = "Dental Clinic"
        }
        let id: Int
        let name: Supportable<Name>
        let color: String
    }
}


extension ShiftsForDate.Shift.Skill {
    init(dto: ShiftsForDateDTO.ShiftDTO.SkillDTO) {
        let name: String
        switch dto.name {
        case .supported(let text):
            name = text.rawValue
        case .unsupported:
            name = "NONE"
        }
        self.init(name: name, color: dto.color)
    }
}
