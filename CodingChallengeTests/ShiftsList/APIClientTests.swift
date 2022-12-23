import XCTest
@testable import CodingChallenge

final class APIClientTests: XCTestCase {

    func test_sendRequest_callSessionDataFor_withCorrectRequest() async {
        let session = SessionServiceMock()
        let sut = makeSut(sessionService: session)

        let _: String? = try? await sut.sendRequest(.build())

        XCTAssertEqual(session.dataCalledWithRequest?.url, URL(string: "https://google.pl/"))
        XCTAssertEqual(session.dataCalledWithRequest?.httpMethod, "GET")
    }

    func test_sendRequest_callSessionDataFor_withPOSTHTTPMethod() async {
        let session = SessionServiceMock()
        let sut = makeSut(sessionService: session)

        let _: String? = try? await sut.sendRequest(.build(method: .POST))

        XCTAssertEqual(session.dataCalledWithRequest?.httpMethod, "POST")
    }

    func test_sendRequest_callSessionDataFor_withCorrectQueryItems() async {
        let session = SessionServiceMock()
        let sut = makeSut(sessionService: session)

        let _: String? = try? await sut.sendRequest(.build(query: QueryStub(parameters: ["name": "value"])))

        XCTAssertEqual(session.dataCalledWithRequest?.url, URL(string: "https://google.pl/?name=value"))
    }

    func test_sendRequest_callSessionDataFor_withCorrectQueryItemsWhenOneOfThemHasNilValue() async {
        let session = SessionServiceMock()
        let sut = makeSut(sessionService: session)

        let _: String? = try? await sut.sendRequest(.build(query: QueryStub(parameters: ["foo": "test", "some": nil])))

        XCTAssertEqual(session.dataCalledWithRequest?.url, URL(string: "https://google.pl/?foo=test"))
    }

    func test_sendRequest_callSessionDataFor_withCorrectHeader() async {
        let session = SessionServiceMock()
        let sut = makeSut(sessionService: session)
        let expectedHeaders = ["Accept": "application/json", "Content-Type": "application/json"]

        let _: String? = try? await sut.sendRequest(.build(headers: [.acceptJson, .contentJson]))

        let headers = session.dataCalledWithRequest?.allHTTPHeaderFields
        XCTAssertEqual(headers, expectedHeaders)
    }

    func test_sendRequst_returnCorrectData() async {
        let expectedResult = "test result"
        let encoded = try! JSONEncoder().encode(expectedResult)
        let session = SessionServiceMock()
        session.returnData = (encoded, HTTPURLResponse())
        let sut = makeSut(sessionService: session)

        let result: String? = try? await sut.sendRequest(.build())

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
        let sut = makeSut(sessionService: session)

        let result: String? = try? await sut.sendRequest(.build())

        XCTAssertEqual(result, expectedResult)
    }

    func test_sendRequst_throwParsingError() async {
        let session = SessionServiceMock()
        session.returnData = (Data(), HTTPURLResponse(url: URL(string: "google.pl")!,
                                                      statusCode: 200,
                                                      httpVersion: nil,
                                                      headerFields: nil)!)
        let sut = makeSut(sessionService: session)

        do {
            let _: String = try await sut.sendRequest(.build())
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
        let sut = makeSut(sessionService: session)

        do {
            let _: String = try await sut.sendRequest(.build())
            XCTFail()
        } catch APIError.serverError(let code) {
            XCTAssertEqual(code, expectedCode)
        } catch {
            XCTFail()
        }
    }

    private func makeSut(sessionService: SessionService = SessionServiceMock(),
                         networkConfiguration: NetworkConfiguration = NetworkConfiguration(scheme: "https", host: "google.pl")) -> DefaultAPIClient {
        DefaultAPIClient(session: sessionService, networkConfiguration: networkConfiguration)

    }

}

extension Request {
    static func build(method: HTTPMethod = .GET, headers: [Headers] = [], query: Query? = nil) -> Self {
        return .init(url: "/", method: method, headers: headers, query: query)
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

struct QueryStub: Query {
    var parameters: [String: String?]


}
