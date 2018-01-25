//
//  ViewController.swift
//  Quiz
//
//  Created by Kukuh Yoniatmoko on 18/01/18.
//  Copyright © 2018 Kukuh Yoniatmoko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    private var currentQuestionLabelConstraint: QuestionLabelConstraint!
    private var nextQuestionLabelConstraint: QuestionLabelConstraint!
    
    private let questions = [
        "What is 7+7?",
        "What is the capital of Vermont?",
        "What is cognac made from?"
    ]

    private let answers = [
        "14",
        "Montpelier",
        "Grapes"
    ]
    private var currentQuestionIndex = 0

    @IBAction func showNextQuestion(_ sender: UIButton) {
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        let question = questions[currentQuestionIndex]
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        animateLabelTransitions()
    }

    @IBAction func showAnswer(_ sender: UIButton) {
        let answer = answers[currentQuestionIndex]
        answerLabel.text = answer
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestionLabel.text = questions[currentQuestionIndex]
        
        let space = UILayoutGuide()
        view.addLayoutGuide(space)
        space.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2, constant: 0).isActive = true
        space.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        currentQuestionLabelConstraint = QuestionLabelConstraint(label: currentQuestionLabel, guide: space)
        nextQuestionLabelConstraint = QuestionLabelConstraint(label: nextQuestionLabel, guide: space)
        
        currentQuestionLabelConstraint.centerX()
        nextQuestionLabelConstraint.lead()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nextQuestionLabel.alpha = 0
        currentQuestionLabelConstraint.centerX()
        nextQuestionLabelConstraint.lead()
    }
    
    private func animateLabelTransitions() {
        view.layoutIfNeeded()
        currentQuestionLabelConstraint.trail()
        nextQuestionLabelConstraint.centerX()
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
            options: [.curveEaseIn],
            animations: {
                self.currentQuestionLabel.alpha = 0
                self.nextQuestionLabel.alpha = 1
                self.view.layoutIfNeeded()
            },
            completion: { _ in
                swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
                swap(&self.currentQuestionLabelConstraint, &self.nextQuestionLabelConstraint)
                self.nextQuestionLabelConstraint.lead()
            }
        )
    }
    
    private class QuestionLabelConstraint {
        private let leading: NSLayoutConstraint
        private let trailing: NSLayoutConstraint
        private let center: NSLayoutConstraint
        
        private let constraints: [NSLayoutConstraint]
        
        init(label: UILabel, guide: UILayoutGuide) {
            leading = label.centerXAnchor.constraint(equalTo: guide.leadingAnchor)
            trailing = label.centerXAnchor.constraint(equalTo: guide.trailingAnchor)
            center = label.centerXAnchor.constraint(equalTo: guide.centerXAnchor)
            constraints = [leading, trailing, center]
        }
        
        private func activate(target: NSLayoutConstraint) {
            for constraint in constraints {
                constraint.isActive = constraint == target
            }
        }
        
        func lead() {
            activate(target: leading)
        }
        
        func trail() {
            activate(target: trailing)
        }
        
        func centerX() {
            activate(target: center)
        }
    }
}
