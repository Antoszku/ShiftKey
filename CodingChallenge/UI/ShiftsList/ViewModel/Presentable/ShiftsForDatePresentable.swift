import Foundation

struct ShiftsForDatePresentable: Identifiable, Equatable {
    var id: DayOfAYearIdentifiable {
        dayOfAYear.id
    }

    let dayOfAYear: DayOfAYear
    let weekId: WeekOfAYearIdentifable
    let headerTitle: String
    let shifts: [ShiftPresentable]
}

extension ShiftsForDatePresentable {
    init(domain: ShiftsForDate) {
        dayOfAYear = DayOfAYear(date: domain.date)
        weekId = WeekOfAYearIdentifable(date: domain.date)
        shifts = domain.shifts.map { ShiftPresentable(shift: $0) }

        let dateFormatter = DateFormatter()
        dateFormatter.locale = .en_US
        dateFormatter.dateFormat = "E MMM d"
        headerTitle = dateFormatter.string(from: domain.date).uppercased()
    }
}
