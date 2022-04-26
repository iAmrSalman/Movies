//
//  SearchResultsViewController.swift
//  Movies
//
//  Created by Amr Salman on 25/04/2022.
//

import UIKit
import AppUIKit
import CoreKit
import RxSwift
import RxCocoa
import RxDataSources

public class SearchResultsViewController: NiblessViewController {

    // MARK: - Properties
    
    private let viewModel: SearchResultsViewModel
    private let customView: SearchResultsView
    
    private lazy var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, MovieListPresentable>> = {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, MovieListPresentable>>(
            configureCell: { (_, tableView, indexPath, element) in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.movieCell, for: indexPath) else {
                    return UITableViewCell()
                }
                
                cell.configure(with: element)
                return cell
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
    init(view: SearchResultsView, viewModel: SearchResultsViewModel) {
        self.viewModel = viewModel
        self.customView = view
        super.init()
    }

    override public func loadView() {
        view = customView
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        observeErrorMessages()
        subscribe(to: viewModel.list)
        customView.tableView.rx.willDisplayCell
            .map { $0.indexPath.row }
            .bind(to: viewModel.currentDisplayedItemSubject)
            .disposed(by: disposeBag)
        
        customView.tableView.rx.itemSelected
            .map { $0.row }
            .bind(to: viewModel.selectItemSubject)
            .disposed(by: disposeBag)
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    private func subscribe(to observable: Observable<[MovieListPresentable]>) {
        observable
            .map { [SectionModel(model: "Search results", items: $0)] }
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

extension SearchResultsViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchTextSubject.onNext(searchController.searchBar.text)
    }
}
