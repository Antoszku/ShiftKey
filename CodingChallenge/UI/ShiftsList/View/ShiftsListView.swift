import SwiftUI

struct ShiftsListView: View {
    @ObservedObject var viewModel: ShiftsListViewModel

    private let background = Color(#colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.9803921569, alpha: 1))

    var body: some View {
        NavigationView {
            switch viewModel.state {
            case .loading: ProgressView()
            case let .sections(sections): shiftList(sections: sections).navigationTitle("Shifts")
            }
        }.background(background)
            .onAppear { onAppear() }
            .environmentObject(viewModel)
    }

    @ViewBuilder
    private func shiftList(sections: [ShiftsForDatePresentable]) -> some View {
        ScrollViewReader { proxy in
            VStack(spacing: 0) {
                CalendarHeader(scrollViewProxy: proxy).background(.white)
                ScrollView {
                    LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
                        ForEach(sections) { section in
                            ShiftsSection(section: section)
                        }
                    }
                }
            }
        }.sheet(item: $viewModel.selectedShift) { shift in
            ShiftDetailsView(shift: shift.details)
        }
    }

    private func onAppear() {
        Task {
            await viewModel.onAppear()
        }
    }
}
