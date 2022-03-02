//
//  ReportError.swift
//  Movies
//
//  Created by Gwinyai Nyatsoka on 28/2/2022.
//

import Foundation

import UIKit

class ReportError {
    
    static let shared = ReportError()
    
    private init() {
    }
    
    func getAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        return alert
    }
    
}
