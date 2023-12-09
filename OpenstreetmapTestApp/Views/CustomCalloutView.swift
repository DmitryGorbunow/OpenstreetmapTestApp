//
//  CustomCalloutView.swift
//  OpenstreetmapTestApp
//
//  Created by Dmitry Gorbunow on 12/8/23.
//

import UIKit

// MARK: - Constants

private extension CGFloat {
    static let alpha = 0.9
}

final class CustomCalloutView: UIView {
    
    // MARK: - UI Components
    
    private let nameLabel: UILabel = {
        let lable = UILabel()
        lable.font = Fonts.sB
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let locationTypeAndTimeLabel: UILabel = {
        let lable = UILabel()
        lable.font = Fonts.s
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        addSubview(nameLabel)
        addSubview(locationTypeAndTimeLabel)
        backgroundColor = .white
        layer.cornerRadius = CornerRadius.l
        alpha = .alpha
        addShadow()
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Offsets.s),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Offsets.m),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Offsets.m),
            
            locationTypeAndTimeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            locationTypeAndTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Offsets.m),
            locationTypeAndTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Offsets.m),
            locationTypeAndTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Offsets.s)
        ])
    }
    
    // MARK: - Public Methods
    
    func configure(annotation: PointAnnotation) {
        nameLabel.text = annotation.name
        locationTypeAndTimeLabel.text = "\(annotation.locationType), \(annotation.time)"
    }
}
