//
//  AuthorPhotosCollectionViewCell.swift
//  FinallyApp
//
//  Created by Ernazar on 20/9/23.
//

import UIKit

class AuthorPhotosCollectionViewCell: UICollectionViewCell {
    private lazy var photoImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
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
    
    func configure(model: ResultPhoto) {
        guard let url = URL(string: model.urls?.small ?? "") else { return }
        photoImageView.kf.setImage(
            with: url,
            placeholder: UIImage.init(
                blurHash: model.blurHash ?? "",
                size: CGSize(width: (model.width ?? 120) / 120, height: (model.height ?? 120) / 120)
            )
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
