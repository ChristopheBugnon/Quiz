//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by Christophe Bugnon on 18/10/2021.
//

import UIKit

class QuestionViewController: UIViewController {
    @IBOutlet weak var headerLabel: UILabel!
    
    private var question: String = ""

    convenience init(question: String) {
        self.init()

        self.question = question
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        headerLabel.text = question
    }
}
