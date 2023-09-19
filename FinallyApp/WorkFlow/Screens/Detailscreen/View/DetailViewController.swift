//
//  DetailViewController.swift
//  FinallyApp
//
//  Created by Ernazar on 1/9/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    private lazy var photoImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var authorImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var authorNameLabel = ViewMaker.shared.makeLabel(font: .systemFont(ofSize: 16, weight: .medium))
    private lazy var dateCreateLabel = ViewMaker.shared.makeLabel(font: .italicSystemFont(ofSize: 15), opacity: 0.5)
    private lazy var locationLabel = ViewMaker.shared.makeLabel(font: .systemFont(ofSize: 14, weight: .light))
    private lazy var countDownloadLabel = ViewMaker.shared.makeLabel(font: .systemFont(ofSize: 15))

    var viewModel: DetailsViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupUI()
    }
    
    @objc private func favoriteButtonTapped() {
        viewModel.favoriteButtonTapped()
    }
    @objc private func downLoadButtonTapped() {
        let imageData = photoImageView.image?.pngData()
        let compressedImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
        showAlert(title: "Сохранен", message: "Фотка сохранен в вашу галерею")
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    private func setup() {
        
        setupSubview()
        setupConstraints()
        setStatusForFavoriteButton()
        setupView()
        setupNavBar()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.setColor(lightColor: .white, darkColor: .black)
    }
    
    private func setupNavBar() {
        title = "Detail Screen"
    }
    
    private func setupUI() {
        viewModel.viewModelDidChange = { [weak self] viewModel in
            self?.setStatusForFavoriteButton()
        }
        photoImageView.kf.setImage(with: URL(string: viewModel.image))
        authorNameLabel.text = viewModel.userName
        authorImageView.kf.setImage(with: URL(string: viewModel.userImage))
        dateCreateLabel.text = viewModel.createDate
        locationLabel.text = viewModel.location
        countDownloadLabel.text = viewModel.numberOfDownload
        dateCreateLabel.text = viewModel.createDate
    }
    
    private func setupSubview() {
        view.addSubview(photoImageView)
        view.addSubview(dateCreateLabel)
        view.addSubview(countDownloadLabel)
        view.addSubview(authorImageView)
        view.addSubview(authorNameLabel)
        view.addSubview(locationLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            authorImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 5),
            authorImageView.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor,constant: 0),
            authorImageView.heightAnchor.constraint(equalToConstant: 40),
            authorImageView.widthAnchor.constraint(equalToConstant: 40),
            
            authorNameLabel.topAnchor.constraint(equalTo: authorImageView.topAnchor,constant: 0),
            authorNameLabel.leadingAnchor.constraint(equalTo: authorImageView.trailingAnchor,constant: 5),
            
            locationLabel.bottomAnchor.constraint(equalTo: authorImageView.bottomAnchor,constant: 0),
            locationLabel.leadingAnchor.constraint(equalTo: authorImageView.trailingAnchor,constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor,constant: 0),
            
            photoImageView.topAnchor.constraint(equalTo: authorImageView.bottomAnchor,constant: 10),
            photoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
            photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
            photoImageView.heightAnchor.constraint(equalToConstant: 250),
            
            dateCreateLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor,constant: 5),
            dateCreateLabel.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor,constant: 0),
            
            countDownloadLabel.topAnchor.constraint(equalTo: dateCreateLabel.bottomAnchor,constant: 5),
            countDownloadLabel.leadingAnchor.constraint(equalTo: dateCreateLabel.leadingAnchor,constant: 0),
        ])
    }
    
    private func setStatusForFavoriteButton() {
        let favoriteBarButtom = UIBarButtonItem(image: UIImage(named: viewModel.isFavorite ? "heartFill" : "heart")!,style: .done,target: self, action: #selector(favoriteButtonTapped))
        let downloadBarButtom = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down")!,style: .done,target: self,action: #selector(downLoadButtonTapped))
        favoriteBarButtom.tintColor = .red
        downloadBarButtom.tintColor = UIColor.setColor(lightColor: .black, darkColor: .white)
        navigationItem.rightBarButtonItems = [favoriteBarButtom, downloadBarButtom]
    }
}
