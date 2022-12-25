extension ShiftsForDateDTO.ShiftDTO {
    struct FacilityTypeDTO: Decodable, Equatable {
        enum Name: String, Decodable, Equatable {
            case skilledNursingFacility = "Skilled Nursing Facility"
            case assistedLivingFacility = "Assisted Living Facility"
            case longTermCareFacility = "Long Term Care Facility"
            case intermediateCareFacility = "Intermediate Care Facility"
            case rehabilitationFacility = "Rehabilitation Facility"
            case inPatientRehabHospital = "In-Patient Rehab Hospital"
            case hospital = "Hospital"
            case personalCareHome = "Personal Care Home"
            case healthcareFacility = "Healthcare Facility"
            case dentistryClinic = "Dentistry Clinic"
            case longTermAcuteCare = "Long Term Acute Care"
            case correctionalFacility = "Correctional Facility"
        }
        let id: Int
        let name: Supportable<Name>
        let color: String
    }
}
