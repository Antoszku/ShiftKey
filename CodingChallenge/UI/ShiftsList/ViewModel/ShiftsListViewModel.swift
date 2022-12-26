import Foundation

final class ShiftsListViewModel: ObservableObject {

    @Published var sections = [ShiftsForDatePresentable]()
    private let interactor: ShiftsListInteractor
    
    init(interactor: ShiftsListInteractor = DefaultShiftsListInteractor()) {
        self.interactor = interactor
    }
    
    func onAppear() async {
        do {
            let shifts = try await interactor.getShifts()
            print(shifts)
        } catch let error {
            print(error)
        }
    }
}
