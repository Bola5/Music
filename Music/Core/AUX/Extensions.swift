//
//  Extensions.swift
//  Music
//
//  Created by Bola Fayez on 18/04/2023.
//

import UIKit

extension UIImageView {
    
    private func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix(Constants.Image.PREFIX_IMAGE),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                self.image = UIImage(named: Constants.Image.PLACEHOLDER_IMAGE)
                return
            }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func loadImageWith(url: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: url) else {
            self.image = UIImage(named: Constants.Image.PLACEHOLDER_IMAGE)
            return
        }
        self.downloaded(from: url, contentMode: mode)
    }
    
}

extension UIViewController {
    
    func showAlert(state: AlertState, message: String, completion: (() -> ())? = nil) {
        let alert = UIAlertController(title: state == .info ? Constants.Strings.DESCRIPTION : nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: state == .error ? Constants.Titles.RETRY_TITLE : Constants.Titles.OK_TITLE, style: .default, handler: { action in
            state == .error ? completion?() : nil
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension String {
    
    func convertDateFormater(fromFormat: String = "yyyy-MM-dd'T'HH:mm:ssZ", toFormat: String = "E, MM/dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = toFormat
        return dateFormatter.string(from: date ?? Date())
    }
    
}

extension Decodable {
    
    static func parse(jsonFile: String) -> Self? {
        guard let url = Bundle.main.url(forResource: jsonFile, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let output = try? JSONDecoder().decode(self, from: data)
        else {
            return nil
        }
        return output
    }
    
}
