//
//  HomeController.swift
//  VideoGamesApp
//
//  Created by hasanberk yigit on 31.03.2021.
//

import UIKit

class HomeController: UIViewController {
    private let viewModel = GamesViewModel()
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.tableFooterView = UIView()
            tableView.registerHomeTableCell()
            tableView.rowHeight = UITableView.automaticDimension
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet var searchBar: UISearchBar! {
        didSet {
            self.searchBar.delegate = self
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSearchBarView()
        bindGames()
        bindLoading()
        viewModel.fetchRequest()
        
    }
    
    private func initSearchBarView() {
        let textFieldInsideSearchBar = self.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.lightGray
        textFieldInsideSearchBar?.background = UIImage(named: "search_bg_gray")
        textFieldInsideSearchBar?.borderStyle = .none
        self.searchBar.searchTextPositionAdjustment = UIOffset(horizontal: 4, vertical: 0)
    }
    
    private func bindGames(){
        viewModel
            .games
            .subscribe(onNext: {[weak self] _ in
                self?.initTableHeaderView()
                self?.tableView.reloadData()
            })
            .disposed(by: viewModel.disposeBag)
    }
    private func bindLoading(){
        viewModel
            .isLoading
            .subscribe(onNext: {[weak self] isLoading in
                guard isLoading else {
                    self?.view.hideLoading()
                    return
                }
                self?.view.showLoading(value: 3, color: .black)
            })
            .disposed(by: viewModel.disposeBag)
    }
    private func initTableHeaderView(){
        guard let headerViewModel = viewModel.headerViewModel, viewModel.numberOfRowsInSection() > 0 else { return }
        let headerView = HomeHeaderPagerView()
        headerView.frame.size.height = self.view.frame.height * 0.3
        headerView.setViewModel(viewModel: headerViewModel)
        tableView.tableHeaderView = headerView
    }
    
    private func toggleSearchResults(to visibility: Bool) {
        if visibility {
            tableView.tableHeaderView = nil
            tableView.tableHeaderView?.frame.size.height = 0.0
        } else {
            self.tableView.reloadData()
            initTableHeaderView()
        }
    }
}


extension HomeController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath) as? HomeTableCell else {
            return UITableViewCell()
        }
        cell.configure(game: viewModel.cellForRowAt(index: indexPath.row))
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.isLastRow(indexPath: indexPath){
            viewModel.nextPage()
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(identifier: "DetailsVC") as DetailViewController
        detailVC.setViewModel(viewModel: viewModel.didSelectRowAt(index: indexPath.row))
        detailVC.modalPresentationStyle = .fullScreen
        self.present(detailVC, animated: true, completion: nil)
    }
}


extension HomeController: UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.toggleSearchResults(to: false)
        self.view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        if searchBar.text?.count ?? 0 < 3 {
            self.toggleSearchResults(to: false)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.count > 2 {
            toggleSearchResults(to: true)
            viewModel.triggerSearch(key: searchBar.text!)
        } else {
            self.toggleSearchResults(to: false)
            self.viewModel.load()
            self.tableView.reloadData()
        }
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
}
