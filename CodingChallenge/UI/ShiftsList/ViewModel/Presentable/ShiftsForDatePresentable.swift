import Foundation

struct ShiftsForDatePresentable: Identifiable, Equatable {
    let id: DayOfAYearIdentifiable
    let weekId: WeekOfAYearIdentifable
    let headerTitle: String
    let shifts: [ShiftPresentable]
}

extension ShiftsForDatePresentable {
    init(domain: ShiftsForDate) {
        self.id = DayOfAYearIdentifiable(date: domain.date)
        self.weekId = WeekOfAYearIdentifable(date: domain.date)
        self.shifts = domain.shifts.map { ShiftPresentable(shift: $0) }

        let dateFormatter = DateFormatter()
        dateFormatter.locale = .en_US
        dateFormatter.dateFormat = "E MMM d"
        self.headerTitle = dateFormatter.string(from: domain.date).uppercased()
    }
}
