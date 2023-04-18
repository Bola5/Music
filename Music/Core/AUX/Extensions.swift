//
//  Extensions.swift
//  Music
//
//  Created by Bola Fayez on 18/04/2023.
//

import UIKit

extension UIWindow {
    static var key: UIWindow? {
        return UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }
    }
}
