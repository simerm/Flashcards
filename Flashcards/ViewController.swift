//
//  ViewController.swift
//  Flashcards
//
//  Created by Simerjeet on 2/26/22.
//

import UIKit

class ViewController: UIViewController {
    
    struct Flashcard{
        var question: String
        var answer: String
    }

    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var card: UIView!
    
    var flashcards = [Flashcard]()
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        readSavedFlashcards()
        
        if (flashcards.count == 0){
            updateFlashcard(question: "What is the capital of the USA?", answer: "Washington D.C.")
        }
        else{
            updateLabels()
            updateNextPrevButtons()
        }
        
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
//        
//        let navigationController = segue.destination as! UINavigationController
//        let creationController = navigationController.topViewController as! CreationViewController
//        creationController.flashcardsController = self
//    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        flipFlashcard()
    }

    func flipFlashcard(){
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            self.questionLabel.isHidden = true
        })


        if (questionLabel.isHidden == true){
            questionLabel.isHidden = false
        }
        else{
            questionLabel.isHidden = true;
        }
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        updateLabels()
        updateNextPrevButtons()
        
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        updateLabels()
        updateNextPrevButtons()
    }
    
    func updateNextPrevButtons() {
        if currentIndex == flashcards.count - 1{
            nextButton.isEnabled = false
        }
        else{
            nextButton.isEnabled = true
        }
        
        if currentIndex == 0{
            previousButton.isEnabled = false
        }
        else{
            previousButton.isEnabled = true
        }
    }
    
    func updateLabels() {
        let currentFlashcard = flashcards[currentIndex]
        
        questionLabel.text = currentFlashcard.question
        answerLabel.text = currentFlashcard.answer
        
    }
    
    func saveAllFlashcardsToDisk(){
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
        }
        
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("Flashcards saved to UserDefaults")
        
    }
    

    func updateFlashcard(question: String, answer: String) {
        let flashcard = Flashcard(question: question, answer: answer)
        questionLabel.text = question
        answerLabel.text = answer
        flashcards.append(flashcard)
        print("Added new flashcard")
        print("We now have \(flashcards.count) flashcards")
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    
    
    
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    func animateCardOut(){
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        }, completion: { finished in
            self.animateCardIn()
        })

        self.updateLabels()

        self.animateCardIn()
    }

    func animateCardIn(){

        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)

        UIView.animate(withDuration: 0.3) {
            self.card.transform = CGAffineTransform.identity
        }
    }

}

