import SwiftUI

extension ShiftsListView.CalendarHeader {
    struct WeekCell: View {

        @EnvironmentObject var viewModel: ShiftsListViewModel

        let week: WeekOfAYear
        let scrollViewProxy: ScrollViewProxy

        var body: some View {
            ForEach(week.days) { day in
                DayCell(dayOfAYear: day).onTapGesture {
                    guard viewModel.isDayEnable(day) else { return }

                    scroll(to: day)
                }.frame(maxWidth: .infinity)
            }
        }

        private func scroll(to day: DayOfAYear) {
            DispatchQueue.main.async {
                withAnimation {
                    scrollViewProxy.scrollTo(day.id, anchor: .top)
                }
            }
        }
    }
}
