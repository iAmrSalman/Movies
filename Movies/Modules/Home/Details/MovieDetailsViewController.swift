//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Amr Salman on 26/04/2022.
//

import UIKit
import AppUIKit
import CoreKit
import RxSwift
import RxCocoa
import RxDataSources

public class MovieDetailsViewController: NiblessViewController {

    // MARK: - Properties
    
    private let viewModel: MovieDetailsViewModel
    private let customView: MovieDetailsView
    
    private lazy var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, MovieDetail>> = {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, MovieDetail>>(
            configureCell: { (_, tableView, indexPath, element) in
                switch element {
                case .movie(let movie):
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.movieDetailsCell, for: indexPath) else {
                        return UITableViewCell()
                    }
                    
                    cell.configure(with: movie)
                    cell.watchlistButton.addTarget(self.viewModel, action: #selector(MovieDetailsViewModel.toggleWatchlist), for: .touchUpInside)
                    return cell
                case .similar(let movies):
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.horizontalMoviesListCell, for: indexPath) else {
                        return UITableViewCell()
                    }
                    
                    cell.configure(with: movies)
                    return cell
                case .directors(let castMembers):
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.horizontalCastMembersListCell, for: indexPath) else {
                        return UITableViewCell()
                    }
                    
                    cell.configure(with: castMembers)
                    return cell
                case .actors(let castMembers):
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.horizontalCastMembersListCell, for: indexPath) else {
                        return UITableViewCell()
                    }
                    
                    cell.configure(with: castMembers)
                    return cell
                }
            },
            titleForHeaderInSection: { dataSource, sectionIndex in
                return dataSource[sectionIndex].model
            }
        )
        return dataSource
    }()
    
    // State
    private let disposeBag = DisposeBag()

    // MARK: - Methods
    init(view: MovieDetailsView, viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        self.customView = view
        super.init()
    }

    override public func loadView() {
        view = customView
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        title = R.string.localizable.movieDetails()
        observeErrorMessages()
        subscribe(to: viewModel.list)
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    private func subscribe(to observable: Observable<[MovieDetail]>) {
        observable
            .map {
                $0.sorted(by: { $0.index < $1.index })
            }
            .map { $0.map { SectionModel(model: $0.title, items: [$0]) } }
            .bind(to: customView.tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: disposeBag)
    }
    
    private func observeErrorMessages() {
        viewModel
            .errorMessages
            .compactMap { $0 }
            .asDriver { _ in fatalError("Unexpected error from error messages observable.") }
            .drive(onNext: { [weak self] errorMessage in
                guard let strongSelf = self else { return }
                strongSelf.present(errorMessage: errorMessage,
                                   withPresentationState: strongSelf.viewModel.errorPresentation)
            })
            .disposed(by: disposeBag)
    }
}
