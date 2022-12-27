import Foundation

struct DayOfAYearIdentifiable: Identifiable, Hashable {
    let id: String

    init(date: Date) {
        let day = date.get(.day)
        let month = date.get(.month)
        let year = date.get(.year)
        self.id = "\(year)-\(month)-\(day)"
    }
    static func >= (lhs: Self, rhs: Self) -> Bool {
        return lhs.id >= rhs.id
    }

    static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.id < rhs.id
    }
}
