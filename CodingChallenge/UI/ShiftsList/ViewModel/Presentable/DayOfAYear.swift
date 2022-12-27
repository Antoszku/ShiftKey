import Foundation

struct DayOfAYear: Identifiable {
    let id: DayOfAYearIdentifiable
    let day: Int
    let month: Int
    let year: Int
    let weekday: String
    let weekOfYear: Int

    init(date: Date) {
        self.id = DayOfAYearIdentifiable(date: date)
        self.day = date.get(.day)
        self.month = date.get(.month)
        self.year = date.get(.year)
        self.weekOfYear = date.get(.weekOfYear)
        var calendar = Calendar.current
        calendar.locale = Locale.en_US
        weekday = calendar.veryShortWeekdaySymbols[calendar.component(.weekday, from: date) - 1].uppercased()
    }
}

extension DayOfAYear: Equatable {
    static func >= (lhs: Self, rhs: Self) -> Bool {
        if lhs.year > rhs.year {
            return true
        }

        if lhs.year == rhs.year && lhs.month > rhs.month {
            return true
        }
        if lhs.year == rhs.year && lhs.month == rhs.month && lhs.day >= rhs.day {
            return true
        }
        return false
    }


    static func < (lhs: Self, rhs: Self) -> Bool {
        if lhs.year < rhs.year {
            return true
        }
        if lhs.year == rhs.year && lhs.month < rhs.month {
            return true
        }
        if lhs.year == rhs.year && lhs.month == rhs.month && lhs.day < rhs.day {
            return true
        }
        return false
    }
}

