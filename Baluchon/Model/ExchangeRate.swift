
import Foundation

/// Exchange rate infos
struct ExchangeRate: Codable {
    var success: Bool = false
    var timestamp: Int = 0
    var base: String = ""
    var date: String = ""
    var rates: [String: Double] = ["EUR" : 1.12, "USD": 1.12]
}
