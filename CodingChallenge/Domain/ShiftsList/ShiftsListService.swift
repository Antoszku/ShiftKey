import Foundation // TODO: REMOVE

protocol ShiftsListService {
    func getShifts(filter: ShiftFilter) async throws -> [ShiftsForDateDTO]
}

class DefaultShiftsListService: ShiftsListService {

    private let apiClient: APIClient
    private let url = "/api/v2/available_shifts/"

    init(apiClient: APIClient = DefaultAPIClient()) {
        self.apiClient = apiClient
    }

    func getShifts(filter: ShiftFilter) async throws -> [ShiftsForDateDTO] {
        let request = Request(url: url,
                              method: .GET,
                              query: filter)

        let response: ShiftsForDateResponseDTO = try await apiClient.sendRequest(request)
        return response.data
    }
}

protocol Query {
    var parameters: [String: String?] { get }
}

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
