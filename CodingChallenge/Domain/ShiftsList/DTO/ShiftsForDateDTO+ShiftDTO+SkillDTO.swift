extension ShiftsForDateDTO.ShiftDTO {
    struct SkillDTO: Decodable, Equatable {
        enum Name: String, Decodable, Equatable {
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
