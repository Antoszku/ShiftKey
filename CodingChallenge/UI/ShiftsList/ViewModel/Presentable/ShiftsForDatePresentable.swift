struct ShiftsForDatePresentable: Identifiable {
    let id: String
    let date: String
    let shifts: [ShiftPresentable]

    init(domain: ShiftsForDate) {
        self.id = domain.date
        self.date = domain.date
        self.shifts = domain.shifts.map { ShiftPresentable(shift: $0) }
    }
}
