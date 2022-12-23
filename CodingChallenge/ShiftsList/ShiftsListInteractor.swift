protocol ShiftsListInteractor {
    func getShifts() async throws -> ShiftsForDatePresentable
}

final class DefaultShiftsListInteractor: ShiftsListInteractor {

    func getShifts() async throws -> ShiftsForDatePresentable {
        return ShiftsForDatePresentable()
    }
}
