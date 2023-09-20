//
//  PhotoCollectionViewCell.swift
//  FinallyApp
//
//  Created by Ernazar on 20/9/23.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    private lazy var photoImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    private func setup() {
        setupSubview()
        setupConstraints()
    }
    
    private func setupSubview() {
        contentView.addSubview(photoImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 0),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: 0),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: 0),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 0),
        ])
    }
    
    func configure(url: URL?) {
        guard url != nil else { return }
        photoImageView.kf.setImage(with: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
