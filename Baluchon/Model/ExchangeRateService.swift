
import Foundation

/// Exchange rates service from fixer.io API
class ExchangeRateService {
    /// Singleton instance shared
    static var shared = ExchangeRateService()
    private init() {}
    
    /// Create url (creation of HTTPS url need paid version of Fixer API, so "App Transport Security Settings" in Info.plist is modified to allow insecure connection on fixer.io url)
    private let url = URL(
        string: "http://data.fixer.io/api/latest?access_key=\(fixerKey)&base=EUR")!
    
    /// Create session
    private var session = URLSession(configuration: .default)
    
    init(session: URLSession) {
        self.session = session
    }
    
    private var task: URLSessionTask?
    
    /// Get exchange rates from fixer.io API
    func getExchangeRate(callback: @escaping (Bool, ExchangeRate?) -> Void) {
        /// Stop task
        task?.cancel()
        /// Create task
        task = session.dataTask(with: url) { (data, response, error) in
            // Back in the main queue
            DispatchQueue.main.async {
                // Checks if data received
                guard let data = data, error == nil else {
                    return callback(false, nil)
                }
                // Check if response is ok
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    return callback(false, nil)
                }
                // Check if data is Decodable
                let decoder = JSONDecoder()
                guard let exchangeRate = try? decoder.decode(ExchangeRate.self, from: data) else {
                    return callback(false, nil)
                }
                // Callback success
                callback(true, exchangeRate)
            }
        }
        /// Launch task
        task?.resume()
    }
}
