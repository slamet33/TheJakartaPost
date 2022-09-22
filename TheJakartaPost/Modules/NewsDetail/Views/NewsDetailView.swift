//
//  NewsDetailView.swift
//  TheJakartaPost
//
//  Created by Slamet Riyadi on 22/09/22.
//

import RxSwift
import RxCocoa

class NewsDetailView: UIViewController {

    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet var bordersLine: [UIView]!
    
    var viewModel: NewsDetailViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: NewsDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "NewsDetailView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.willAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindView()
    }
    
    private func bindView() {
        viewModel._article
            .asDriver()
            .drive(onNext: {[unowned self] (_) in
                self.setViews()
            }).disposed(by: disposeBag)
        
        viewModel.error
            .asObservable()
            .subscribe(onNext: { [unowned self] error in
                self.showMessage(error.message ?? "Network Error", title: "Failed") {
                    self.viewModel.willAppear()
                }
            }).disposed(by: disposeBag)
    }
    
    private func setViews() {
        guard let data = viewModel._article.value else { return }
        titleLbl.text = data.title
        descriptionLbl.text = data.summary
        dateLbl.text = data.publishedDate
        author.text = data.writer?.name
        contentLbl.attributedText = data.content?.htmlToAttributedString
        if let path = data.gallery?[0].pathLarge {
            imgView.setImageFromNetwork(url: path)
        }
        
        bordersLine.forEach {
            $0.backgroundColor = .systemGray5
        }
    }

}
