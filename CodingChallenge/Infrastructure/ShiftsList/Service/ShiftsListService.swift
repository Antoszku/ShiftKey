protocol ShiftsListService {
    func getShifts(filter: ShiftFilter) async throws -> [ShiftsForDate]
}

class DefaultShiftsListService: ShiftsListService {
    private let apiClient: APIClient
    private let url = "/api/v2/available_shifts/"

    init(apiClient: APIClient = DefaultAPIClient()) {
        self.apiClient = apiClient
    }

    func getShifts(filter: ShiftFilter) async throws -> [ShiftsForDate] {
        let request = Request(url: url,
                              method: .GET,
                              query: filter)

        let response: ShiftsForDateResponseDTO = try await apiClient.sendRequest(request)
        return response.data.map { .init(dto: $0) }
    }
}
