import SwiftUI

extension ShiftsListView {
    struct CalendarHeader: View {
        let scrollViewProxy: ScrollViewProxy
        @EnvironmentObject var viewModel: ShiftsListViewModel

        var body: some View {
            TabView(selection: $viewModel.activeTab) {
                ForEach(viewModel.weeks) { week in
                    HStack {
                        WeekCell(week: week, scrollViewProxy: scrollViewProxy)
                    }.tag(week.id)
                }
            }.tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 80)
        }
    }
}
