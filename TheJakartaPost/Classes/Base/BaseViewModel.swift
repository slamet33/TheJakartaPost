//
//  BaseViewModel.swift
//  TheJakartaPost
//
//  Created by Slamet Riyadi on 20/09/22.
//

import RxSwift

enum NetworkState {
    case initial
    case loading
    case finish
    case error
}

enum DataLoadState {
    case newest
    case loadmore
}

class BaseViewModel {
    
    let disposeBag = DisposeBag()
    var state = PublishSubject<NetworkState>()
    var hudState = PublishSubject<NetworkState>()
    var error = PublishSubject<ErrorModel>()
    
}
