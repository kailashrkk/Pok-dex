//
//  PokeDetailVC.swift
//  PokeDex by Kailash
//
//  Created by Kailash Ramaswamy Krishna Kumar on 3/22/16.
//  Copyright © 2016 Kailash Ramaswamy Krishna Kumar. All rights reserved.
//

import UIKit

class PokeDetailVC: UIViewController {

    @IBOutlet weak var pokeImg: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var weaknessLbl: UILabel!
    @IBOutlet weak var movesLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var evoImg: UIImageView!
    
    @IBOutlet weak var mainImg: UIImageView!
    var pokemon: Pokemon!
    
    override func viewDidAppear(animated: Bool) {
        name.text = pokemon.name.capitalizedString
        mainImg.image = UIImage(named: "\(pokemon.pokeDex)")
        
        pokemon.downloadPokemonDetails { 
            self.updateUI()
        }
    }
    
    func updateUI(){
        typeLbl.text = pokemon.typeLbl
        weaknessLbl.text = pokemon.weakness
        evoLbl.text = pokemon.evoLbl
        
        if pokemon.evoPokeDex == "XXX"{
        evoImg.hidden = true
        } else{
        evoImg.hidden = false
        evoImg.image = UIImage(named: "\(pokemon.evoPokeDex)")
        }
        movesLbl.text = pokemon.moves
    }
    
    @IBAction func backPressed(sender: UIButton){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
