//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Roy Akash on 06/12/19.
//  Copyright © 2019 theroyakash. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var percentageTip: UISegmentedControl!
    @IBOutlet weak var personStepper: UIStepper!
    @IBOutlet weak var personAmount: UILabel!
    @IBOutlet weak var moneyPerHead: UILabel!
    @IBOutlet weak var tipValue: UILabel!
    
    var percentageSelected: Double = 10
    var billAmountDouble: Double = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        personAmount.text = "1 People"
        personStepper.value = 1.0
        moneyPerHead.text = "Zero bucks"
        tipValue.text = "Zero bucks"
    }

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        billAmount.endEditing(true)
        personStepper.minimumValue = 1
        personStepper.maximumValue = 20
        let a = personStepper.value
        personAmount.text = String(format:"%.f People", a)
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIBarButtonItem) {
        billAmount.endEditing(true)
        percentageTip.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        
        //let intOfBillAmount = Double(billAmount.text ?? "0")
        if let billAmountDouble = Double(billAmount.text ?? "0"){
            let a = (billAmountDouble * ((100 + percentageSelected) / 100)) / personStepper.value
            
            let b = (billAmountDouble * ((percentageSelected) / 100))
            
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
            moneyPerHead.text = String(format:"%.2f", a)
            tipValue.text = String(format:"%.2f", b)
        }else{
            moneyPerHead.text = "Enter Amount"
            tipValue.text = "Enter Amount"
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        }
    }
    
    @objc fileprivate func handleSegmentChange(){
        switch percentageTip.selectedSegmentIndex {
        case 0:
            percentageSelected = 5
        case 1:
            percentageSelected = 10
        case 2:
            percentageSelected = 15
        case 3:
            percentageSelected = 20
        default:
            percentageSelected = 0.0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

