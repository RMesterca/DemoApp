//
//  PhotoTableViewCell.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 14/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import UIKit
import PureLayout
import Nuke

class PhotoTableViewCell: UITableViewCell {

    // MARK: Properties
    private var roundedBackgroundView: UIView!
    private var stackView: UIStackView!
    private var titleLabel: UILabel!
    private var thumbnailImageView: UIImageView!

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

        titleLabel.text = ""
        thumbnailImageView?.image = nil
    }

    // configure from api model
    func configure(photo: Photo) {
        titleLabel.text = photo.title
        loadImage(path: photo.thumbnailURL)
    }
}

// MARK: Configure Views
extension PhotoTableViewCell {

    func configureViews() {
        self.selectionStyle = .none
        configureThumbnailImageView()
        configureTitleLabel()
        configureStackview()

        configureConstraints()
    }

    // Thumbnail Image View
    func configureThumbnailImageView() {
        thumbnailImageView = UIImageView(forAutoLayout: ())
        thumbnailImageView.contentMode = .scaleAspectFill
    }

    // Title Label
    func configureTitleLabel() {
        titleLabel = UILabel(forAutoLayout: ())
        titleLabel.numberOfLines = 0
    }

    // Stackview
    func configureStackview() {
        stackView = UIStackView(forAutoLayout: ())
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 10

        self.contentView.addSubview(stackView)

        configureStackViewConstraints()

        stackView.addArrangedSubview(thumbnailImageView)
        stackView.addArrangedSubview(titleLabel)
    }
}

// MARK: Constraints
extension PhotoTableViewCell {

    func configureConstraints() {
        configureStackViewConstraints()
        configureThumbnailConstraints()
    }

    func configureStackViewConstraints() {
        stackView.autoPinEdge(.top, to: .top, of: self.contentView, withOffset: 5)
        stackView.autoPinEdge(.bottom, to: .bottom, of: self.contentView, withOffset: -5)
        stackView.autoPinEdge(.trailing, to: .trailing, of: self.contentView, withOffset: -20)
        stackView.autoPinEdge(.leading, to: .leading, of: self.contentView, withOffset: 20)
    }

    func configureThumbnailConstraints() {
        let dimension: CGFloat = 50
        thumbnailImageView.autoSetDimension(.height, toSize: dimension)
        thumbnailImageView.autoSetDimension(.width, toSize: dimension)

        thumbnailImageView.layer.cornerRadius = dimension / 2
        thumbnailImageView.layer.masksToBounds = true
    }
}

// MARK: Helpers
extension PhotoTableViewCell {

    func loadImage(path: String) {
        guard let placeholderImage = R.image.icons8Camera503() else { return assertionFailure() }
        guard let imageURL = URL(string: path) else { return assertionFailure() }

        let options = ImageLoadingOptions(
            placeholder: placeholderImage,
            transition: .fadeIn(duration: 0.2),
            failureImage: placeholderImage,
            failureImageTransition: .fadeIn(duration: 0.2),
            contentModes: nil)

        Nuke.loadImage(with: imageURL, options: options, into: thumbnailImageView)
    }
}
