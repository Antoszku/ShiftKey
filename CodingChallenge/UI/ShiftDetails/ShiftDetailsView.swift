import SwiftUI

struct ShiftDetailsView: View {
    @Environment(\.dismiss) private var dismiss

    let shift: ShiftDetailsPresentable
    private let background = Color(#colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.9803921569, alpha: 1))

    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text(shift.speciality).font(.title)
                    Row(icon: shift.distanceIcon, title: shift.distance)
                    Divider()
                    Row(icon: shift.dateIcon, title: shift.date)
                    Divider()
                    if shift.isPremiumRate {
                        Row(icon: shift.premiumRateIcon, title: shift.premiumRate, isPremiumRate: true)
                    }
                    Row(icon: shift.abbreviationIcon, title: shift.abbreviation)
                    Row(icon: shift.shiftTypeIcon, title: shift.shiftType)
                    Row(icon: shift.skillIcon, title: shift.skill)
                }
                Spacer()
            }.padding(.horizontal)
                .frame(maxHeight: .infinity)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark").foregroundColor(.black).font(.headline)
                        }
                    }
                }.padding(.horizontal, 8)
        }.background(background)
    }
}
