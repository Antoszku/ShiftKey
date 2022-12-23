import SwiftUI

@main
struct CodingChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            ShiftsListView(viewModel: ShiftsListViewModel())
        }
    }
}
