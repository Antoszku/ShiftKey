struct ShiftPresentable: Identifiable {
    let id: Int
    let startTime: String
    let endTime: String
    let abbreviation: String
    let facilityType: String
    let facilityTypeColor: String
    let specialty: String
    let premiumRate: Bool
    let withinDistance: Int
    
    init(shift: ShiftsForDate.Shift) {
        self.id = shift.shiftId
        self.startTime = shift.normalizedStartDateTime
        self.endTime = shift.normalizedEndDateTime
        self.abbreviation = shift.localizedSpecialty.abbreviation
        self.facilityType = shift.facilityType.name
        self.facilityTypeColor = shift.facilityType.color
        self.specialty = shift.localizedSpecialty.name
        self.premiumRate = shift.premiumRate
        self.withinDistance = shift.withinDistance
    }
}
