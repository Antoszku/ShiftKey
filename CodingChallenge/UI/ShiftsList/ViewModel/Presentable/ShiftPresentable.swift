import Foundation

struct ShiftPresentable: Identifiable, Equatable {
    let id: Int
    let workingHours: String
    let abbreviation: String
    let facilityType: String
    let skill: String
    let skillColor: String
    let premiumRate: Bool
    let distance: String
    let details: ShiftDetailsPresentable
}

extension ShiftPresentable {
    init(shift: ShiftsForDate.Shift) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .UTC
        dateFormatter.dateFormat = "h:mma"
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "pm"
        let startTime = dateFormatter.string(from: shift.normalizedStartDateTime)
        let endtime = dateFormatter.string(from: shift.normalizedEndDateTime)

        self.id = shift.shiftId
        self.workingHours = "\(startTime) - \(endtime)"
        self.abbreviation = shift.localizedSpecialty.abbreviation
        self.facilityType = shift.facilityType.name
        self.premiumRate = shift.premiumRate
        self.distance = "\(shift.withinDistance) miles"
        self.skill = shift.skill.name.uppercased()
        self.skillColor = shift.skill.color
        
        self.details = .init(shift: shift)
    }
}
