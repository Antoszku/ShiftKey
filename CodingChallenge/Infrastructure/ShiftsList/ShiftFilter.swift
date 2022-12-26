struct ShiftFilter: Query {
    var parameters: [String: String?] {
        let radiusValue: String?
        if let radius {
            radiusValue = String(radius)
        } else {
            radiusValue = nil
        }
        return ["type": type?.rawValue,
                "address": address,
                "radius": radiusValue
        ]
    }

    enum ShiftType: String {
        case week
        case forDay = "4day"
        case list
    }
    let type: ShiftType?
    let address: String
    let radius: Int?
}
