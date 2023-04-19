//
//  MusicViewController.swift
//  Music
//
//  Created by Bola Fayez on 18/04/2023.
//

import UIKit

class MusicViewController: UIViewController {

    // MARK: - Cell constants
    private enum Constant {
        enum Cell {
            static let reuseIdentifier = NSStringFromClass(MusicTableViewCell.self)
        }
    }
    
    // MARK: - UI
    private let searchBar: UISearchBar = UISearchBar(frame: CGRect.zero)
    private let activityIndicatorView = ActivityIndicatorView()
    private let scrollToTopButton = UIButton()
    private let emptyLabel = UILabel()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MusicTableViewCell.self, forCellReuseIdentifier: Constant.Cell.reuseIdentifier)
        return tableView
    }()
    
    // MARK: - ViewModel
    private var viewModel: MusicViewModelProtocol
    private var term: String?
    
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
        
        view.backgroundColor = Styles.Colors.BACKGROUND.value
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
        searchBar.backgroundColor = Styles.Colors.BACKGROUND.value
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self

        // Empty label
        view.addSubview(emptyLabel)
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        emptyLabel.textAlignment = .center
        emptyLabel.textColor = Styles.Colors.PRIMARY.value
        emptyLabel.text = Constants.Strings.EMPTY_TEXT
        emptyLabel.font = UIFont.boldSystemFont(ofSize: Styles.FontSize.PRIMARY.rawValue)
        emptyLabel.isHidden = true

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
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        
        // Scroll to top
        // Button
        scrollToTopButton.layer.cornerRadius = Styles.UI.CORNER_RADIUS.rawValue
        scrollToTopButton.layer.shadowColor = UIColor.black.cgColor
        scrollToTopButton.layer.shadowOpacity = Float(Styles.UI.SHADOW_OPACITY.rawValue)
        scrollToTopButton.layer.shadowRadius = Styles.UI.SHAWOW_RADIUS.rawValue
        scrollToTopButton.layer.shadowOffset = CGSize(width: Styles.UI.SHADOW_OFFSET.rawValue, height: Styles.UI.SHADOW_OFFSET.rawValue)
        scrollToTopButton.isHidden = true
        scrollToTopButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollToTopButton)
        NSLayoutConstraint.activate([
            scrollToTopButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scrollToTopButton.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: -16),
            scrollToTopButton.heightAnchor.constraint(equalToConstant: Styles.UI.SCROLL_TO_TOP_BUTTON_SIZE.rawValue),
            scrollToTopButton.widthAnchor.constraint(equalToConstant: Styles.UI.SCROLL_TO_TOP_BUTTON_SIZE.rawValue)
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
        self.term = term
        self.fetchMusics(term: term)
        self.searchBar.endEditing(true)
    }
    
}

// MARK: - Scroll to top
extension MusicViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y >= scrollView.frame.size.height) {
            scrollToTopButton.isHidden = false
        } else {
            scrollToTopButton.isHidden = true
        }
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
            self?.setupEmptyState()
            self?.tableView.reloadData()
        }
    }
    
    private func handleFailure(term: String, error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.setupEmptyState()
            self?.showAlert(state: .error, message: error, completion: {
                self?.fetchMusics(term: term)
            })
        }
    }
    
    private func setupEmptyState() {
        emptyLabel.isHidden = viewModel.countOfMusics > 0
        tableView.isHidden = !(viewModel.countOfMusics > 0)
    }
    
}

// MARK: - Action
extension MusicViewController {
    
    // MARK: - handleAction
    private func handleAction(_ action: MusicAction) {
        switch action {
        case .showDescription(let description):
            self.showAlert(state: .info, message: description, completion: nil)
        }
    }
    
}

// MARK: - TableView Data Source
extension MusicViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countOfMusics
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Cell.reuseIdentifier, for: indexPath)

        let layoutViewModel = viewModel.musicAt(index: indexPath.row)
        
        guard let layoutViewModel = layoutViewModel else {
            return cell
        }
        
        if let cell = cell as? MusicTableViewCell {
            cell.loadDataWithLayoutViewModel(music: layoutViewModel, onAction: self.handleAction(_:))
        }
        
        return cell
    }
    
}

// MARK: - TableView Delegate
extension MusicViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.shouldFetchNextPage(index: indexPath.row) {
            self.fetchMusics(term: term ?? "")
        }
    }

}

