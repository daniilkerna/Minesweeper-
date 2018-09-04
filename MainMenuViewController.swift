//
//  MainMenuViewController.swift
//  Minesweeper
//
//  Created by Daniil Kernazhytski on 4/29/18.
//  Copyright © 2018 Arslan Waheed. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var bombSlider: UISlider!
    @IBOutlet weak var timeSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func startPressed(_ sender: Any) {
        let number : Int = Int(bombSlider.value)
        appDelegate.board = TilesArray(bombs: number)
        appDelegate.time = Int(timeSlider.value)
        appDelegate.bombs = number
        performSegue(withIdentifier: "showGame", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
