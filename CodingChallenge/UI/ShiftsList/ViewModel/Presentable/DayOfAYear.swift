import Foundation

struct DayOfAYear: Identifiable, Equatable {
    let id: DayOfAYearIdentifiable
    let day: Int
    let year: Int
    let weekday: String
    let weekOfYear: Int

    init(date: Date) {
        self.id = DayOfAYearIdentifiable(date: date)
        self.day = date.get(.day)
        self.year = date.get(.year)
        self.weekOfYear = date.get(.weekOfYear)
        var calendar = Calendar.current
        calendar.locale = Locale.en_US
        weekday = calendar.veryShortWeekdaySymbols[calendar.component(.weekday, from: date) - 1].uppercased()
    }

    static func >= (lhs: Self, rhs: Self) -> Bool {
        return lhs.id >= rhs.id
    }

    static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.id < rhs.id
    }
}
