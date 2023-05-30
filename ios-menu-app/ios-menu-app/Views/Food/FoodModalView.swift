//
//  FoodModalView.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/30.
//

import UIKit

final class FoodModalView: UIView {

    // MARK: Properties - Data
    var imagePickerCall: (() -> Void)?
    
    // MARK: Properties - View
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageSystemName.multiPhoto.image
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.tintColor = .designSystem(.mainOrange)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: FoodCategory.allCases.map { $0.title })
        segmentedControl.addTarget(self, action: #selector(selectFoodCategory(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    private lazy var categoryStackView: UIStackView = {
        let label = PretendardLabel(size: 17,
                                    weight: .semibold,
                                    color: .designSystem(.mainBlack),
                                    textAlignment: .left)
        label.text = "카테고리"
        
        let stackView = UIStackView(arrangedSubviews: [label, segmentedControl])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var foodListStackView: UIStackView = {
        let menuTextField = FoodListTextField(type: .menu)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.addArrangedSubviews([menuTextField, categoryStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(imagePickerCall: @escaping (() -> Void)) {
        
        self.imagePickerCall = imagePickerCall
        super.init(frame: .zero)
    
        configure()
        selectFoodCategory(segmentedControl)
        setupTouchToImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureHierarchy()
    }
    
    // MARK: Functions - Public
    func configureImageView(_ image: UIImage?) {
        
        imageView.image = image
    }
    
    // MARK: Functions - Private
    private func setupTouchToImageView() {
        
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(tappedImageView))
        imageView.addGestureRecognizer(tapGuesture)
        imageView.isUserInteractionEnabled = true
    }
    
    private func configure() {
        
        translatesAutoresizingMaskIntoConstraints = false
        self.segmentedControl.selectedSegmentIndex = 0
    }
    
    private func configureHierarchy() {
        
        addSubview(imageView)
        addSubview(foodListStackView)
        
        let foodModalViewWidth = self.frame.width
        let imageViewWidth = foodModalViewWidth * 0.75
        let imageViewHeight = imageViewWidth * 0.82
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: imageViewWidth),
            imageView.heightAnchor.constraint(equalToConstant: imageViewHeight),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 80),
            
            foodListStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            foodListStackView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            foodListStackView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
        ])
    }
    
    @objc private func selectFoodCategory(_ segment: UISegmentedControl) {
        
        print("segmented control value: \(segment.selectedSegmentIndex)")
    }
    
    @objc private func tappedImageView() {
        
        print("tappedImageView")
        imagePickerCall?()
    }
}
