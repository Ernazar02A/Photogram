//
//  ImageCollectionViewCell.swift
//  FinallyApp
//
//  Created by Ernazar on 27/8/23.
//

import UIKit
import Kingfisher

class ImageCollectionViewCell: UICollectionViewCell {
    static let cellId = "ImageCollectionViewCell"
    
    private lazy var bgView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        setupSubview()
        setupConstraints()
    }
    
    private func setupSubview() {
        contentView.addSubview(bgView)
        bgView.addSubview(imageView)
    }
    
    private func setupConstraints() {
        let bgViewConstraints = [
            bgView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 0
            ),
            bgView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: 0
            ),
            bgView.heightAnchor.constraint(
                equalToConstant: 250
            )
        ]
        let imageViewConstraints = [
            imageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 0
            ),
            imageView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: 0
            ),
            imageView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: 0
            ),
            imageView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 0
            )
        ]
        
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(bgViewConstraints)
    }
    
    func setupData(model: String) {
        let url = URL(string: model)!
        imageView.kf.setImage(with: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
