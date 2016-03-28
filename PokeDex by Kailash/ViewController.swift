//
//  ViewController.swift
//  PokeDex by Kailash
//
//  Created by Kailash Ramaswamy Krishna Kumar on 3/22/16.
//  Copyright © 2016 Kailash Ramaswamy Krishna Kumar. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collection: UICollectionView!
    
    var pokemons = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var isSearchOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        
        parseCSV()
        prepareAndPlayAudio()
    }
    
    func parseCSV(){
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")
        
        do {
        let csv = try CSV(contentsOfURL: path!)
        let rows = csv.rows
            
            for row in rows{
                let pokeID = Int(row["id"]!)!
                let pokeName = row["identifier"]
             let po =   Pokemon(name: pokeName!, pokedexID: pokeID)
                pokemons.append(po)
            }
            
         //   print(rows)
        } catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    func prepareAndPlayAudio(){
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")
        let url = NSURL(fileURLWithPath: path!)
        
        do{
            musicPlayer = try AVAudioPlayer(contentsOfURL: url)
            musicPlayer.volume = 0.5
            
            musicPlayer.play()
            
        } catch let err as NSError{
            print(err.debugDescription)
        }
        
    }
    

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell{
                cell.layer.cornerRadius = 5.0
                cell.clipsToBounds = true
            let poke: Pokemon!
            
            if isSearchOn {
                poke = filteredPokemon[indexPath.row]
                
            } else {
            
             poke = pokemons[indexPath.row]
                
            }
            
            cell.configureCell(poke)
                return cell
        
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let poker: Pokemon!
        if isSearchOn{
            poker = filteredPokemon[indexPath.row]
        } else {
            poker = pokemons[indexPath.row]
        }
        
        performSegueWithIdentifier("PokeDetailVC", sender: poker)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isSearchOn {
            return filteredPokemon.count
        }
        
        return pokemons.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(80, 80)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func musicButtonPressed(sender: UIButton) {
        if musicPlayer.playing {
            sender.alpha = 0.2
            musicPlayer.stop()
        } else {
            sender.alpha = 1.0
            musicPlayer.play()
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" || searchBar.text == nil {
            isSearchOn = false
            collection.reloadData()
        } else {
            
            let lower = searchBar.text!.lowercaseString
            filteredPokemon = pokemons.filter({$0.name.rangeOfString(lower) != nil})
            isSearchOn = true
            collection.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "PokeDetailVC"{
            if let destination = segue.destinationViewController as? PokeDetailVC {
                if let poke = sender as? Pokemon{
                    destination.pokemon = poke
                }
            }
        }
    }
}

