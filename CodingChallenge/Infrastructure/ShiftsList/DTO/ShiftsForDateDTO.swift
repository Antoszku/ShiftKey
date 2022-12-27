import Foundation

struct ShiftsForDateDTO: Decodable {
    @DateFormatted<OnlyDateStrategy> var date: Date
    let shifts: [ShiftDTO]
}

extension ShiftsForDate {
    init(dto: ShiftsForDateDTO) {
        self.init(date: dto.date,
                  shifts: dto.shifts.map { .init(dto: $0) }
        )
    }
}
