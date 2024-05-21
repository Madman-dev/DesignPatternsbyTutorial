//
//  PersonCollectionviewCell.swift
//  MVVMCrashCourse
//
//  Created by Porori on 5/21/24.
//

import UIKit

protocol PersonCollectionviewCellDelegate: AnyObject {
    func didTapFollow()
}

class PersonCollectionviewCell: UICollectionViewCell {
    weak var delegate: PersonCollectionviewCellDelegate?
    private var view: PersonView?
    var item: PersonResponse? {
        didSet {
            print(item)
            guard let firstName = item?.firstName,
                  let lastName = item?.lastName,
                  let email = item?.email else {
                return
            }
            view?.set(name: "\(firstName) \(lastName)", email: email)
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PersonCollectionviewCell {
    func setup() {
        guard view == nil else { return }
        view = PersonView { [weak self] in
            print("생성되었습니다")
            self?.delegate?.didTapFollow()
        }
        
        contentView.addSubview(view!)
        NSLayoutConstraint.activate([
            view!.topAnchor.constraint(equalTo: contentView.topAnchor),
            view!.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            view!.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 8),
            view!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
}
