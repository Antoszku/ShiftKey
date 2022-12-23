struct NetworkConfiguration {
    let scheme: String
    let host: String

    init(scheme: String = "https", host: String = "staging-app.shiftkey.com") {
        self.scheme = scheme
        self.host = host
    }
}
