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
    
    func showErrorAlert(message: String, completion: @escaping () -> ()) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.Titles.RETRY_TITLE, style: .default, handler: { action in
            completion()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

