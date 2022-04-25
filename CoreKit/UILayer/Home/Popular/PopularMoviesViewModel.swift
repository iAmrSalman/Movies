//
//  PopularMoviesViewModel.swift
//  CoreKit
//
//  Created by Amr Salman on 25/04/2022.
//

import Foundation
import RxSwift

public final class PopularMoviesViewModel {
    
    // MARK: - Properties
    
    private let repository: MovieRepository
    
    private let popularMoviesSubject = BehaviorSubject<[Int: [MovieListPresentable]]>(value: [:])
    private let errorMessagesSubject = BehaviorSubject<ErrorMessage?>(value: nil)
    private let isLoadingSubject = BehaviorSubject<Bool>(value: false)

    public var list: Observable<[Int: [MovieListPresentable]]> { return self.popularMoviesSubject.asObserver() }
    public var isLoading: Observable<Bool> { return self.isLoadingSubject.asObserver() }
    public var errorMessages: Observable<ErrorMessage?> { return self.errorMessagesSubject.asObserver() }
    public let errorPresentation = PublishSubject<ErrorPresentation?>()

    // State
    let disposeBag = DisposeBag()
    
    // MARK: - Methods
    
    public init(repository: MovieRepository) {
        self.repository = repository
        self.getData()
    }
    
    
    private func getData() {
        isLoadingSubject.onNext(true)
        repository.getPopularMovies(page: 1)
            .compactMap { $0.compactMap(MovieListPresentable.init) }
            .compactMap { Dictionary(grouping: $0, by: { $0.year })}
            .asObservable()
            .subscribe(onNext: { [weak self] in
                guard let strongSelf = self else { return }
                var currentValue = (try? strongSelf.popularMoviesSubject.value()) ?? [:]
                currentValue.merge($0) { current, new in
                    current + new
                }
                strongSelf.popularMoviesSubject.onNext(currentValue)
            }, onError: { [weak self] in
                self?.errorMessagesSubject.onNext(ErrorMessage(error: $0))
            }, onCompleted: { [weak self] in
                self?.isLoadingSubject.onNext(false)
            }).disposed(by: disposeBag)
    }

}
