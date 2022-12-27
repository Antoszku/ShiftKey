import Foundation

public struct NormalizedDateStrategy: DateCodableStrategy {
    private static var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }

    public static func decode(_ value: String) throws -> Date {
        if let date = formatter.date(from: value) {
            return date
        } else {
            fatalError()
        }
    }

    public static func encode(_ date: Date) -> String {
        formatter.string(from: date)
    }
}
