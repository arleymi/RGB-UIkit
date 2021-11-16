//
//  MainViewController.swift
//  RGB
//
//  Created by Arthur Lee on 19.07.2021.
//

import UIKit

class MainViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let colorVC = segue.destination as! ColorViewController
        colorVC.colorFromMainVC = view.backgroundColor
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        let colorVC = segue.source as! ColorViewController
        colorVC.delegate = self
        colorVC.setColor()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainViewController: ColorDelegate {
    func setColor(_ color: UIColor) {
        view.backgroundColor = color
    }
        
}
