//
//  ViewController.swift
//  pokedex
//
//  Created by shiv on 15/06/18.
//  Copyright © 2018 shiv. All rights reserved.
//

import UIKit
import AVFoundation // music

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBarAction: UISearchBar!
    
    var pokemon = [Pokemon]()
    // filtered array for the search
    var filteredPokemon = [Pokemon]()
    
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Data source and delegates
        collection.dataSource = self
        collection.delegate = self
        searchBarAction.delegate = self
       
        
        // invoke methods here
        parsePokemonCSV()
        //initAudio()
    }
    
    func initAudio() {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        // can throw error use [do try catch]
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
        } catch let err as NSError {
            
            print(err.debugDescription)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // parse the csv data
    func parsePokemonCSV() {
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        // print("alright! alright! alright!")
        do {
            let csv = try CSV(contentsOfURL: path) // may throw an error
            let rows = csv.rows
            
            for row in rows {
                
                let pokeId = Int(row["id"]!)
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, pokedexId: pokeId!)
                pokemon.append(poke)
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // deque the cell to make it reusable
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            var poke : Pokemon!
            
            if inSearchMode == false {
                
                poke = pokemon[indexPath.row]
                cell.configureCell(pokemon: poke)
            } else {
                
                poke = filteredPokemon[indexPath.row]
                cell.configureCell(pokemon: poke)
            }
            
            return cell
        } else {
            
            // empty generic cell
            return UICollectionViewCell()
        }
    }
    
    // segue should be called when a cell is picked
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var poke: Pokemon!
        
        if inSearchMode {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }
        
        // send data through the segue
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode == true {
            return filteredPokemon.count
        } else {
            return pokemon.count;
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    @IBAction func music(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            // not to search anything
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
            
        } else {
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            // filter all the pokemons based on the search query
            filteredPokemon = pokemon.filter({ $0.name.range(of: lower) != nil })
            /* for i in filteredPokemon {
                print(i.name, terminator:" ")
            } print() */
            
            collection.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PokemonDetailVC" {
            if let detailsVC = segue.destination as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    // recieve the data that has been sent by segue
                    detailsVC.pokemon = poke
                }
            }
        }
    }
    
}

