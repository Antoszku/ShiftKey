struct ShiftsForDatePresentable {
    let date: String
    
    init(dto: ShiftsForDateDTO) {
        self.date = dto.date
    }
}
