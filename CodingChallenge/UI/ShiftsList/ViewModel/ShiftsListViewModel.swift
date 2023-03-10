import Foundation

final class ShiftsListViewModel: ObservableObject {
    private static let weekInterval: TimeInterval = 7 * 24 * 60 * 60

    enum ViewState: Equatable {
        case loading
        case sections([ShiftsForDatePresentable])
    }

    @Published var state = ViewState.loading
    @Published var currentDay = DayOfAYearIdentifiable(date: Date())
    @Published var activeTab = WeekOfAYearIdentifable(date: Date())
    @Published var weeks = [WeekOfAYear(date: Date()), WeekOfAYear(date: Date(timeIntervalSinceNow: weekInterval))]
    @Published var selectedShift: ShiftPresentable? = nil

    @Published private var favoriteShifts = Set<Int>()

    private let interactor: ShiftsListInteractor
    private let address = "Dallas, TX"
    private let eighthDayFromToday = DayOfAYear(date: Date(timeIntervalSinceNow: weekInterval))


    init(interactor: ShiftsListInteractor = DefaultShiftsListInteractor()) {
        self.interactor = interactor
    }

    func onAppear() async {
        do {
            let shifts = try await interactor.getShifts(type: .forDay, address: address)
            let shiftsFiltered = shifts.filter { $0.dayOfAYear < eighthDayFromToday }
            await setShifts(shiftsFiltered)
            let favorites = interactor.getFavorites()
            await setFavorites(favorites)
        } catch {
            print(error)
            // TODO: Handle Error
        }
    }

    func isDayEnable(_ day: DayOfAYear) -> Bool {
        return day >= DayOfAYear(date: Date()) && day < eighthDayFromToday
    }

    func onShiftSelected(_ shift: ShiftPresentable) {
        selectedShift = shift
    }

    func isFavorite(for id: Int) -> Bool {
        return favoriteShifts.contains(id)
    }

    func onCellTapped(id: Int) {
        if favoriteShifts.contains(id) {
            favoriteShifts.remove(id)
        } else {
            favoriteShifts.insert(id)
        }

        interactor.setFavorites(favoriteShifts)
    }

    @MainActor
    private func setFavorites(_ favorites: Set<Int>) {
        self.favoriteShifts = favorites
    }

    @MainActor
    private func setShifts(_ shifts: [ShiftsForDatePresentable]) {
        state = .sections(shifts)
    }
}
