//
//  ChildrenCell.swift
//  FamilyPersonalData
//
//  Created by Elvis on 25.10.2022.
//

import UIKit
import SnapKit
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields

final class ChildrenCell: UITableViewCell {
    
    static let reuseIdentifier = "ChildrenCell"
    
    var indexPath: IndexPath!
    weak var delegate: DeleteDataDelegate?
    
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
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.customBlue, for: .normal)
        button.setTitle("Удалить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(deleteCell), for: .touchUpInside)
        return button
    }()
  
//    MARK: - Initialize
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Action
    @objc func deleteCell() {
        delegate?.deleteCell(cell: self)
        nameTextField.text?.removeAll()
        ageTextField.text?.removeAll()
    }
    
//    MARK: - Setup UI
    private func setupViews() {
        contentView.addSubview(nameTextField)
        contentView.addSubview(ageTextField)
        contentView.addSubview(deleteButton)
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.greaterThanOrEqualToSuperview().inset(170)
        }
        
        ageTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.greaterThanOrEqualToSuperview().inset(170)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.leading.equalTo(nameTextField.snp.trailing).offset(20)
            make.centerY.equalTo(nameTextField.snp.centerY)
        }
    }
}
