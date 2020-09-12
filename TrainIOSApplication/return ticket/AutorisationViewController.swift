//
//  AutorisationViewController.swift
//  TrainIOSApplication
//
//  Created by Тимофей on 13.05.2020.
//  Copyright © 2020 Тимофей. All rights reserved.
//

import UIKit

class AutorisationViewController: UIViewController {
    
    let AutorisationRow: Int = 3
    let transiton = SlideInTransition()

    @IBOutlet weak var Autorisation: UIButton!
    @IBAction func pushAutorisation(_ sender: UIButton) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
      let sb = self.storyboard?.instantiateViewController(identifier: "AuthVC") as! AuthViewController
      sb.modalPresentationStyle = .fullScreen
      self.present(sb, animated: false, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        Autorisation.layer.cornerRadius = 24
    }
    
    @IBAction func pushMenu(_ sender: UIBarButtonItem) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        menuViewController.numRow = AutorisationRow
        present(menuViewController, animated: true)
    }
    
}
extension AutorisationViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}
