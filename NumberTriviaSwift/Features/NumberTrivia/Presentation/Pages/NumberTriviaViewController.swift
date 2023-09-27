//
//  NumberTriviaViewController.swift
//  NumberTriviaSwift
//
//  Created by Rotem Nevgauker on 25/09/2023.
//

import UIKit

class NumberTriviaViewController: UIViewController {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var numberTextView: UITextView!
    @IBOutlet weak var numberTextInput: UITextField!

    var number:NumberTrivia? {
        didSet {
            updateUI()
        }
    }
    
    
    @IBAction func fetchConcreteNumber(_ sender: Any) {
        Task { @MainActor in
            view.endEditing(true)
            guard let value = numberTextInput.text else { return }
            let result  = InputConverter.stringToUnsignedInteger(numStr: value)
            switch result {
            case .left(let failure ):
                print("Error: \(failure)")
                //Error display
                break
            case .right(let num):
                APICaller.shared.fetchNumberTrivia(num: num){
                    retsultFromServer in
                    switch retsultFromServer {
                    case .left(let failure):
                        print("Error: \(failure)")
                        //Error display
                    case .right(let numberTrivia):
                        self.number = numberTrivia
                    }
                }
                break
            }
        }
    }
    
    @IBAction func fetchRaenndomNumber(_ sender: Any) {
        view.endEditing(true)
        APICaller.shared.fetchNumberTrivia(num: nil){
            retsultFromServer in
            switch retsultFromServer {
            case .left(let failure):
                print("Error: \(failure)")
                //Error display
            case .right(let numberTrivia):
                self.number = numberTrivia
            }
        }
    }
    
    func updateUI(){
        guard let num = number else{ return }
        DispatchQueue.main.async {
            self.numberLabel.text = String(num.number)
            self.numberTextView.text =  num.text
        }
      
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        numberLabel.text = ""
        numberTextView.text = "Enter a number and click search or just click get random number"
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        numberTextInput.textInputView.becomeFirstResponder()

    }
}
