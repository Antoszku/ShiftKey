import SwiftUI

struct ShiftsListView: View {
    
    @ObservedObject var viewModel: ShiftsListViewModel
    
    var body: some View {
        NavigationView {
            Group {
                Text("The main view should include a list of shifts. If you tap on a shift it should show a modal shift details view. Be creative and show us your best work.")
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .navigationTitle("Shifts")
            .onAppear {
                onAppear()
            }
        }
    }
    
    private func onAppear() {
        Task {
            await viewModel.onAppear()
        }
    }
}
