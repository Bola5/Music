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
                let mimeType = response?.mimeType, mimeType.hasPrefix(Strings.Image.PREFIX_IMAGE),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                self.image = UIImage(named: Strings.Image.PLACEHOLDER_IMAGE)
                return
            }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func loadImageWith(url: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: url) else {
            self.image = UIImage(named: Strings.Image.PLACEHOLDER_IMAGE)
            return
        }
        self.downloaded(from: url, contentMode: mode)
    }
    
}

extension UIWindow {
    static var key: UIWindow? {
        return UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }
    }
}

extension UIViewController {
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Strings.Titles.OK_TITLE, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

