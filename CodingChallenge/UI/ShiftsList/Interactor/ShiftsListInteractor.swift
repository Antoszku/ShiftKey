protocol ShiftsListInteractor {
    func getShifts(type: ShiftFilter.ShiftType, address: String) async throws -> [ShiftsForDatePresentable]
}

final class DefaultShiftsListInteractor: ShiftsListInteractor {

    private let service: ShiftsListService

    init(service: ShiftsListService = DefaultShiftsListService()) {
        self.service = service
    }

    func getShifts(type: ShiftFilter.ShiftType, address: String) async throws -> [ShiftsForDatePresentable] {
        let shiftsForDateDTO = try await service.getShifts(filter: ShiftFilter(type: type, address: address))
        return shiftsForDateDTO.map { ShiftsForDatePresentable(domain: $0) }
    }
}
