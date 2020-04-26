//
//  SettingViewController.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 06.03.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD
import SDWebImage

protocol LogoutDelegate: class {
    func handleLogout()
}

class SettingsTableViewController: UITableViewController {
    
    weak var delegate: LogoutDelegate?
    
    private var user: AppUser?
    
    fileprivate lazy var image1Button = createButton(selector: #selector(handleSelectPhoto))
    fileprivate lazy var image2Button = createButton(selector: #selector(handleSelectPhoto))
    fileprivate lazy var image3Button = createButton(selector: #selector(handleSelectPhoto))
    
    fileprivate lazy var header: UIView = {
        let header = UIView()
        //header.backgroundColor = .systemFill
        header.addSubview(image1Button)
        image1Button.backgroundColor = .white
        image2Button.backgroundColor = .white
        image3Button.backgroundColor = .white
        image1Button.anchor(top: header.topAnchor, leading: header.leadingAnchor, bottom: header.bottomAnchor, trailing: nil, padding: .init(top: padding, left: padding, bottom: padding, right: 0))
        image1Button.widthAnchor.constraint(equalTo: header.widthAnchor, multiplier: 0.45).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [image2Button, image3Button])
        header.addSubview(stackView)
        stackView.anchor(top: header.topAnchor, leading: image1Button.trailingAnchor, bottom: header.bottomAnchor, trailing: header.trailingAnchor, padding: .init(top: padding, left: padding, bottom: padding, right: padding))
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return header
    }()
    
    fileprivate var selectedButton: UIButton?
    
    fileprivate let padding: CGFloat = 16
    
    fileprivate class HeaderLabel: UILabel {
        
        override func drawText(in rect: CGRect) {
            super.drawText(in: rect.insetBy(dx: 16, dy: 0))
        }
    }
    
    fileprivate enum CellType: Int {
        case nameCell = 1
        case speciesCell
        case ageCell
        case descriptionCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
        fetchCurrentUser()
    }
    
    fileprivate func setupTableView() {
        tableView.backgroundColor = .secondarySystemBackground
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .interactive
        tableView.separatorStyle = .none
    }
    
    fileprivate func setupNavigationBar() {
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave)),
            UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        ]
    }
    
    fileprivate func createButton(selector: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return header
        }
        
        let cellType = CellType(rawValue: section)
        let header = HeaderLabel()
        
        switch cellType {
        case .nameCell:
            header.text = "Имя"
        case .ageCell:
            header.text = "Возраст"
        case .descriptionCell:
            header.text = "Описание"
        case.speciesCell:
            header.text = "Порода"
        default:
            ()
        }
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 300 : 40
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 0 : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingsTableViewCell(style: .default, reuseIdentifier: nil)
        let cellType = CellType(rawValue: indexPath.section)
        
        switch cellType {
        case .nameCell:
            cell.textField.placeholder = "Введите имя питомца"
            cell.textField.text = user?.name
            cell.textField.addTarget(self, action: #selector(handleNameChange), for: .editingChanged)
        case .ageCell:
            cell.textField.placeholder = "Введите возраст питомца"
            if let age = user?.age {
                cell.textField.text = String(age)
            }
            cell.textField.addTarget(self, action: #selector(handleAgeChange), for: .editingChanged)
        case .descriptionCell:
            cell.textField.placeholder = "Характер, цвет глаз и т.п"
            cell.textField.text = user?.description
            cell.textField.addTarget(self, action: #selector(handleDescriptionChange), for: .editingChanged)
        case .speciesCell:
            cell.textField.placeholder = "Введите породу питомца (не обязательно)"
            cell.textField.text = user?.species
            cell.textField.addTarget(self, action: #selector(handleSpeciesChange), for: .editingChanged)
        default:
            ()
        }
        
        return cell
    }
    
    fileprivate func fetchCurrentUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid).getDocument { [unowned self] (snapshot, error) in
            if let err = error {
                print(error?.localizedDescription)
                return
            }
            
            guard let dictionary = snapshot?.data() else { return }
            self.user = AppUser(dictionary: dictionary)
            self.loadUserPhotos()
            self.tableView.reloadData()
        }
        
    }
    
    fileprivate func loadUserPhotos() {
        guard let imageURL = user?.imageNames.first, let url = URL(string: imageURL) else { return }
        SDWebImageManager.shared.loadImage(with: url, options: .continueInBackground, progress: nil) { [unowned self] (image, _, _, _, _, _) in
            self.image1Button.setImage(image?.withRenderingMode(.alwaysOriginal), for:  .normal)
        }
    }
    
    @objc fileprivate func handleCancel() {
        dismiss(animated: true)
    }
    
    @objc fileprivate func handleSelectPhoto(button: UIButton) {
        selectedButton = button
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    @objc fileprivate func handleSave() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let documentData: [String: Any] = [
            "uid": uid,
            "fullName": user?.name,
            "imageURLs": user?.imageNames,
            "age": user?.age,
            "description": user?.description,
            "species": user?.species
        ]
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Сохраняем..."
        hud.show(in: view)
            Firestore.firestore().collection("users").document(uid).setData(documentData) { (error) in
            hud.dismiss()
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            print("Finished saving user info")
            self.dismiss(animated: true)
        }
    }
    
    @objc fileprivate func handleLogout() {
        delegate?.handleLogout()
    }
    
    @objc fileprivate func handleNameChange(textField: UITextField) {
        self.user?.name = textField.text
    }
    
    @objc fileprivate func handleAgeChange(textField: UITextField) {
        self.user?.age = Int(textField.text ?? "")
    }
    
    @objc fileprivate func handleDescriptionChange(textField: UITextField) {
        self.user?.description = textField.text
    }
    
    @objc fileprivate func handleSpeciesChange(textField: UITextField) {
        self.user?.species = textField.text
    }
}

extension SettingsTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.originalImage] as? UIImage
        selectedButton?.setImage(selectedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        selectedButton?.setTitle("", for: .normal)
        dismiss(animated: true)
        
        let filename = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "/image/\(filename)")
        guard let uploadData = selectedImage?.jpegData(compressionQuality: 0.7) else { return }
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Загрузка изображения..."
        hud.show(in: view)
        ref.putData(uploadData, metadata: nil) { (nil, err) in

            if let error = err {
                hud.dismiss()
                print(error.localizedDescription)
            }
            
            print("Finished uploading image")
            ref.downloadURL { (url, error) in
                hud.dismiss()
                if let error = error {
                    print(error.localizedDescription)
                }
                
                print("Finished getting url", url?.absoluteString ?? "")
            }
        }
    }
}
