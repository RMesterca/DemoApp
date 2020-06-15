//
//  PhotoDetailHeaderView.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 15/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import UIKit
import Nuke

class PhotoDetailHeaderView: UITableViewHeaderFooterView {

    private var photoImageView: UIImageView!
    private var titleLabel: UILabel!

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        configureViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(with photo: Photo) {
        titleLabel.text = photo.title
        loadImage(path: photo.url)
    }
}

// MARK: Configure Views
extension PhotoDetailHeaderView {

    func configureViews() {
        configurePhotoImageView()
        configureTitleLabel()

        configureConstraints()
    }

    func configureTitleLabel() {
        titleLabel = UILabel(forAutoLayout: ())
        titleLabel.font = R.font.robotoBold(size: 20)
        titleLabel.textColor = R.color.appTertiaryV3()!
        titleLabel.backgroundColor = R.color.appTransparentBlack()!

        self.contentView.addSubview(titleLabel)
    }

    func configurePhotoImageView() {
        photoImageView = UIImageView(forAutoLayout: ())
        photoImageView.contentMode = .scaleAspectFill

        self.contentView.addSubview(photoImageView)
    }
}

// MARK: Constraints
extension PhotoDetailHeaderView {

    func configureConstraints() {
        configureTitleLabelConstraints()
        configurePhotoImageViewConstraints()
    }

    func configureTitleLabelConstraints() {
        titleLabel.autoPinEdge(.top, to: .top, of: self.contentView, withOffset: 15)
        titleLabel.autoPinEdge(.leading, to: .leading, of: self.contentView, withOffset: 15)
        titleLabel.autoPinEdge(.trailing, to: .trailing, of: self.contentView, withOffset: -15)
    }

    func configurePhotoImageViewConstraints() {
        let dimension: CGFloat = UIScreen.main.bounds.width
        photoImageView.autoSetDimension(.height, toSize: dimension)
        photoImageView.autoSetDimension(.width, toSize: dimension)

        photoImageView.autoPinEdge(.top, to: .top, of: self.contentView)
        photoImageView.autoPinEdge(.bottom, to: .bottom, of: self.contentView)
        photoImageView.autoPinEdge(.leading, to: .leading, of: self.contentView)
    }
}

// MARK: Helpers
extension PhotoDetailHeaderView {

    func loadImage(path: String) {
        guard let placeholderImage = R.image.icons8Camera503() else { return assertionFailure() }
        guard let imageURL = URL(string: path) else { return assertionFailure() }

        let options = ImageLoadingOptions(
            placeholder: placeholderImage,
            transition: .fadeIn(duration: 0.2),
            failureImage: placeholderImage,
            failureImageTransition: .fadeIn(duration: 0.2),
            contentModes: nil)

        Nuke.loadImage(with: imageURL, options: options, into: photoImageView)
    }
}
