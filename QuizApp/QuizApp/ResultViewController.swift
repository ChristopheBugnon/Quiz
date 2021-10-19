//
//  ResultViewController.swift
//  QuizApp
//
//  Created by Christophe Bugnon on 19/10/2021.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var headerLabel: UILabel!

    private var summary = ""

    convenience init(summary: String) {
        self.init()

        self.summary = summary
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        headerLabel.text = summary

    }
}
