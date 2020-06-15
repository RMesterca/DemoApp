//
//  PhotoListTableViewCell.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 15/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import UIKit
import PureLayout

class PhotoDetailTableViewCell: UITableViewCell {

    // MARK: Properties
    private var stackView: UIStackView!
    private var nameLabel: UILabel!
    private var emailLabel: UILabel!
    private var descriptionLabel: UILabel!

    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        nameLabel.text = ""
        emailLabel.text = ""
        descriptionLabel.text = ""
    }

    // configure from api model
    func configure(comment: Comment) {
        nameLabel.text = comment.name
        emailLabel.text = comment.email
        descriptionLabel.text = comment.body
    }
}

// MARK: Configure Views
extension PhotoDetailTableViewCell {

    func configureViews() {
        self.selectionStyle = .none
        self.contentView.backgroundColor = R.color.appTertiaryV1()!

        configureNameLabel()
        configureEmailLabel()
        configureDescriptionLabel()
        configureStackview()

        configureConstraints()
    }

    // Name Label
    func configureNameLabel() {
        nameLabel = UILabel(forAutoLayout: ())
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0

        nameLabel.font = R.font.robotoBold(size: 16)!
        nameLabel.textColor = R.color.appPrimary()!
    }

    // Email Label
    func configureEmailLabel() {
        emailLabel = UILabel(forAutoLayout: ())
        emailLabel.numberOfLines = 0

        emailLabel.font = R.font.robotoItalic(size: 10)!
        emailLabel.textColor = R.color.appBlack()!
    }

    // Description Label
    func configureDescriptionLabel() {
        descriptionLabel = UILabel(forAutoLayout: ())
        descriptionLabel.textAlignment = .justified
        descriptionLabel.numberOfLines = 0

        descriptionLabel.font = R.font.robotoMedium(size: 14)!
        descriptionLabel.textColor = R.color.appSecondary()!
    }

    // Stackview
    func configureStackview() {
        stackView = UIStackView(forAutoLayout: ())
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 10

        self.contentView.addSubview(stackView)

        configureStackViewConstraints()

        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(descriptionLabel)
    }
}

// MARK: Constraints
extension PhotoDetailTableViewCell {

    func configureConstraints() {
        configureStackViewConstraints()

        nameLabel.autoMatch(.width, to: .width, of: stackView)
        descriptionLabel.autoMatch(.width, to: .width, of: stackView)
    }

    func configureStackViewConstraints() {
        stackView.autoPinEdge(.top, to: .top, of: self.contentView, withOffset: 5)
        stackView.autoPinEdge(.bottom, to: .bottom, of: self.contentView, withOffset: -5)
        stackView.autoPinEdge(.trailing, to: .trailing, of: self.contentView, withOffset: -20)
        stackView.autoPinEdge(.leading, to: .leading, of: self.contentView, withOffset: 20)
    }
}
