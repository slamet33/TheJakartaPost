//
//  AppCoordinator.swift
//  TheJakartaPost
//
//  Created by Slamet Riyadi on 20/09/22.
//

import RxSwift

class AppCoordinator: ReactiveCoordinator<Void> {
    
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let coordinator = HomeCoordinator(window: window)
        return coordinate(to: coordinator)
    }
    
}
