//
//  FoodViewController.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/30.
//

import UIKit
import SwiftUI

final class FoodViewController: UIViewController {
    
    // MARK: Properties - Data
    private let foodManager = FoodManager()
    private var selectedDate: Date = .today
    private var imageData: Data?
    
    weak var menuPopupViewDelegate: MenuPopupViewDelegate?
    
    // MARK: Properties - View
    private lazy var foodModalView: FoodModalView = { [weak self] in
        FoodModalView(
            imagePickerCall: {
                self?.presentImagePicker()
            }
        )
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureHierarchy()
        configureNavigationBarItem()
    }
    
    func configureSelectedDate(_ selectedDate: Date) {
        
        self.selectedDate = selectedDate
    }
    
    private func configureHierarchy() {
        
        view.addSubview(foodModalView)
        
        NSLayoutConstraint.activate([
            foodModalView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            foodModalView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            foodModalView.topAnchor.constraint(equalTo: view.topAnchor),
            foodModalView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureNavigationBarItem() {
        
        let checkItem = UIBarButtonItem(image: ImageSystemName.check.image,
                                        style: .plain,
                                        target: self,
                                        action: #selector(TappedCheckButton))
        checkItem.tintColor = .designSystem(.calendarDayGray)
        let deleteItem = UIBarButtonItem(image: ImageSystemName.xmark.image,
                                         style: .plain,
                                         target: self,
                                         action: #selector(TappedCancelButton))
        deleteItem.tintColor = .designSystem(.calendarDayGray)
        navigationItem.rightBarButtonItem = checkItem
        navigationItem.leftBarButtonItem = deleteItem
    }
    
    private func presentImagePicker() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
       
        present(picker, animated: true)
    }
    
    @objc private func TappedCheckButton() {
                
        var food = foodModalView.getFoodModalData()
        food.image = imageData
        
        foodManager.addFood(food, to: self.selectedDate)
        
        dismiss(animated: true)
        
        menuPopupViewDelegate?.didDismissFoodViewController()
    }
    
    @objc private func TappedCancelButton() {
        
        print("delete 버튼 눌림")
    }
}

extension FoodViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else { return }
        foodModalView.configureImageView(image)
        
        dismiss(animated: true)
        
        let imageData = image.pngData()
        self.imageData = imageData
    }
}
