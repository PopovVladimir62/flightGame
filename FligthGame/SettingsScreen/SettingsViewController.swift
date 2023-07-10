//
//  SettingsViewController.swift
//  FligthGame
//
//  Created by Владимир on 05.07.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    var enemyType: Enemies = .plane
    var tapGesturePictures = [UIView]()
    var speedButtons = [UIButton]()
    var speedRate = 1.0
    var defaultPicture = true
    
    //MARK: - UI elements
    //name
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private lazy var nameTextfield: UITextField = {
        let textField = UITextField()
        textField.placeholder = "enter your name"
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 6
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textAlignment = .center
        textField.addTarget(self, action: #selector(textFieldShouldReturn), for: .editingDidEndOnExit)
        return textField
    }()
    
    //enemies variety
    private var enemyTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Enemy variety"
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private var ufoEnemyPicture: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "ufo")
        return imageView
    }()
    
    private var planeEnemyPicture: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "enemyPlane")
        return imageView
    }()
    
    //game speed
    private var speedTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Game speed"
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private lazy var lowSpeedButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private lazy var midSpeedButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private lazy var hightSpeedButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    //avatar
    private lazy var imageFromPhoto: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.backgroundColor = .systemGray4
        image.image = UIImage(systemName: "plus.viewfinder")
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 10
        
        return image
    }()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupLayout()
    }

    deinit {
        print("settings VC is dead")
    }
    
    //MARK: - selectors
    @objc func textFieldShouldReturn() -> Bool {
        nameTextfield.endEditing(true)
    }
    
    @objc private func choosePic(_ sender: UITapGestureRecognizer) {
        guard let senderView = sender.view else { return }
        for (index, pic) in tapGesturePictures.enumerated() {
            pic.backgroundColor = .white
            if senderView === pic {
                if let value = Enemies(rawValue: index) {
                    enemyType = value
                }
            }
        }
        senderView.backgroundColor = .systemBlue
    }
    
    @objc private func chooseSpeedRate(_ sender: UIButton) {
        speedButtons.forEach{ $0.backgroundColor = .systemGray5 }
        switch sender {
        case lowSpeedButton:
            lowSpeedButton.backgroundColor = .systemBlue
            speedRate = 1.4
        case midSpeedButton:
            midSpeedButton.backgroundColor = .systemBlue
            speedRate = 1
        case hightSpeedButton:
            hightSpeedButton.backgroundColor = .systemBlue
            speedRate = 0.6
        default:
            return
        }
    }
    
    @objc private func chooseAvatar() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc private func saveSettings() {
        let settings = Settings(speedRate: speedRate,
                                enemyVariety: enemyType)
        let user = User(name: nameTextfield.text ?? "player")
        if !defaultPicture {
            if let avatar = saveImage(image: imageFromPhoto.image!) {
                user.avatarID = avatar
            }
        }
        store.usersSettings.append(user)
        store.gameSettings = settings
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - private
    private func setupVC() {
        view.backgroundColor = .white
        tapGestureForEnemyPic(view: ufoEnemyPicture)
        tapGestureForEnemyPic(view: planeEnemyPicture)
        configureButton(button: lowSpeedButton, nameOfSpeed: "low")
        configureButton(button: midSpeedButton, nameOfSpeed: "mid")
        configureButton(button: hightSpeedButton, nameOfSpeed: "hight")
        openImagePicker()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save settings", style: .plain, target: self, action: #selector(saveSettings))
    }
    
    private func openImagePicker() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseAvatar))
        imageFromPhoto.addGestureRecognizer(tapGesture)
    }
    
    private func tapGestureForEnemyPic(view: UIView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(choosePic))
        tapGesturePictures.append(view)
        view.addGestureRecognizer(tapGesture)
    }
    
    private func configureButton(button: UIButton, nameOfSpeed: String) {
        button.addTarget(self, action: #selector(chooseSpeedRate), for: .touchUpInside)
        button.backgroundColor = .systemGray5
        button.setTitle(nameOfSpeed, for: .normal)
        speedButtons.append(button)
    }
    //save avatar
    private func saveImage(image: UIImage) -> String? {
            guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
            
            let fileName = UUID().uuidString
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            guard let data = image.jpegData(compressionQuality: 1) else { return nil}
            
            //Checks if file exists, removes it if so.
            if FileManager.default.fileExists(atPath: fileURL.path) {
                do {
                    try FileManager.default.removeItem(atPath: fileURL.path)
                    print("Removed old image")
                } catch let error {
                    print("couldn't remove file at path", error)
                }
                
            }
            do {
                try data.write(to: fileURL)
                return fileName
            } catch let error {
                print("error saving file with error", error)
                return nil
            }
            
        }
        
    private func loadImage(fileName: String) -> UIImage? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil } // получили имя папки, где должен лежать файл
        let fileURL = documentsDirectory.appendingPathComponent(fileName) // добавили имя файла к имени папки
        let image = UIImage(contentsOfFile: fileURL.path) // прочитали файл, превратив его в UIImage
        return image // вернули картинку
        }
    
    //MARK: - layout
    private func setupLayout() {
        //name
        let nameStackview = UIStackView()
        nameStackview.axis = .vertical
        nameStackview.distribution = .fillProportionally
        nameStackview.spacing = .spasingInsideStackview
        nameStackview.addArrangedSubview(nameLabel)
        nameStackview.addArrangedSubview(nameTextfield)
        
        //enemy variety
        ufoEnemyPicture.snp.makeConstraints { make in
            make.size.equalTo(CGFloat.enemySize * 1.2)
        }
        planeEnemyPicture.snp.makeConstraints { make in
            make.size.equalTo(CGFloat.enemySize * 1.2)
        }

        let enemyPicStackview = UIStackView()
        enemyPicStackview.axis = .horizontal
        enemyPicStackview.distribution = .fillEqually
        enemyPicStackview.spacing = .spasingInsideStackview
        enemyPicStackview.addArrangedSubview(ufoEnemyPicture)
        enemyPicStackview.addArrangedSubview(planeEnemyPicture)
        
        let enemyStackview = UIStackView()
        enemyStackview.axis = .vertical
        enemyStackview.distribution = .fillProportionally
        enemyStackview.spacing = .spasingInsideStackview
        enemyStackview.addArrangedSubview(enemyTitleLabel)
        enemyStackview.addArrangedSubview(enemyPicStackview)
        
        //speed elements
        let speedButtonsStackview = UIStackView()
        speedButtonsStackview.axis = .horizontal
        speedButtonsStackview.distribution = .fillEqually
        speedButtonsStackview.spacing = 2
        speedButtonsStackview.addArrangedSubview(lowSpeedButton)
        speedButtonsStackview.addArrangedSubview(midSpeedButton)
        speedButtonsStackview.addArrangedSubview(hightSpeedButton)
        
        let speedElementsStackview = UIStackView()
        speedElementsStackview.axis = .vertical
        speedElementsStackview.distribution = .fillProportionally
        speedElementsStackview.spacing = .spasingInsideStackview
        speedElementsStackview.addArrangedSubview(speedTitleLabel)
        speedElementsStackview.addArrangedSubview(speedButtonsStackview)
        
        //own stackview
        let ownStackview = UIStackView()
        ownStackview.axis = .vertical
        ownStackview.distribution = .fillProportionally
        ownStackview.spacing = .spasingBetweenStackviews
        ownStackview.addArrangedSubview(nameStackview)
        ownStackview.addArrangedSubview(enemyStackview)
        ownStackview.addArrangedSubview(speedElementsStackview)
        view.addSubview(ownStackview)
        ownStackview.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(CGFloat.leftInset)
            make.top.equalToSuperview().offset(CGFloat.topInset)
        }
        view.addSubview(imageFromPhoto)
        imageFromPhoto.snp.makeConstraints { make in
            make.size.equalTo(ownStackview.snp.width)
            make.leading.equalTo(CGFloat.leftInset)
            make.top.equalTo(ownStackview.snp.bottom).offset(CGFloat.spasingBetweenStackviews)
        }
    }
}
    //MARK: - extensions
extension SettingsViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        imageFromPhoto.image = image
        defaultPicture = false
    }
}
