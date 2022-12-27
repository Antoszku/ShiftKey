import SwiftUI

extension ShiftsListView.CalendarHeader.WeekCell {
    struct DayCell: View {
        @EnvironmentObject var viewModel: ShiftsListViewModel

        let dayOfAYear: DayOfAYear

        var body: some View {
            VStack(spacing: 0) {
                Text(dayOfAYear.weekday).fontWeight(.semibold)
                ZStack {
                    if viewModel.currentDay == dayOfAYear.id {
                        Circle().foregroundColor(.green)
                    }
                    Text(String(dayOfAYear.day))
                        .foregroundColor(foregroundColor(for: dayOfAYear))
                        .fontWeight(.medium)

                }.frame(width: 40, height: 40)

            }.frame(width: 40)
        }

        private func foregroundColor(for day: DayOfAYear) -> Color {
            if viewModel.currentDay == day.id {
                return Color.white
            } else if viewModel.isDayEnable(day) {
                return .black
            } else {
                return .gray
            }
        }
    }
}
