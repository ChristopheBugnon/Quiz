//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by Christophe Bugnon on 18/10/2021.
//

import UIKit

class QuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    private var question = ""
    private var options = [String]()
    private var selection: ((String) ->  Void)?
    private let reuseIdentifier = "Cell"

    convenience init(question: String, options: [String], selection: @escaping (String) -> Void) {
        self.init()

        self.question = question
        self.options = options
        self.selection = selection
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        headerLabel.text = question
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection?(options[indexPath.row])
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueCell(in: tableView)
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }

    // MARK: - Helpers

    private func dequeueCell(in tableView: UITableView) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) {
            return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
    }
}
