struct ShiftsForDate: Equatable {
    let date: String
    let shifts: [Shift]
}

extension ShiftsForDate {
    struct Shift: Equatable {
        let shiftId: Int
        let normalizedStartDateTime: String
        let normalizedEndDateTime: String
        let localizedSpecialty: LocalizedSpeciality
        let facilityType: FacilityType
        let premiumRate: Bool
        let withinDistance: Int


        struct LocalizedSpeciality: Equatable {
            let name: String
            let color: String
            let abbreviation: String
        }

        struct FacilityType: Equatable {
            let name: String
            let color: String
        }
    }
}
