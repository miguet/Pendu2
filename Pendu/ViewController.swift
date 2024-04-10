//
//  ViewController.swift
//  Pendu
//
//  Created by Serge Miguet on 20/03/2024.
//

import UIKit
// un commentaire
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let b = sender as! UIButton
        let d = segue.destination as! PenduViewController
        d.niveau = b.tag
    }

}

