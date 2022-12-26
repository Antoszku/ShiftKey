import SwiftUI

extension ShiftsListView {
    struct ShiftsSection: View {

        let section: ShiftsForDatePresentable

        var body: some View {
            Section(header:
                HStack {
                Text(section.date)
                Spacer()
            }.background(.red)) {
                ForEach(section.shifts) { shift in
                    ShiftCell(shift: shift)
                }
            }
        }
    }
}
