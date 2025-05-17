
import Foundation

class ConversionBot: ObservableObject {
    let apiKey = "YOUR_API_KEY" // Replace with your real API key

    func convert(amount: Double, from: String, to: String, completion: @escaping (Double?) -> Void) {
        let urlString = "https://v6.exchangerate-api.com/v6/\(apiKey)/pair/\(from)/\(to)/\(amount)"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let result = json["conversion_result"] as? Double else {
                completion(nil)
                return
            }

            DispatchQueue.main.async {
                completion(result)
            }
        }.resume()
    }
}
