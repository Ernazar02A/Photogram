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
    private lazy var deviderView: UIView = {
        let view = UIView()
        view.backgroundColor = .label
        view.layer.opacity = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var authorNameLabel = makeLabel(font: .systemFont(ofSize: 16, weight: .medium))
    private lazy var dateCreateLabel = makeLabel(font: .italicSystemFont(ofSize: 15), opacity: 0.5)
    private lazy var locationLabel = makeLabel(font: .systemFont(ofSize: 14, weight: .light))
    private lazy var countDownloadLabel = makeLabel(font: .systemFont(ofSize: 15))
    private let headerTitleCollectionLabel: UILabel = {
        let view = UILabel()
        view.text = "Другие фотки автора"
        view.font = .systemFont(ofSize: 20, weight: .medium)
        view.textColor = .label
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.register(AuthorPhotosCollectionViewCell.self,forCellWithReuseIdentifier: AuthorPhotosCollectionViewCell.identifier)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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
        setupNavigationBar()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.setColor(lightColor: .white, darkColor: .black)
    }
    
    private func setupNavigationBar() {
        title = "Detail Screen"
    }
    
    private func setupUI() {
        viewModel.viewModelDidChange = { [weak self] viewModel in
            self?.setStatusForFavoriteButton()
        }
        viewModel.getUserPhotos { [weak self] in
            DispatchQueue.main.async {
                self?.imageCollectionView.reloadData()
            }
        }
        DispatchQueue.main.async { [weak self] in
            self?.authorNameLabel.text = self?.viewModel.userName
            self?.photoImageView.kf.setImage(with: URL(string: self?.viewModel.image ?? ""))
            self?.photoImageView.kf.setImage(
                with: URL(string: self?.viewModel.image ?? ""),
                placeholder: UIImage.init(blurHash: self?.viewModel.blurHash ?? "", size: CGSize(width: self?.viewModel.width ?? 0, height: self?.viewModel.height ?? 0))
            )
            self?.authorImageView.kf.setImage(with: URL(string: self?.viewModel.userImage ?? ""))
            self?.dateCreateLabel.text = self?.viewModel.createDate
            self?.locationLabel.text = self?.viewModel.location
            self?.countDownloadLabel.text = self?.viewModel.numberOfDownload
            self?.dateCreateLabel.text = self?.viewModel.createDate
        }
    }
    
    private func setupSubview() {
        view.addSubview(photoImageView)
        view.addSubview(dateCreateLabel)
        view.addSubview(countDownloadLabel)
        view.addSubview(authorImageView)
        view.addSubview(authorNameLabel)
        view.addSubview(locationLabel)
        view.addSubview(imageCollectionView)
        view.addSubview(headerTitleCollectionLabel)
        view.addSubview(deviderView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            authorImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 5),
            authorImageView.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor,constant: 0),
            authorImageView.heightAnchor.constraint(equalToConstant: 40),
            authorImageView.widthAnchor.constraint(equalToConstant: 40),
            
            authorNameLabel.bottomAnchor.constraint(equalTo: locationLabel.topAnchor,constant: 3),
            authorNameLabel.leadingAnchor.constraint(equalTo: authorImageView.trailingAnchor,constant: 5),
            
            locationLabel.bottomAnchor.constraint(equalTo: authorImageView.bottomAnchor,constant: 0),
            locationLabel.leadingAnchor.constraint(equalTo: authorImageView.trailingAnchor,constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor,constant: 0),
            
            photoImageView.topAnchor.constraint(equalTo: authorImageView.bottomAnchor,constant: 10),
            photoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
            photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
            photoImageView.heightAnchor.constraint(equalToConstant: 250 * view.bounds.height / 852),
            
            dateCreateLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor,constant: 5),
            dateCreateLabel.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor,constant: 0),
            
            countDownloadLabel.topAnchor.constraint(equalTo: dateCreateLabel.bottomAnchor,constant: 5),
            countDownloadLabel.leadingAnchor.constraint(equalTo: dateCreateLabel.leadingAnchor,constant: 0),
            
            deviderView.topAnchor.constraint(equalTo: countDownloadLabel.bottomAnchor,constant: 5),
            deviderView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0),
            deviderView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0),
            deviderView.heightAnchor.constraint(equalToConstant: 1),
            
            headerTitleCollectionLabel.topAnchor.constraint(equalTo: deviderView.bottomAnchor,constant: 5),
            headerTitleCollectionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            
            imageCollectionView.topAnchor.constraint(equalTo: headerTitleCollectionLabel.bottomAnchor,constant: -10),
            imageCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0),
            imageCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0),
            imageCollectionView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func setStatusForFavoriteButton() {
        let favoriteBarButtom = UIBarButtonItem(image: UIImage(named: viewModel.isFavorite ? "heartFill" : "heart")!,style: .done,target: self, action: #selector(favoriteButtonTapped))
        let downloadBarButtom = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down")!,style: .done,target: self,action: #selector(downLoadButtonTapped))
        favoriteBarButtom.tintColor = .red
        downloadBarButtom.tintColor = .label
        navigationItem.rightBarButtonItems = [favoriteBarButtom, downloadBarButtom]
    }
    
    func makeLabel(text: String = "", font: UIFont = .systemFont(ofSize: 16, weight: .regular), numberOfLines: Int = 0, alignment: NSTextAlignment = .left, opacity: Float = 1.0) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = .label
        label.layer.opacity = opacity
        label.numberOfLines = numberOfLines
        label.textAlignment = alignment
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

//MARK: - UICollectionViewDataSource
extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.countData
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AuthorPhotosCollectionViewCell.identifier, for: indexPath
        ) as? AuthorPhotosCollectionViewCell else {return UICollectionViewCell()}
        cell.configure(model: viewModel.getDataCell(at: indexPath))
        return cell
    }
}
//MARK: - UICollectionViewDelegate
extension DetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.getdidSelectItem(at: indexPath) {[weak self] in
            self?.setupUI()
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: view.bounds.width / 2 - 20, height: 200 * view.bounds.height / 852)
    }
    
    func collectionView(
        _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(
        _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        15
    }
    
    func collectionView(
        _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        10
    }
}

