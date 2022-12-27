import Foundation

struct WeekOfAYearIdentifable: Hashable {
    let id: String

    init(date: Date) {
        let year = date.get(.year)
        let weekOfYear = date.get(.weekOfYear)
        id = "\(year)-\(weekOfYear)"
    }

    init(dayOfAYear: DayOfAYear) {
        id = "\(dayOfAYear.year)-\(dayOfAYear.weekOfYear)"
    }

    static func == (lhs: WeekOfAYearIdentifable, rhs: WeekOfAYearIdentifable) -> Bool {
        if lhs.id == rhs.id {
            return true
        } else {
            return false
        }
    }
}
