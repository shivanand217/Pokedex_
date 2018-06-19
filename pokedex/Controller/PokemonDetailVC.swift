//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by apple on 17/06/18.
//  Copyright © 2018 shiv. All rights reserved.

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenceLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var nextEvoLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var baseExp: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemon.downloadPokemonDetail {
            //  this will be called only after the network call will be completed and we have the data
            self.updateUI()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateUI() {
        
        print("nothing!!!..")
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
