//
//  LanguageViewController.swift
//  TrainIOSApplication
//
//  Created by Тимофей on 19.05.2020.
//  Copyright © 2020 Тимофей. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    let name: [String] = ["Русский","Український","English"]
    @IBOutlet weak var tableView: UITableView!
    
    let LanguageRow: Int = 4
    let transiton = SlideInTransition()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
        
    @IBAction func pushMenu(_ sender: UIBarButtonItem) {
            guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
            menuViewController.modalPresentationStyle = .overCurrentContext
            menuViewController.transitioningDelegate = self
            menuViewController.numRow = LanguageRow
            present(menuViewController, animated: true)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return 3
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageViewController", for: indexPath)
        cell.textLabel?.text = name[indexPath.row]
        return cell
      }
}
extension LanguageViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            transiton.isPresenting = true
            return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            transiton.isPresenting = false
            return transiton
    }
}
