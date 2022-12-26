import SwiftUI

struct ShiftsListView: View {

    @ObservedObject var viewModel: ShiftsListViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
                    ForEach(viewModel.sections) { section in
                        ShiftsSection(section: section)
                    }
                }
                    .navigationTitle("Shifts")
                    .onAppear {
                    onAppear()
                }
            }
        }
    }

    private func onAppear() {
        Task {
            await viewModel.onAppear()
        }
    }
}
