//
//  ViewController.swift
//  MVVMCrashCourse
//
//  Created by Porori on 5/21/24.
//

import UIKit
import SafariServices

class PeopleViewController: UIViewController {
    
    private lazy var collectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: UIScreen.main.bounds.width, height: 130)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(PersonCollectionviewCell.self, forCellWithReuseIdentifier: "PersonCollectionviewCell")
        cv.dataSource = self
        return cv
    }()
    
    private let vm = PeopleViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        print("뷰컨이 활성화됐어요")
        vm.delegate = self
        vm.getUsers()
    }
}

private extension PeopleViewController {
    func setup() {
        navigationItem.title = "People"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .black
        view.addSubview(collectionview)
        
        NSLayoutConstraint.activate([
            collectionview.topAnchor.constraint(equalTo: view.topAnchor),
            collectionview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionview.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension PeopleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        vm.people.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = vm.people[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCollectionviewCell", for: indexPath) as! PersonCollectionviewCell
        cell.delegate = self
        cell.item = item
        return cell
    }
}

extension PeopleViewController: PeopleViewModelDelegate {
    func didFinish() {
        collectionview.reloadData()
    }
    
    func didFail(error: any Error) {
        print("에러가 발생했습니다. \(error)")
    }
}

extension PeopleViewController: PersonCollectionviewCellDelegate {
    func didTapFollow() {
        let url = URL(string: "https://www.naver.com")!
        let vc = SFSafariViewController(url: url)
        vc.modalPresentationStyle = .formSheet
        self.present(vc, animated: true)
    }
}
