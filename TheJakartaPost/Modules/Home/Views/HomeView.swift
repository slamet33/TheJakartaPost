//
//  HomeView.swift
//  TheJakartaPost
//
//  Created by Slamet Riyadi on 22/09/22.
//

import RxSwift
import RxCocoa

class HomeView: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: HomeViewModel
    private let disposeBag = DisposeBag()
    
    lazy internal var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControl.Event.valueChanged)
        
        return refreshControl
    }()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "HomeView", bundle: Bundle(for: type(of: self)))
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
        
        setupViews()
        bindView()
    }
    
    private func setupViews() {
        title = "Home"
        
        tableView.addSubview(refreshControl)
        tableView.registerXIB([NewsTableCell.self])
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
    }
    
    private func bindView() {
        viewModel._articleList
            .asDriver()
            .drive(onNext: {[unowned self] (_) in
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
        
        viewModel.state
            .asObservable()
            .subscribe(onNext: { [unowned self] state in
                switch state {
                case .loading:
                    print("Loading")
                case .finish:
                    print("Finished")
                default:
                    break
                }
            }).disposed(by: disposeBag)
        
        viewModel.error
            .asObservable()
            .subscribe(onNext: { [unowned self] error in
                self.showMessage(error.message ?? "Network Error", title: "Failed") {
                    self.viewModel.willAppear()
                }
            }).disposed(by: disposeBag)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        viewModel.willAppear()
        self.refreshControl.endRefreshing()
    }
}

extension HomeView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.tableView(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.tableView(tableView, didSelectRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.willDisplayCell(at: indexPath.row)
    }
}
