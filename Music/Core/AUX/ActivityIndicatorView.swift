//
//  ActivityIndicatorView.swift
//  Music
//
//  Created by Bola Fayez on 18/04/2023.
//

import UIKit

class ActivityIndicatorView: UIView {

    // MARK: - UI
    private let blurImg = UIImageView()
    private let indicator = UIActivityIndicatorView()
    private var container: UIView?
    
    // MARK: - Init
    // Cell style
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }

    // MARK: - With a coder
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - setupViews
    private func setupViews() {
        blurImg.frame = UIScreen.main.bounds
        blurImg.backgroundColor = UIColor.black
        blurImg.isUserInteractionEnabled = true
        blurImg.alpha = 0.1
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.center = blurImg.center
        indicator.color = .gray
        indicator.startAnimating()
    }
    
    // MARK: - registerActivityIndicator
    func registerActivityIndicator(container: UIView) {
        self.container = container
    }
    
    // MARK: - showIndicator
    func showIndicator() {
        DispatchQueue.main.async( execute: {
            self.container?.addSubview(self.blurImg)
            self.container?.addSubview(self.indicator)
        })
    }
    
    // MARK: - hideIndicator
    func hideIndicator() {
        DispatchQueue.main.async( execute: {
            self.blurImg.removeFromSuperview()
            self.indicator.removeFromSuperview()
        })
    }
    
}
