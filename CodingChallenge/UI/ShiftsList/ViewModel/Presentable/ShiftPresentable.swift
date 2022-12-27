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

        id = shift.shiftId
        workingHours = "\(startTime) - \(endtime)"
        abbreviation = shift.localizedSpecialty.abbreviation
        facilityType = shift.facilityType.name
        premiumRate = shift.premiumRate
        distance = "\(shift.withinDistance) miles"
        skill = shift.skill.name.uppercased()
        skillColor = shift.skill.color

        details = .init(shift: shift)
    }
}
