//
//  Coordinator.swift
//  MMA
//
//  Created by Cesar Mejia Valero on 4/18/23.
//

import UIKit

protocol Coordinator {
    var navigation: UINavigationController { get }
    func start()
}
