import SwiftUI

struct ShiftDetailsPresentable: Equatable {
    let speciality: String
    let distance: String
    let distanceIcon = Image(systemName: "mappin.and.ellipse")
    let date: String
    let dateIcon = Image(systemName: "calendar.circle")
    let shiftType: String
    let shiftTypeIcon: Image
    let abbreviation: String
    let abbreviationIcon = Image(systemName: "cross.circle.fill")
    let skill: String
    let skillIcon = Image(systemName: "book.fill")
    let isPremiumRate: Bool
    let premiumRateIcon = Image(systemName: "star.circle.fill")
    let premiumRate = "Premium Rate"

    init(shift: ShiftsForDate.Shift) {
        let timeFormatter = DateFormatter()
        timeFormatter.timeZone = .UTC
        timeFormatter.dateFormat = "h:mma"
        timeFormatter.amSymbol = "am"
        timeFormatter.pmSymbol = "pm"
        let startTime = timeFormatter.string(from: shift.normalizedStartDateTime)
        let endtime = timeFormatter.string(from: shift.normalizedEndDateTime)

        let dateFormatter = DateFormatter()
        dateFormatter.locale = .en_US
        dateFormatter.dateFormat = "E MMM d"
        let date = dateFormatter.string(from: shift.startTime)

        speciality = shift.localizedSpecialty.name
        distance = "Within \(shift.withinDistance) miles"
        self.date = "\(date) \(startTime) - \(endtime)"
        abbreviation = shift.localizedSpecialty.abbreviation
        skill = shift.skill.name
        isPremiumRate = shift.premiumRate

        switch shift.shiftType {
        case .nightShift:
            shiftType = "Night Shift"
            shiftTypeIcon = Image(systemName: "moon.fill")
        case .dayShift:
            shiftType = "Day Shift"
            shiftTypeIcon = Image(systemName: "sun.max.fill")
        case .eveningShift:
            shiftType = "Evening Shift"
            shiftTypeIcon = Image(systemName: "sun.and.horizon.fill")
        case .unsupported:
            shiftType = "Unknown"
            shiftTypeIcon = Image(systemName: "clock.fill")
        }
    }
}
