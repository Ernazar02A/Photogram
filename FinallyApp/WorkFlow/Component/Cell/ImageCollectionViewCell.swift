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
    private lazy var photoImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 15
        return view
    }()
    private lazy var favoriteButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        //view.backgroundColor = .black
        view.tintColor = .red
        view.layer.cornerRadius = 10
        return view
    }()
    private lazy var authorNameLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = .italicSystemFont(ofSize: 12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewModel: ImageCollectionViewCellViewModelProtocol! {
        didSet {
            let url = URL(string: viewModel.image)!
            photoImageView.kf.setImage(with: url)
            authorNameLabel.text = viewModel.userName
            viewModel.viewModelDidChange = { [weak self] viewModel in
                self?.setStatusForFavoriteButton()
            }
            setStatusForFavoriteButton()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        contentView.isUserInteractionEnabled = false
    }
    
    @objc private func favoriteButtonTapped(_ sender: UIButton) {
        viewModel.favoriteButtonTapped()
    }
    
    private func setup() {
        setupSubview()
        setupConstraints()
    }
    
    private func setupSubview() {
        contentView.addSubview(bgView)
        bgView.addSubview(photoImageView)
        bgView.addSubview(authorNameLabel)
        bgView.addSubview(favoriteButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 0),
            bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: 0),
            bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: 0),
            bgView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 0),
            
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 0),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: 0),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: 0),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            
            authorNameLabel.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor,constant: 0),
            authorNameLabel.bottomAnchor.constraint(equalTo: photoImageView.topAnchor,constant: 0),
            
            favoriteButton.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor,constant: 0),
            favoriteButton.bottomAnchor.constraint(equalTo: photoImageView.topAnchor,constant: 0),
            favoriteButton.heightAnchor.constraint(equalToConstant: 20),
            favoriteButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
    private func setStatusForFavoriteButton() {
        let image = UIImage(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
        favoriteButton.setImage(image, for: .normal)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {

        guard isUserInteractionEnabled else { return nil }

        guard !isHidden else { return nil }

        guard alpha >= 0.01 else { return nil }

        guard self.point(inside: point, with: event) else { return nil }


        // add one of these blocks for each button in our collection view cell we want to actually work
        if self.favoriteButton.point(inside: convert(point, to: favoriteButton), with: event) {
            return self.favoriteButton
        }

        return super.hitTest(point, with: event)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
