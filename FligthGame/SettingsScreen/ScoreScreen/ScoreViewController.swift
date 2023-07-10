//
//  ScoreViewController.swift
//  FligthGame
//
//  Created by Владимир on 10.07.2023.
//

import UIKit

 final class ScoreViewController: UIViewController {
     
     //MARK: - table view
     private lazy var scoreTableView: UITableView = {
         let tableView = UITableView()
         tableView.rowHeight = UITableView.automaticDimension
         tableView.estimatedRowHeight = 44
         tableView.register(ScoreTableViewCell.self, forCellReuseIdentifier: ScoreTableViewCell.identifier)
         tableView.dataSource = self
         tableView.delegate = self
         
         return tableView
     }()
     
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupLayout()
    }
     
     deinit {
         print("ScoreViewController is dead")
     }
     
    //MARK: - private
    private func setupVC() {
        view.backgroundColor = .white
        view.addSubview(scoreTableView)
    }
    
     //MARK: - layout
    private func setupLayout() {
        scoreTableView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(CGFloat.leftInset)
        }
    }
}
    //MARK: - extension table view
extension ScoreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        store.usersSettings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScoreTableViewCell.identifier, for: indexPath) as! ScoreTableViewCell
        let scoreList = store.usersSettings.sorted(by: {$0.score > $1.score})
        cell.setupCell(position: "\(indexPath.row + 1)",
                       name: "\(scoreList[indexPath.row].name)",
                       score: scoreList[indexPath.row].score)
        return cell
    }
    
}
