//
//  HomeViewModel.swift
//  TheJakartaPost
//
//  Created by Slamet Riyadi on 22/09/22.
//

import RxSwift
import RxCocoa

class HomeViewModel: BaseViewModel {
    
    var repository = ArticleRepository()
    var navigateToNewsDetail = PublishSubject<String>()
    var request = ArticleRequest.shared
    
    var _articleList = BehaviorRelay<[Article]?>(value: nil)
    
    var articleList: Driver<[Article]?> {
        return _articleList.asDriver()
    }
    
    private func fetchArticle() {
        guard Reachability.shared.isConnectedToNetwork == true else {
            self.error.onNext(ErrorModel(APIClientError.noInternetConnection.localizedDescription))
            return
        }
        
        self.state.onNext(.loading)
        self.request.allowNextRequest = false
        
        repository.fetchArticle(viewModel: self)
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] result in
                switch result {
                case .success(let model):
                    if let data = model.data {
                        if self.request.page == 1 {
                            self._articleList.accept(data)
                        } else {
                            if let list = _articleList.value {
                                self._articleList.accept(list + data)
                            }
                        }
                    }
                    self.state.onNext(.finish)
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

extension HomeViewModel {
    
    func willAppear() {
        fetchArticle()
    }
    
    func willDisplayCell(at index: Int) {
        if request.allowNextRequest, index == numberOfRow() - 1 {
            self.request.page += 1
            self.fetchArticle()
        }
    }
    
    func numberOfRow() -> Int {
        return _articleList.value?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableCell.defaultIdentifier, for: indexPath) as? NewsTableCell else {
            return UITableViewCell()
        }
        if let data = _articleList.value?[indexPath.row] {
            cell.bindView(data: data)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let path = _articleList.value?[indexPath.row].path {
            navigateToNewsDetail.onNext(path)
        }
    }
}
