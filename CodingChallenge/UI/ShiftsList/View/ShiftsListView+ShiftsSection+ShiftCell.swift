import SwiftUI

extension ShiftsListView.ShiftsSection {
    struct ShiftCell: View {
        let shift: ShiftPresentable
        private let shadowColor = Color(#colorLiteral(red: 0.2078431373, green: 0.2470588235, blue: 0.368627451, alpha: 1))
        private let starImage = Image(systemName: "star.circle.fill")

        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(shift.workingHours).font(.subheadline)
                    Spacer()
                    Text(shift.abbreviation).fontWeight(.medium).font(.headline)
                }
                HStack {
                    Text(shift.facilityType).font(.subheadline).fontWeight(.semibold)
                    Spacer()
                    if shift.premiumRate {
                        starImage.font(.headline).foregroundColor(.yellow)
                    }
                }
                HStack {
                    Text(shift.skill)
                        .font(.footnote)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 4)
                        .background(Color(hex: shift.skillColor))
                        .cornerRadius(16)
                    Spacer()
                    Text(shift.distance).font(.footnote).foregroundColor(.gray)
                }
            }.padding()
                .background(.white)
                .cornerRadius(8)
                .padding(.horizontal)
                .shadow(color: shadowColor.opacity(0.1), radius: 4, x: 0, y: 4)
                .padding(.vertical, 8)
        }
    }
}
