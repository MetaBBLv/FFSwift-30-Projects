//
//  DetailsViewController.swift
//  FFTodo
//
//  Created by zhou on 2019/6/26.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var childButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var shoppingCartButton: UIButton!
    @IBOutlet weak var travelButton: UIButton!
    @IBOutlet weak var todoTitleTextField: UITextField!
    @IBOutlet weak var todoDatePicker: UIDatePicker!
    
    var todo: ToDoItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let todo = todo {
            self.title = "Edit Todo"
            if todo.image == "child-selected" {
                childButton.isSelected = true
            }
            else if todo.image == "phone-selected" {
                phoneButton.isSelected = true
            }
            else if todo.image == "shopping-cart-selected" {
                shoppingCartButton.isSelected = true
            }
            else if todo.image == "travel-selected" {
                travelButton.isSelected = true
            }
            
            todoTitleTextField.text = todo.title
            todoDatePicker.setDate(todo.date, animated: false)
        } else {
            title = "New Todo"
            childButton.isSelected = false
        }
    }
    
    
    // MARK: ButtonSelected
    @IBAction func selectChild(_ sender: UIButton) {
        resetButtons()
        childButton.isSelected = true
    }
    
    @IBAction func selectPhone(_ sender: UIButton) {
        resetButtons()
        phoneButton.isSelected = true
    }
    
    @IBAction func selectShoppingCart(_ sender: UIButton) {
        resetButtons()
        shoppingCartButton.isSelected = true
    }
    
    @IBAction func selectTravel(_ sender: UIButton) {
        resetButtons()
        travelButton.isSelected = true
    }
    
    func resetButtons() {
        childButton.isSelected = false
        phoneButton.isSelected = false
        shoppingCartButton.isSelected = false
        travelButton.isSelected = false
    }
    
    @IBAction func tapDone(_ sender: UIButton) {
        var image = ""
        if childButton.isSelected {
            image = "child-selected"
        }
        else if phoneButton.isSelected {
            image = "phone-selected"
        }
        else if shoppingCartButton.isSelected {
            image = "shopping-cart-selected"
        }
        else if travelButton.isSelected {
            image = "travel-selected"
        }
        
        if let todo = todo {
            todo.image = image
            todo.title = todoTitleTextField.text!
            todo.date = todoDatePicker.date
        } else {
            let uuid = UUID().uuidString
            todo = ToDoItem(id: uuid, image: image, title: todoTitleTextField.text!, date: todoDatePicker.date)
            todos.append(todo!)
        }
        
        let _ = navigationController?.popToRootViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
