protocol ShiftsListInteractor {
    func getShifts() async throws -> [ShiftsForDatePresentable]
}

final class DefaultShiftsListInteractor: ShiftsListInteractor {

    private let service: ShiftsListService

    init(service: ShiftsListService = DefaultShiftsListService()) {
        self.service = service
    }

    func getShifts() async throws -> [ShiftsForDatePresentable] {
        let shiftsForDateDTO = try await service.getShifts(filter: ShiftFilter(type: nil, address: "Dallas, TX", radius: nil))
        return shiftsForDateDTO.map { ShiftsForDatePresentable(dto: $0) }
    }
}