//
//  StudentViewController.swift
//  Next03
//
//  Created by Valmir Junior on 10/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit
import CoreData

class StudentViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var courseTextField: UITextField!
    @IBOutlet weak var addEditButton: UIButton!
    
    
    // MARK: - Properties
    var student: Student!
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        return dp
    }()
    
    lazy var pickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.backgroundColor = .white
        pv.delegate = self
        pv.dataSource = self
        
        return pv
    }()
    
    var courses: [Course] = []
    
    // MARK: - Super Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareTextFields()
        
        if student != nil {
            self.nameTextField.text = student.name
            self.birthdayTextField.text = student.birthday?.formatted
            self.courseTextField.text = student.course?.name
            
            if let photoData = student.photo {
                self.photoImageView.image = UIImage(data: photoData)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadCourses()
    }
    
    // MARK: - Methods
    private func prepareTextFields() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        let doneButton = UIBarButtonItem(title: "Ok", style: .done, target: self, action: #selector(doneDate))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelDate))
        let flexibleButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.items = [ cancelButton, flexibleButton, doneButton ]
        
        self.birthdayTextField.inputAccessoryView = toolbar
        self.birthdayTextField.inputView = datePicker
        
        let toolbarCourses = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        let doneCoursesButton = UIBarButtonItem(title: "Ok", style: .done, target: self, action: #selector(doneCourse))
        let flexibleCoursesButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbarCourses.items = [ flexibleCoursesButton, doneCoursesButton ]
        self.courseTextField.inputView = self.pickerView
        self.courseTextField.inputAccessoryView = toolbarCourses
    }
    
    @objc private func doneDate() {
        self.birthdayTextField.text = datePicker.date.formatted
        self.cancelDate()
    }
    
    @objc private func doneCourse() {
        let selectedIndex = pickerView.selectedRow(inComponent: 0)
        self.courseTextField.text = self.courses[selectedIndex].name
        view.endEditing(true)
        
    }
    
    @objc private func cancelDate() {
        view.endEditing(true)
    }
    
    func selectPicture(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func loadCourses() {
        let fetchRequest: NSFetchRequest<Course> = Course.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \Course.name, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            self.courses = try context.fetch(fetchRequest)
            self.pickerView.reloadAllComponents()
        } catch {
            print(error)
        }
        
        if student != nil, let course = student.course, let index = courses.firstIndex(of: course) {
            pickerView.selectRow(index, inComponent: 0, animated: true)
        }
    }
    
    // MARK: - IBActions
    @IBAction func addEditButtonPressed(_ sender: Any) {
        if self.student == nil {
            self.student = Student(context: context)
        }
        
        self.student.name = self.nameTextField.text
        
        if !self.birthdayTextField.text!.isEmpty {
            student.birthday = self.datePicker.date
        }
        
        if let photoData = self.photoImageView.image?.pngData() {
            student.photo = photoData
        }
        
        student.course = self.courses[pickerView.selectedRow(inComponent: 0)]
    
        self.saveContext()
        navigationController?.popViewController(animated: true )
    }
    
    @IBAction func choosePhoto(_ sender: Any) {
        let alert = UIAlertController(title: "Foto de perfil",
                                      message: "Escolha de onde recuperar a sua foto",
                                      preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (_) in
                self.selectPicture(sourceType: .camera)
            }
            alert.addAction(cameraAction)
        }
        
        let albumAction = UIAlertAction(title: "Álbum de fotos",
                                        style: .default) { (_) in
            self.selectPicture(sourceType: .photoLibrary)
        }
        alert.addAction(albumAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: -

extension StudentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else { return }
        
        let smallSize = CGSize(width: image.size.width / 10, height: image.size.height / 10)
        
        // Image context
        UIGraphicsBeginImageContext(smallSize)
        image.draw(in: CGRect(x: 0, y: 0, width: smallSize.width, height: smallSize.height))
        let smallImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.photoImageView.image = smallImage
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIPickerViewDataSource and UIPickerViewDelegate
extension StudentViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.courses.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.courses[row].name
    }
}
