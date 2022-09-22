//
//  NewsDetailCoordinator.swift
//  TheJakartaPost
//
//  Created by Slamet Riyadi on 22/09/22.
//

import RxSwift

class NewsDetailCoordinator: ReactiveCoordinator<Void> {
    
    private let rootViewController: UIViewController
    private let path: String
    
    init(viewController: UIViewController, path: String) {
        self.rootViewController = viewController
        self.path = path
    }
    
    override func start() -> Observable<Void> {
        setView()
        return Observable.never()
    }
    
    private func setView() {
        let viewModel = NewsDetailViewModel(path: path)
        let viewController = NewsDetailView(viewModel: viewModel)
        
        rootViewController.navigationController?.pushViewController(viewController, animated: true)
    }
}

