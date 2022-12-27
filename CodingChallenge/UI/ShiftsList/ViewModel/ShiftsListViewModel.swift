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

    private let interactor: ShiftsListInteractor
    private let eighthDayFromToday = DayOfAYear(date: Date(timeIntervalSinceNow: weekInterval))

    init(interactor: ShiftsListInteractor = DefaultShiftsListInteractor()) {
        self.interactor = interactor
    }

    func onAppear() async {
        do {
            let shifts = try await interactor.getShifts()
            let shiftsFiltered = shifts.filter { $0.dayOfAYear < eighthDayFromToday }
            await setShifts(shiftsFiltered)
            print(shifts)
        } catch let error {
            print(error)
            // TODO: Handle Error
        }
    }

    func isDayEnable(_ day: DayOfAYear) -> Bool {
        return day >= DayOfAYear(date: Date()) && day < eighthDayFromToday
    }

    @MainActor
    private func setShifts(_ shifts: [ShiftsForDatePresentable]) {
        state = .sections(shifts)
    }
}
