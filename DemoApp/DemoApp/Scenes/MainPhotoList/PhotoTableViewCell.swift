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
    private var stackView: UIStackView!
    private var label: UILabel!
    private (set) var thumbnailImageView: UIImageView!

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

        label.text = ""
        thumbnailImageView?.image = nil
    }
}

// MARK: Configure
extension PhotoTableViewCell {

    func configureViews() {

        // stackview
        stackView = UIStackView(forAutoLayout: ())
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 10

        self.contentView.addSubview(stackView)

        stackView.autoPinEdge(.top, to: .top, of: self.contentView)
        stackView.autoPinEdge(.bottom, to: .bottom, of: self.contentView)

        stackView.autoConstrainAttribute(.trailing, to: .trailing, of: contentView, withOffset: 10)
        stackView.autoConstrainAttribute(.leading, to: .leading, of: contentView, withOffset: 10)

        // imageView
        thumbnailImageView = UIImageView(forAutoLayout: ())
        thumbnailImageView.contentMode = .scaleAspectFit

        // label
        label = UILabel(forAutoLayout: ())
        label.numberOfLines = 0
        label.sizeToFit()

        stackView.addArrangedSubview(thumbnailImageView)
        stackView.addArrangedSubview(label)
//        self.addSubview(label)



    }

    func configure(photo: Photo) {
        label.text = photo.title
        loadImage(path: photo.thumbnailURL)
    }
}

// MARK: Helpers
extension PhotoTableViewCell {

//    func loadImage(path: String, cell: PhotoTableViewCell) {
    func loadImage(path: String) {


        guard let placeholderImage = R.image.icons8Camera503() else { return assertionFailure() }
//        guard let imageView = cell.thumbnailImageView else { return assertionFailure() }
        guard let imageURL = URL(string: path) else { return assertionFailure() }

        let options = ImageLoadingOptions(
            placeholder: placeholderImage,
            transition: .fadeIn(duration: 0.2),
            failureImage: placeholderImage,
            failureImageTransition: .fadeIn(duration: 0.2),
            contentModes: nil)
        Nuke.loadImage(with: imageURL, options: options, into: thumbnailImageView)


//        Nuke.loadImage(with: imageURL, options: options, into: imageView)
    }
}
