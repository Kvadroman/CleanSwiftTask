//
//  DetailViewController.swift
//  CleanSwiftTask
//
//  Created by Anton Ivchenko on 05.04.2025.
//

import UIKit
import SnapKit
import Kingfisher

final class DetailViewController: UIViewController {
    // MARK: - Properties
    var characterVM: ListCellViewModel?
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        setupConstraints()
    }
    // MARK: - Private methods
    private func configureViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        if let vm = characterVM {
            title = vm.name
            titleLabel.text = vm.name
            if let url = URL(string: vm.imageURL) {
                imageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
            } else {
                imageView.image = UIImage(named: "placeholder")
            }
        }
    }
    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            $0.width.height.equalTo(200)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.top)
            $0.left.equalTo(imageView.snp.right).offset(20)
            $0.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
        }
    }
}
