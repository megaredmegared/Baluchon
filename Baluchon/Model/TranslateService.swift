
import Foundation

/// Translate Service from google translate API
class TranslateService {
    /// singleton instance shared
    static var shared = TranslateService()
    private init() {}
    
    /// Create session
    private var session = URLSession(configuration: .default)
    
    init(session: URLSession) {
        self.session = session
    }
    
    /// Create url request
    private func createTraductionRequest(for text: String, from firstLanguage: String, to secondLanguage: String) -> URLRequest {
        let url = URL(string: "https://translation.googleapis.com/language/translate/v2")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let key = googleKey
        let q = text
        let target = secondLanguage
        let format = "text"
        let source = firstLanguage
        let body = "key=\(key)&target=\(target)&q=\(q)&format=\(format)&source=\(source)"
        request.httpBody = body.data(using: .utf8)
        
        return request
    }

    private var task: URLSessionTask?
    
    /// Get translation from google
    func getTranslation(for text: String, from firstLanguage: String, to secondLanguage: String, callback: @escaping (Bool, Translation?) -> Void) {
        let request = createTraductionRequest(for: text, from: firstLanguage, to: secondLanguage)
        /// Stop task
        task?.cancel()
        /// Create task
        task = session.dataTask(with: request) { (data, response, error) in
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
                guard let translation = try? decoder.decode(Translation.self, from: data) else {
                    return callback(false, nil)
                }
                // Callback success
                callback(true, translation)
            }
        }
        /// Launch task
        task?.resume()
    }
}
