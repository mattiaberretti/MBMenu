//
//  SegueMenu.swift
//  EquipeGiordani
//
//  Created by Mattia on 30/06/18.
//  Copyright © 2018 Mattia. All rights reserved.
//

import UIKit

class SegueMenu: UIStoryboardSegue {
    override func perform() {
        let inizio = self.source
        let fine = self.destination
        
        let navigation = (inizio as? UINavigationController) ?? inizio.navigationController!
        navigation.pushViewController(fine, animated: false)
    }
}
