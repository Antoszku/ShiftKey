import XCTest
@testable import CodingChallenge

final class ShiftsListServiceTests: XCTestCase {
    func test_getShifts_sendCorrectRequest() async {
        let expectedQueryParameters = ["type": "list",
                                       "address": "Cracow, PL",
                                       "radius": "10"]
        let apiClient = APIClientMock<String>()
        let sut = DefaultShiftsListService(apiClient: apiClient)
        let filter = ShiftFilter(type: .list, address: "Cracow, PL", radius: 10)
        
        _ = try? await sut.getShifts(filter: filter)
        
        let request = apiClient.sendRequestCalled
        XCTAssertEqual(request?.url, "/api/v2/available_shifts/")
        XCTAssertEqual(request?.method, .GET)
        XCTAssertEqual(request?.headers, [.acceptJson, .contentJson])
        XCTAssertEqual(request?.query?.parameters, expectedQueryParameters)
    }
    
    func test_getShifts_returnShiftForDateDTOArray() async {
        let dto = [ShiftsForDateDTO(date: "2020-12-12", shifts: [])]
        let expectedResult = [ShiftsForDate(date: "2020-12-12", shifts: [])]
        let apiClient = APIClientMock<ShiftsForDateResponseDTO>()
        let sut = DefaultShiftsListService(apiClient: apiClient)
        let filter = ShiftFilter(type: .list, address: "Cracow, PL", radius: 10)
        apiClient.returnResponse = .init(data: dto)
        
        let result = try? await sut.getShifts(filter: filter)
        
        XCTAssertEqual(result, expectedResult)
    } 
}
