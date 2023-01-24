protocol ShiftsListInteractor {
    func getShifts(type: ShiftFilter.ShiftType, address: String) async throws -> [ShiftsForDatePresentable]
    func setFavorites(_ favorites: Set<Int>)
    func getFavorites() -> Set<Int>
}

final class DefaultShiftsListInteractor: ShiftsListInteractor {
    private let service: ShiftsListService
    private let favoriteService: FavoriteService

    init(service: ShiftsListService = DefaultShiftsListService(),
         favoriteService: FavoriteService = DefalutFavoriteService()) {
        self.service = service
        self.favoriteService = favoriteService
    }

    func getShifts(type: ShiftFilter.ShiftType, address: String) async throws -> [ShiftsForDatePresentable] {
        let shiftsForDateDTO = try await service.getShifts(filter: ShiftFilter(type: type, address: address))
        return shiftsForDateDTO.map { ShiftsForDatePresentable(domain: $0) }
    }

    func setFavorites(_ favorites: Set<Int>) {
        favoriteService.setFavorites(favorites)
    }

    func getFavorites() -> Set<Int> {
        return favoriteService.getFavorites()
    }
}
