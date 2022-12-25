struct ShiftsForDateDTO: Decodable, Equatable {
    let date: String
    let shifts: [ShiftDTO]
}
