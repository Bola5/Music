//
//  MusicTableViewCell.swift
//  Music
//
//  Created by Bola Fayez on 19/04/2023.
//

import UIKit

class MusicTableViewCell: UITableViewCell {

    // MARK: - UI
    private let containerView = UIView()
    private let artworkImageView = UIImageView()
    private let trackNameLabel = UILabel()
    private let artistNameLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private let lineView = UIView()
    private let infoButton = UIButton(type: .detailDisclosure)

    // MARK: - Action
    private var onActionEvent: ((MusicAction) -> Void)?
    private var musicDescription: String?
    
    // MARK: - Init
    // Cell style
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    // MARK: - With a coder
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupViews
    private func setupViews() {
        
        selectionStyle = .none

        // containerView
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        // artworkImageView
        artworkImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(artworkImageView)
        artworkImageView.layer.cornerRadius = Styles.UI.IMGAE_CORNER_RADIUS.rawValue
        artworkImageView.clipsToBounds = true
        NSLayoutConstraint.activate([
            artworkImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            artworkImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            artworkImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            artworkImageView.widthAnchor.constraint(equalToConstant: Styles.UI.ARTWORK_IMGAE_SIZE.rawValue),
            artworkImageView.heightAnchor.constraint(equalToConstant: Styles.UI.ARTWORK_IMGAE_SIZE.rawValue)
        ])
        
        // infoButton
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(infoButton)
        infoButton.tintColor = Styles.Colors.SECONDARY.value
        NSLayoutConstraint.activate([
            infoButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            infoButton.centerYAnchor.constraint(equalTo: artworkImageView.centerYAnchor)
        ])
        infoButton.addTarget(self, action: #selector(InfoAction), for: .touchUpInside)
        
        // releaseDateLabel
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(releaseDateLabel)
        NSLayoutConstraint.activate([
            releaseDateLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 14),
            releaseDateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
        releaseDateLabel.textAlignment = .left
        releaseDateLabel.textColor = Styles.Colors.SECONDARY.value
        releaseDateLabel.font = UIFont.systemFont(ofSize: Styles.FontSize.THIRD.rawValue)
        
        // trackNameLabel
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(trackNameLabel)
        trackNameLabel.textColor = Styles.Colors.PRIMARY.value
        trackNameLabel.font = UIFont.boldSystemFont(ofSize: Styles.FontSize.PRIMARY.rawValue)
        NSLayoutConstraint.activate([
            trackNameLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 8),
            trackNameLabel.trailingAnchor.constraint(equalTo: infoButton.leadingAnchor, constant: -8),
            trackNameLabel.leadingAnchor.constraint(equalTo: artworkImageView.trailingAnchor, constant: 8)
        ])

        // artistNameLabel
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(artistNameLabel)
        artistNameLabel.textColor = Styles.Colors.SECONDARY.value
        artistNameLabel.font = UIFont.systemFont(ofSize: Styles.FontSize.SECONDARY.rawValue)
        artistNameLabel.lineBreakMode = .byTruncatingTail
        NSLayoutConstraint.activate([
            artistNameLabel.leadingAnchor.constraint(equalTo: artworkImageView.trailingAnchor, constant: 8),
            artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 4),
            artistNameLabel.trailingAnchor.constraint(equalTo: infoButton.leadingAnchor, constant: -8)
        ])
        
        // lineView
        lineView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(lineView)
        lineView.backgroundColor = Styles.Colors.THIRD.value
        NSLayoutConstraint.activate([
            lineView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            lineView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            lineView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: Styles.UI.LINE_SIZE.rawValue)
        ])
    }
    
    // MARK: - Actions
    @objc func InfoAction(sender: UIButton) {
        self.onActionEvent?(.showDescription(description: self.musicDescription ?? ""))
    }

}

// MARK: - load Data
extension MusicTableViewCell {
    
    func loadDataWithLayoutViewModel(music: MusicLayoutViewModel.ResultsLayoutViewModel, onAction: ((MusicAction) -> Void)?) {
        
        self.artworkImageView.loadImageWith(url: music.artworkUrl ?? "")
        self.artistNameLabel.text = music.artistName ?? ""
        self.trackNameLabel.text = music.trackName ?? ""
        self.releaseDateLabel.text = music.releaseDate?.convertDateFormater()
        self.musicDescription = music.description ?? ""
        self.onActionEvent = onAction
    }
    
}
