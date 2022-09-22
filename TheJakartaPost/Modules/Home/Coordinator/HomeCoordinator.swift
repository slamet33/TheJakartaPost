//
//  HomeCoordinator.swift
//  TheJakartaPost
//
//  Created by Slamet Riyadi on 22/09/22.
//

import RxSwift

class HomeCoordinator: ReactiveCoordinator<Void> {
    
    private let window: UIWindow
    private var viewModel = HomeViewModel()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let viewController = HomeView(viewModel: viewModel)
        let navigationViewController = UINavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
        window.rootViewController = navigationViewController
        UIView.transition(with: window,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
        
        viewModel.navigateToNewsDetail
            .flatMapLatest({ [unowned self] path in
                return self.coordinateToDetailRoom(vc: viewController, path: path)
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        return Observable.never()
    }
    
    private func bindRoute() {
        
        
    }
    
    private func coordinateToDetailRoom(vc: UIViewController, path: String) -> Observable<Void> {
        let coordinator = NewsDetailCoordinator(viewController: vc, path: path)
        return coordinate(to: coordinator)
            .map { _ in () }
    }
}
