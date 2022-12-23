import Foundation

final class ShiftsListViewModel: ObservableObject {

    private let interactor: ShiftsListInteractor
    
    init(interactor: ShiftsListInteractor = DefaultShiftsListInteractor()) {
        self.interactor = interactor
    }
    
    func onAppear() async {
        do {
            try await interactor.getShifts()
        } catch {
            
        }
    }
}


struct ShiftsForDatePresentable {
    
}
