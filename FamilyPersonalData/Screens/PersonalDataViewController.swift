//
//  ViewController.swift
//  FamilyPersonalData
//
//  Created by Elvis on 24.10.2022.
//

import UIKit
import SnapKit
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields

final class PersonalDataViewController: UIViewController {
    
    private let reuseIdentifier = ChildrenCell.reuseIdentifier
    private let tableView = UITableView()
    
    private var childrenData = [String]()
    
    private let nameTextField: MDCFilledTextField = {
        let textField = MDCFilledTextField()
        textField.label.text = "Имя"
        textField.layer.borderColor = .init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        textField.layer.borderWidth = 2
        textField.setFilledBackgroundColor(.clear, for: .editing)
        textField.setFilledBackgroundColor(.clear, for: .normal)
        textField.setFloatingLabelColor(.systemGray, for: .editing)
        textField.setFloatingLabelColor(.systemGray, for: .normal)
        return textField
    }()
    
    private let ageTextField: MDCFilledTextField = {
        let textField = MDCFilledTextField()
        textField.label.text = "Возраст"
        textField.layer.borderColor = .init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        textField.layer.borderWidth = 2
        textField.setFilledBackgroundColor(.clear, for: .editing)
        textField.setFilledBackgroundColor(.clear, for: .normal)
        textField.setFloatingLabelColor(.systemGray, for: .editing)
        textField.setFloatingLabelColor(.systemGray, for: .normal)
        return textField
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Дети (макс.5)"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "plus")
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor.customBlue.cgColor
        button.setTitle("Добавить ребенка", for: .normal)
        button.setImage(image, for: .normal)
        button.setTitleColor(.customBlue, for: .normal)
        button.tintColor = .customBlue
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor.customRed.cgColor
        button.setTitle("Очистить", for: .normal)
        button.setTitleColor(.customRed, for: .normal)
        button.tintColor = .customRed
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(clearButtonAction), for: .touchUpInside)
        return button
    }()
    
//  MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        setupViews()
        setupTableView()
    }
    
//    MARK: - Actions
    @objc func addButtonAction() {
        if childrenData.count == 5 {
            addButton.isHidden = true
        } else if childrenData.count < 5 {
            childrenData.append("")
            tableView.reloadData()
        }
    }
    
    @objc func clearButtonAction() {
        let actionSheet = UIAlertController(
            title: "Внимание!",
            message: "Вы действительно хотите сбросить все данные?",
            preferredStyle: .actionSheet
        )
        actionSheet.addAction(UIAlertAction(title: "Сбросить данные", style: .destructive, handler: { [weak self] _ in
            guard let self = self else { return }
            self.clearDelegate?.clearTextFields()
            self.childrenData.removeAll()
            self.nameTextField.text?.removeAll()
            self.ageTextField.text?.removeAll()
            self.addButton.isHidden = false
            self.tableView.reloadData()
        }))
        actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil )
    }
    
//    MARK: - SETUP Methods
    private func setupNavBar() {
        let titleLabel = UILabel()
        titleLabel.text = "Персональные данные"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .darkText
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }
    
    private func setupViews() {
        view.addSubview(nameTextField)
        view.addSubview(ageTextField)
        view.addSubview(addButton)
        view.addSubview(label)
        view.addSubview(clearButton)
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        ageTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        addButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(ageTextField.snp.bottom).offset(10)
            make.height.equalTo(50)
            make.width.equalTo(230)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalTo(addButton.snp.centerY)
        }
        
        clearButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(40)
            make.height.equalTo(50)
            make.width.equalTo(230)
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChildrenCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(addButton.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(clearButton.snp.top).offset(-5)
        }
    }
}

//  MARK: - Delegate and Data Source
extension PersonalDataViewController: UITableViewDelegate, UITableViewDataSource, DeleteDataDelegate {
    
    func deleteCell(cell: ChildrenCell) {
            childrenData.remove(at: cell.indexPath.row)
            tableView.reloadData()
        if childrenData.count < 5 {
            addButton.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childrenData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChildrenCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ChildrenCell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 174
    }
}
