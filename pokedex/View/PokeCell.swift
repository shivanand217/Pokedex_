//
//  PokeCell.swift
//  pokedex
//
//  Created by apple on 15/06/18.
//  Copyright © 2018 shiv. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    // change shape of cell
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let color = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        
        layer.borderColor = color.cgColor
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon: Pokemon) {
        
        self.pokemon = pokemon
        nameLbl.text = self.pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    
}
