//
//  NewsDetailViewModel.swift
//  TheJakartaPost
//
//  Created by Slamet Riyadi on 22/09/22.
//

import RxSwift
import RxCocoa

class NewsDetailViewModel: BaseViewModel {
    
    var repository = ArticleRepository()
    var request = ArticleRequest.shared
    var _article = BehaviorRelay<Article?>(value: nil)
    
    init(path: String) {
        self.request.path = path
    }
    
    var article: Driver<Article?> {
        return _article.asDriver()
    }
    
    private func fetchArticleDetail() {
        guard Reachability.shared.isConnectedToNetwork == true else {
            self.error.onNext(ErrorModel(APIClientError.noInternetConnection.localizedDescription))
            return
        }
        
        self.state.onNext(.loading)
        self.request.allowNextRequest = false
        
        repository.fetchDetailArticle(viewModel: self)
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] result in
                switch result {
                case .success(let model):
                    if let data = model.data?[0] {
                        self._article.accept(data)
                        self.state.onNext(.finish)
                    } else {
                        self.state.onNext(.error)
                    }
                case .failure(let error):
                    self.error.onNext(error)
                    self.state.onNext(.finish)
                }
                
                self.request.allowNextRequest = true
            }, onError: { [unowned self] error in
                self.state.onNext(.error)
            }).disposed(by: disposeBag)
    }
}

extension NewsDetailViewModel {
    
    func willAppear() {
        fetchArticleDetail()
    }
    
}
