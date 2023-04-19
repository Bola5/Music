//
//  MusicViewController.swift
//  Music
//
//  Created by Bola Fayez on 18/04/2023.
//

import UIKit

class MusicViewController: UIViewController {

    // MARK: - UI
    private let searchBar: UISearchBar = UISearchBar(frame: CGRect.zero)
    private let activityIndicatorView = ActivityIndicatorView()
    private let scrollToTopButton = UIButton()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - ViewModel
    private var viewModel: MusicViewModelProtocol
    
    // MARK: - Init
    // With viewModel
    init(viewModel: MusicViewModelProtocol = MusicViewModel()) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // MARK: - setupViews
    private func setupViews() {
        
        view.backgroundColor = .white
        title = Constants.Titles.MUSIC_TITLE
        
        // searchBar
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        searchBar.searchBarStyle = .default
        searchBar.placeholder = Constants.PlaceHolders.SEARCH_PLACEHOLDER
        searchBar.sizeToFit()
        searchBar.backgroundColor = .white
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self

        // activityIndicatorView
        activityIndicatorView.registerActivityIndicator(container: view)
        
        // tableView
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        tableView.separatorStyle = .singleLine
        
        // Scroll to top
        // Button
        scrollToTopButton.layer.cornerRadius = CGFloat(Constants.UI.CORNER_RADIUS)
        scrollToTopButton.layer.shadowColor = UIColor.black.cgColor
        scrollToTopButton.layer.shadowOpacity = Float(Constants.UI.SHADOW_OPACITY)
        scrollToTopButton.layer.shadowRadius = Constants.UI.SHAWOW_RADIUS
        scrollToTopButton.layer.shadowOffset = CGSize(width: Constants.UI.SHADOW_OFFSET, height: Constants.UI.SHADOW_OFFSET)
        scrollToTopButton.isHidden = true
        scrollToTopButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollToTopButton)
        NSLayoutConstraint.activate([
            scrollToTopButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scrollToTopButton.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: -16),
            scrollToTopButton.heightAnchor.constraint(equalToConstant: CGFloat(Constants.UI.SCROLL_TO_TOP_BUTTON_SIZE)),
            scrollToTopButton.widthAnchor.constraint(equalToConstant: CGFloat(Constants.UI.SCROLL_TO_TOP_BUTTON_SIZE))
        ])
        scrollToTopButton.addTarget(self, action: #selector(scrollToTopAction), for: .touchUpInside)
        
        // Image
        let arrowImageView = UIImageView.init(image: UIImage(named: Constants.Image.SCROLL_TO_TOP_IMAGE_NAME))
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        scrollToTopButton.addSubview(arrowImageView)
        NSLayoutConstraint.activate([
            arrowImageView.centerXAnchor.constraint(equalTo: scrollToTopButton.centerXAnchor),
            arrowImageView.centerYAnchor.constraint(equalTo: scrollToTopButton.centerYAnchor)
        ])

    }
    
    // MARK: - scrollToTopAction
    @objc func scrollToTopAction(sender: UIButton!) {
        self.tableView.setContentOffset(.zero, animated: true)
    }

}

// MARK: - Search for a music
extension MusicViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let term = searchBar.text else { return }
        self.fetchMusics(term: term)
        self.searchBar.text = ""
        self.searchBar.endEditing(true)
    }
    
}

// MARK: - Fetch Muisc
extension MusicViewController {
    
    private func fetchMusics(term: String) {
        activityIndicatorView.showIndicator()
        viewModel.fetchMusics(term: term, completion: { [weak self] result in
            self?.activityIndicatorView.hideIndicator()
            switch result {
            case .success:
                self?.handleFetchSuccess()
            case .failure(let error):
                self?.handleFailure(term: term, error: error.localizedDescription)
            }
        })
    }
    
    private func handleFetchSuccess() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func handleFailure(term: String, error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.showErrorAlert(message: error, completion: {
                self?.fetchMusics(term: term)
            })
        }
    }
    
}

