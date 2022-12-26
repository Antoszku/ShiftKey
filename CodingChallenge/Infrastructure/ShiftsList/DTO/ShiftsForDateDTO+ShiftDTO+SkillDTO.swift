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
