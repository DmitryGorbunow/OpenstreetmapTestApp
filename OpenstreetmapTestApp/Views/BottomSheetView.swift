//
//  BottomSheetUIView.swift
//  OpenstreetmapTestApp
//
//  Created by Dmitry Gorbunow on 12/8/23.
//

import UIKit

final class BottomSheetView: UIView {
    
    // MARK: - UI Components
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let lable = UILabel()
        lable.font = Fonts.mB
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let gpsLabel: UILabel = {
        let lable = UILabel()
        lable.font = Fonts.m
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let dateLabel: UILabel = {
        let lable = UILabel()
        lable.font = Fonts.m
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let timeLabel: UILabel = {
        let lable = UILabel()
        lable.font = Fonts.m
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let userInformationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var viewHistoryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .customBlue
        button.layer.cornerRadius = CornerRadius.l
        button.setTitle("Посмотреть историю", for: .normal)
        button.titleLabel?.font = Fonts.m
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupAvatarImageView()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(userInformationStackView)
        addSubview(viewHistoryButton)
        userInformationStackView.addArrangedSubview(gpsLabel)
        userInformationStackView.addArrangedSubview(dateLabel)
        userInformationStackView.addArrangedSubview(timeLabel)
        setupViewsAttributes()
        setupConstraints()
    }
    
    private func setupViewsAttributes() {
        self.backgroundColor = .white
        self.addShadow()
    }
    
    private func setupAvatarImageView() {
        avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width / Sizes.divider
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.borderWidth = BorderWidth.s
        avatarImageView.layer.borderColor = UIColor.customBlue.cgColor
    }
    
    private func setAttributedTextWithImage(text: String, imageSystemName: String = "") -> NSAttributedString {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: imageSystemName)?.withTintColor(.customBlue)
        let imageString = NSAttributedString(attachment: imageAttachment)
        let labelText = NSMutableAttributedString()
        labelText.append(imageString)
        labelText.append(NSAttributedString(string: " \(text)"))
        return labelText
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: Offsets.xl),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Offsets.xl),
            avatarImageView.heightAnchor.constraint(equalToConstant: Offsets.xxl),
            avatarImageView.widthAnchor.constraint(equalToConstant: Offsets.xxl),
            
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Offsets.l),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Offsets.xl),
            
            userInformationStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Offsets.s),
            userInformationStackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Offsets.l),
            userInformationStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Offsets.xl),
            
            viewHistoryButton.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Offsets.l),
            viewHistoryButton.topAnchor.constraint(equalTo: userInformationStackView.bottomAnchor, constant: Offsets.l),
            viewHistoryButton.heightAnchor.constraint(equalToConstant: Sizes.l),
            viewHistoryButton.widthAnchor.constraint(equalTo: userInformationStackView.widthAnchor, multiplier: Sizes.multiplier)
        ])
    }
    
    // MARK: - Public Methods
    
    func configure(annotation: PointAnnotation) {
        avatarImageView.image = UIImage(named: annotation.image)
        nameLabel.text = annotation.name
        gpsLabel.attributedText = setAttributedTextWithImage(text: annotation.locationType, imageSystemName: "wifi")
        dateLabel.attributedText = setAttributedTextWithImage(text: annotation.date, imageSystemName: "calendar")
        timeLabel.attributedText = setAttributedTextWithImage(text: annotation.time, imageSystemName: "clock")
    }
}

