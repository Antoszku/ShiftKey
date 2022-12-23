import XCTest
@testable import CodingChallenge

final class APIClientTests: XCTestCase {

    func test_sendRequest_callSessionDataFor_withCorrectRequest() async {
        let session = SessionServiceMock()
        let sut = DefaultAPIClient(session: session)

        let _: String? = try? await sut.sendRequest(request: .build())

        XCTAssertEqual(session.dataCalledWithRequest?.url, URL(string: "google.pl"))
        XCTAssertEqual(session.dataCalledWithRequest?.httpMethod, "GET")
    }

    func test_sendRequest_callSessionDataFor_withPOSTHTTPMethod() async {
        let session = SessionServiceMock()
        let sut = DefaultAPIClient(session: session)

        let _: String? = try? await sut.sendRequest(request: .build(method: .POST))

        XCTAssertEqual(session.dataCalledWithRequest?.httpMethod, "POST")
    }

    func test_sendRequest_callSessionDataFor_withCorrectQueryItems() async {
        let session = SessionServiceMock()
        let sut = DefaultAPIClient(session: session)

        let _: String? = try? await sut.sendRequest(request: .build(queryItems: [.init(name: "Name", value: "Value")]))

        XCTAssertEqual(session.dataCalledWithRequest?.url, URL(string: "google.pl?Name=Value"))
    }

    func test_sendRequest_callSessionDataFor_withCorrectHeader() async {
        let session = SessionServiceMock()
        let sut = DefaultAPIClient(session: session)
        let expectedHeaders = ["Accept": "application/json", "Content-Type": "application/json"]

        let _: String? = try? await sut.sendRequest(request: .build(headers: [ContentTypeHeader.json, AcceptHeader.json]))

        let headers = session.dataCalledWithRequest?.allHTTPHeaderFields
        XCTAssertEqual(headers, expectedHeaders)
    }

    func test_sendRequst_returnCorrectData() async {
        let expectedResult = "test result"
        let encoded = try! JSONEncoder().encode(expectedResult)
        let session = SessionServiceMock()
        session.returnData = (encoded, HTTPURLResponse())
        let sut = DefaultAPIClient(session: session)

        let result: String? = try? await sut.sendRequest(request: .build())

        XCTAssertEqual(result, expectedResult)
    }

    func test_sendRequst_returnCorrectData_forStatusCodeBetween200and299() async {
        let expectedResult = "test result"
        let encoded = try! JSONEncoder().encode(expectedResult)
        let session = SessionServiceMock()
        session.returnData = (encoded, HTTPURLResponse(url: URL(string: "google.pl")!,
                                                       statusCode: 299,
                                                       httpVersion: nil,
                                                       headerFields: nil)!)
        let sut = DefaultAPIClient(session: session)

        let result: String? = try? await sut.sendRequest(request: .build())

        XCTAssertEqual(result, expectedResult)
    }
    
    func test_sendRequst_throwParsingError() async {
        let session = SessionServiceMock()
        session.returnData = (Data(), HTTPURLResponse(url: URL(string: "google.pl")!,
                                                      statusCode: 200,
                                                      httpVersion: nil,
                                                      headerFields: nil)!)
        let sut = DefaultAPIClient(session: session)

        do {
            let _: String = try await sut.sendRequest(request: .build())
            XCTFail()
        } catch APIError.parsingError {
        
        } catch {
            XCTFail()
        }
    }

    func test_sendRequst_throwServerError() async {
        let expectedCode = 300
        let session = SessionServiceMock()
        session.returnData = (Data(), HTTPURLResponse(url: URL(string: "google.pl")!,
                                                      statusCode: expectedCode,
                                                      httpVersion: nil,
                                                      headerFields: nil)!)
        let sut = DefaultAPIClient(session: session)

        do {
            let _: String = try await sut.sendRequest(request: .build())
            XCTFail()
        } catch APIError.serverError(let code) {
            XCTAssertEqual(code, expectedCode)
        } catch {
            XCTFail()
        }
    }

}

extension Request {
    static func build(method: HTTPMethod = .GET, headers: [Header] = [], queryItems: [URLQueryItem]? = nil) -> Self {
        return .init(url: URL(string: "google.pl")!, method: method, headers: headers, queryItems: queryItems)
    }
}


final class SessionServiceMock: SessionService {
    var dataCalledWithRequest: URLRequest?
    var returnData = (Data(), HTTPURLResponse())

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        dataCalledWithRequest = request
        return returnData
    }
}
