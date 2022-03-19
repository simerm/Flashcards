//
//  ViewController.swift
//  Flashcards
//
//  Created by Simerjeet on 2/26/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        questionLabel.isHidden = true;
    }
    

    func updateFlashcard(question: String, answer: String) {
        
        questionLabel.text = question
        answerLabel.text = answer
    }
    
    
}

