//
//  ArticleRepository.swift
//  TheJakartaPost
//
//  Created by Slamet Riyadi on 22/09/22.
//

import RxSwift

struct ArticleRepository {
    
    func fetchArticle(viewModel: HomeViewModel) -> Single<ApiResult<ArticleListModel, ErrorModel>> {
        return APIClient.shared.requests(endPoint: ArticleEndPoint.articleList(request: viewModel.request))
    }
    
    func fetchDetailArticle(viewModel: NewsDetailViewModel) -> Single<ApiResult<ArticleListModel, ErrorModel>> {
        return APIClient.shared.requests(endPoint: ArticleEndPoint.articleDetail(request: viewModel.request))
    }
    
}
