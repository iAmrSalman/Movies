//
//  PopularMoviesViewController.swift
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
import Kingfisher

public class PopularMoviesViewController: NiblessViewController {

    // MARK: - Properties
    
    private let viewModel: PopularMoviesViewModel
    private let customView: PopularMoviesView
    
    private lazy var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<Int, MovieListPresentable>> = {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<Int, MovieListPresentable>>(
            configureCell: { (_, tableView, indexPath, element) in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.movieCell, for: indexPath) else {
                    return UITableViewCell()
                }
                
                cell.thumbnailImage.kf.setImage(with: URL(string: element.thumbnail))
                cell.titleLabel.text = element.title
                cell.overviewLabel.text = element.overview
                return cell
            },
            titleForHeaderInSection: { dataSource, sectionIndex in
                return "\(dataSource[sectionIndex].model)"
            }
        )
        return dataSource
    }()
    
    // State
    private let disposeBag = DisposeBag()

    // MARK: - Methods
    init(view: PopularMoviesView, viewModel: PopularMoviesViewModel) {
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
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    private func subscribe(to observable: Observable<[Int: [MovieListPresentable]]>) {
        observable
            .compactMap { $0.map { SectionModel(model: $0.key, items: $0.value) } }
            .compactMap { $0.sorted(by: { $0.model > $1.model })}
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
