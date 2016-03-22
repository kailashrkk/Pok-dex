//
//  PokeDetailVC.swift
//  PokeDex by Kailash
//
//  Created by Kailash Ramaswamy Krishna Kumar on 3/22/16.
//  Copyright © 2016 Kailash Ramaswamy Krishna Kumar. All rights reserved.
//

import UIKit

class PokeDetailVC: UIViewController {

    @IBOutlet weak var name: UILabel!
    var pokemon: Pokemon!
    
    override func viewDidAppear(animated: Bool) {
        name.text = pokemon.name
    }
}
