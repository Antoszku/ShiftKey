import SwiftUI

extension ShiftsListView {
    struct ShiftsSection: View {
        @State private var visibleSections = [ShiftsForDatePresentable]()
        @EnvironmentObject private var viewModel: ShiftsListViewModel

        let section: ShiftsForDatePresentable
        private let headerBackground = Color(#colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.9803921569, alpha: 1))

        var body: some View {
            Section {
                content
            }
            header: {
                header
            }
        }

        private var content: some View {
            ForEach(section.shifts) { shift in
                ShiftCell(shift: shift).onTapGesture {
                    viewModel.onShiftSelected(shift)
                }.onAppear {
                    visibleSections.append(section)
                    setCalendar()
                }.onDisappear {
                    guard let index = visibleSections.firstIndex(where: { $0.id == section.id }) else { return }
                    visibleSections.remove(at: index)
                    setCalendar()
                }
            }
        }

        private var header: some View {
            VStack(spacing: 0) {
                HStack {
                    Text(section.headerTitle)
                        .font(.headline)
                        .fontWeight(.medium)
                        .padding(.vertical, 8)
                    Spacer()
                }
                Divider()
            }.background(headerBackground).padding(.horizontal)
        }

        private func setCalendar() {
            visibleSections.sort(by: { $0.id < $1.id })
            guard let firstVisibleSection = visibleSections.first else { return }
            viewModel.currentDay = firstVisibleSection.id
            viewModel.activeTab = firstVisibleSection.weekId
        }
    }
}
