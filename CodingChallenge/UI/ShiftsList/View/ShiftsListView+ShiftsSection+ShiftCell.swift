import SwiftUI

extension ShiftsListView.ShiftsSection {
    struct ShiftCell: View {
        let shift: ShiftPresentable

        var body: some View {
            VStack {
                HStack {
                    Text(shift.startTime)
                    Text(shift.endTime)
                    Spacer()
                    Text(shift.abbreviation)
                }
                HStack {
                    Text(shift.facilityType)
                    Spacer()
                    if shift.premiumRate {
                        Image(systemName: "star.circle.fill").font(.headline).foregroundColor(.yellow)
                    }
                }
                HStack {
                    Text(shift.specialty)
                    Spacer()
                    Text(String(shift.withinDistance))
                }
            }.padding().background(.blue)
        }
    }

}
