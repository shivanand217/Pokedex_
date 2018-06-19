//
//  PokeCell.swift
//  pokedex
//
//  Created by shiv on 15/06/18.
//  Copyright © 2018 shiv. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    // some properties to the cell
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let color = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        
        layer.borderColor = color.cgColor
        layer.cornerRadius = 9.0
    }
    
    // configure cell with our pokemon
    func configureCell(pokemon: Pokemon) {
        
        self.pokemon = pokemon
        // setting the image and label of pokemon
        nameLbl.text = self.pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    
}
