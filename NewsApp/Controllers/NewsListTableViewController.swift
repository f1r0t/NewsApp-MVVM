//
//  NewsListTableViewController.swift
//  NewsApp
//
//  Created by Fırat AKBULUT on 24.12.2023.
//

import UIKit

class NewsListTableViewController: UITableViewController{
    
    private var articleListVM: ArticleListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance;
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=f6f7197b2a8e446fab734f29487455b7")!
        
        WebService().getArticles(url: url) { articles in
            switch articles {
            case .success(let articles):
                if let articles = articles{
                    self.articleListVM = ArticleListViewModel(articles: articles)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return articleListVM == nil ? 0 : articleListVM.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleListVM.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell
        
        let articleVM = articleListVM.articleAtIndex(indexPath.row)
        cell?.titleLabel.text = articleVM.title
        cell?.descriptionLabel.text = articleVM.description
        return cell!
    }
    
}
