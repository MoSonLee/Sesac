

import UIKit

let json = """
{"quote": "Count your age by friends, not years. Count your life by smiles, not tears.",
"author": "John Lennon"
}
"""

struct Quote: Decodable {
    let quote: String
    let author: String
}


//String -> Data -> Quote
guard let result = json.data(using: .utf8) else { fatalError("Error")}
print(result)

do {
    let value = try JSONDecoder().decode(Quote.self, from: result)
    print(value)
} catch {
    print(error)
}
