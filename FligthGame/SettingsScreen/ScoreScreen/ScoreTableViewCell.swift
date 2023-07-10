//
//  ScoreTableViewCell.swift
//  FligthGame
//
//  Created by Владимир on 10.07.2023.
//

import UIKit

final class ScoreTableViewCell: UITableViewCell {
    //MARK: - UI elements
    var scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "No data"
        label.font = UIFont.systemFont(ofSize: 25)
        
        return label
    }()
    
    var positionLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = UIFont.systemFont(ofSize: 25)
        
        return label
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont.systemFont(ofSize: 25)
        
        return label
    }()

    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        scoreLabel.text = nil
        nameLabel.text = nil
        positionLabel.text = nil
    }
    
    //MARK: - public
    func setupCell(position: String, name: String, score: Int) {
        positionLabel.text = "\(position) - "
        if name.isEmpty{
            nameLabel.text = "Player: "
        } else {
            nameLabel.text = "\(name): "
        }
        scoreLabel.text = "\(score)"
    }
    
    //MARK: - private    
    private func setupLayout() {
        let stackView = UIStackView()
        addSubview(stackView)
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        stackView.addArrangedSubview(positionLabel)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(scoreLabel)
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
    }
}
