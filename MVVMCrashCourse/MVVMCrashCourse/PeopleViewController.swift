//
//  ViewController.swift
//  MVVMCrashCourse
//
//  Created by Porori on 5/21/24.
//

import UIKit

class PeopleViewController: UIViewController {

    private lazy var personContainer = PersonView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        print("뷰컨이 활성화됐어요")
    }
}

private extension PeopleViewController {
    func setup() {
        view.backgroundColor = .black
        view.addSubview(personContainer)
        
        NSLayoutConstraint.activate([
            personContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            personContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            personContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
        ])
    }
}

