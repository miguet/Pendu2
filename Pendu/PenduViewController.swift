//
//  PenduViewController.swift
//  Pendu
//
//  Created by Serge Miguet on 20/03/2024.
//

import UIKit

class PenduViewController: UIViewController {
    var first = 0, last = 0
    var lettresATrouver = 0
    var etape = 0 // numéro d'étape dans le dessin du gibet de potence
    var niveau = 1
    var mots = [
        "BONJOUR",
        "ORDINATEUR",
        "BANANE",
        "FORET",
        "MOTO"
    ]
    var secret = ""
    
    @IBOutlet weak var vignette: UIImageView!
    @IBOutlet weak var mot: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet var boutons: [UIButton]!
    
    func finPartie (affiche chaine : String) {
        message.text = chaine // affiche la chaine (en rouge) dans la zone des messages
        for b in boutons { // pour tout bouton b
            b.isEnabled = false // désactiver le bouton b
        }
    }
    
    @IBAction func clic(_ sender: UIButton) {
        var trouve : Bool = false
        let lettre = sender.titleLabel!.text!
        print("La lettre \(lettre) a été cliquée")
        sender.isEnabled = false // on desactive le bouton qui vient d'être cliqué
        var motCache : [Character] = []
        
        for l in mot.text! { // recopie de la chaine de caractères dans un tableau de caractères
            motCache.append(l)
        }
        var i = 0
        for l in secret {
            if i >= first && i <= last {
                if String(l) == lettre {
                    trouve = true // on a trouvé une occurence de la lettre cliquée
                    motCache[i] = l // on remplace le - par le caractère courant
                    lettresATrouver -= 1 // on décrémente le nombre de lettres à trouver
                    if lettresATrouver == 0 {
                        finPartie(affiche: "Gagné !")
                    }
                }
            }
            i += 1
        }
        if !trouve {
            etape += 1 // on incrémente le numéro d'étape
            vignette.image = UIImage(named: "pendu\(etape)")
            if etape == 11 {
                finPartie (affiche: "Perdu !")
            }
        }
        mot.text = ""
        for l in motCache {
            mot.text! += String(l)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Le niveau de jeu est \(niveau)")
        secret = mots.randomElement()!
        print("Le mot secret est \(secret)")
        switch niveau {
        case 1: first = 1; last = secret.count - 2
        case 2: first = 1; last = secret.count - 1
        case 3: first = 0; last = secret.count - 1
        default: break
        }
        lettresATrouver = last - first + 1
        print("Je vais masquer les lettres de \(first) à \(last)")
        mot.text = ""
        var i = 0
        for l in secret {
            if i >= first && i <= last {
                mot.text! += "-" // on masque la lettre
            } else {
                mot.text! += String(l)  // on recopie la lettre
            }
            i += 1
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
