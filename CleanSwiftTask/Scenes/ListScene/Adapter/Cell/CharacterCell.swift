//
//  CharacterCell.swift
//  CleanSwiftTask
//
//  Created by Anton Ivchenko on 06.04.2025.
//

import UIKit
import SnapKit
import Kingfisher

final class CharacterCell: UITableViewCell {
    // MARK: - Properties
    static let reuseId = "CharacterCell"
    private let avatarImageView = UIImageView()
    private let nameLabel = UILabel()
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        configureConstraints()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        debugPrint("init(coder:) has not been implemented")
    }
    // MARK: - Configure
    func configure(with model: ListCellViewModel) {
        nameLabel.text = model.name
        avatarImageView.kf.setImage(
            with: URL(string: model.imageURL),
            placeholder: UIImage(named: "placeholder")
        )   
    }
    // MARK: - Private methods
    private func configureView() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
    }
    private func configureConstraints() {
        avatarImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 40, height: 40))
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(12)
            $0.centerY.equalTo(avatarImageView.snp.centerY)
            $0.trailing.lessThanOrEqualToSuperview().offset(-8)
        }
    }
}

