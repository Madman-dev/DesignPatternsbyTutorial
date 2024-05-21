//
//  PersonView.swift
//  MVVMCrashCourse
//
//  Created by Porori on 5/21/24.
//

import UIKit

class PersonView: UIView {
    
    private lazy var followBtn: UIButton = {
        
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Follow Me"
        configuration.baseBackgroundColor = .red
        configuration.baseForegroundColor = .white
        configuration.buttonSize = .large
        configuration.cornerStyle = .medium
        
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapFollow), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일을 입력해주세요"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름을 작성해주세요"
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var personStackview: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private var action: () -> ()
    
    init(action: @escaping () -> Void) {
        self.action = action
        super.init(frame: .zero)
        setup()
    }
    
    // no longer needed
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(name: String, email: String) {
        nameLabel.text = name
        emailLabel.text = email
    }
}

extension PersonView {
    func setup() {
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(personStackview)
        personStackview.addArrangedSubview(nameLabel)
        personStackview.addArrangedSubview(emailLabel)
        personStackview.addArrangedSubview(followBtn)
        
        NSLayoutConstraint.activate([
            personStackview.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            personStackview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            personStackview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            personStackview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
    
    @objc func didTapFollow() {
        action()
    }
}
