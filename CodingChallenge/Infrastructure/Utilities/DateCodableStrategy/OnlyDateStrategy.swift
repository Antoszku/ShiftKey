import Foundation

public struct OnlyDateStrategy: DateCodableStrategy {
    private static var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
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
