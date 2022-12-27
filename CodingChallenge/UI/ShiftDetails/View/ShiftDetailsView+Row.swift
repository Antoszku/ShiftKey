import SwiftUI

extension ShiftDetailsView {
    struct Row: View {
        let icon: Image
        let title: String
        let isPremiumRate: Bool

        init(icon: Image, title: String, isPremiumRate: Bool = false) {
            self.icon = icon
            self.title = title
            self.isPremiumRate = isPremiumRate
        }

        private let spacing: CGFloat = 16
        private let iconFont: Font = .title3

        var body: some View {
            HStack(spacing: spacing) {
                icon.font(iconFont).if(isPremiumRate) { $0.foregroundColor(.yellow) }.frame(width: 20, height: 20)
                Text(title)
                Spacer()
            }
        }
    }
}
