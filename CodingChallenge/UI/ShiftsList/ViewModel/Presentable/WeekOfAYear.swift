import Foundation

struct WeekOfAYear: Identifiable, Equatable {
    let id: WeekOfAYearIdentifable
    let days: [DayOfAYear]

    init(date: Date) {
        id = WeekOfAYearIdentifable(date: date)
        days = Self.getDatesOfWeek(for: date)
    }

    static func getDatesOfWeek(for date: Date) -> [DayOfAYear] {
        let calendar = Calendar.current
        let currentDay = Calendar.current.startOfDay(for: date)
        guard let firstDayOfWeek = calendar.dateInterval(of: .weekOfYear, for: currentDay) else { return [] }

        return (0 ... 6).compactMap {
            let date = calendar.date(byAdding: .day, value: $0, to: firstDayOfWeek.start)
            return DayOfAYear(date: date!)
        }
    }
}
