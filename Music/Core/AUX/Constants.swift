//
//  Constants.swift
//  Music
//
//  Created by Bola Fayez on 18/04/2023.
//

import Foundation

enum Constants {
    
    enum Titles {
        static let MUSIC_TITLE = "Music"
        static let OK_TITLE = "OK"
        static let RETRY_TITLE = "Retry"
    }
    
    enum PlaceHolders {
        static let SEARCH_PLACEHOLDER = "Search for songs, artists..."
    }
    
    enum Image {
        static let PLACEHOLDER_IMAGE = "PlaceholderImage"
        static let PREFIX_IMAGE = "image"
        static let SCROLL_TO_TOP_IMAGE_NAME = "scrollToTop"
    }
    
    enum URL {
        static let BASE_URL = "https://itunes.apple.com/"
        static let ENDPOINT = "search"
        static let MEDIA = "music"
        static let COUNTRY_CODE = "dk"
    }
    
    enum UI {
        static let ALPA = 0.1
        static let CORNER_RADIUS = 28
        static let SHADOW_OPACITY = 0.12
        static let SHAWOW_RADIUS = 3.0
        static let SHADOW_OFFSET = 1.0
        static let SCROLL_TO_TOP_BUTTON_SIZE = 56
    }
}
