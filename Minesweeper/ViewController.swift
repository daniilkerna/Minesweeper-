//
//  ViewController.swift
//  Minesweeper
//
//  Created by Alberto Clara and Daniil Kerna
//  Copyright © 2018 Alberto Clara and Daniil Kerna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //labels
    @IBOutlet weak var resetButton: UIButton!       
    @IBOutlet weak var timerLabel: UILabel!         //timer
    @IBOutlet weak var totalBombsLabel: UILabel!
    
    //all buttons and switch mode button
    @IBOutlet var buttons: [UIButton]!              //all buttons
    @IBOutlet weak var switchButton: UIButton!      //switch mode button
    
    var time = 120
    //create instance of TilesArray which will automatically populate all cells
    
    
    //This is the timer object for running a function intervally
    var countdownExplosion : Timer!
    
    //Alert to pop-up in case of win or lose
    var myAlert = UIAlertController(title: "OK", message: "Press OK", preferredStyle: UIAlertControllerStyle.alert)
    
    //viewDidLoad function
    override func viewDidLoad() {
        super.viewDidLoad()
        countdownExplosion = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        resetButtons()
        time = appDelegate.time
        
        for button in buttons{
            let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap(_:)))
            button.addGestureRecognizer(longGesture)
            button.backgroundColor = UIColor.blue
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            gameOver()
        }
    }
    
    
    
    //this method is called if any cell of game is clicked
    @IBAction func buttonClicked(_ sender: UIButton) {
        let prevTitle = sender.currentTitle
        appDelegate.board?.buttonClicked(sender,buttons: self.buttons)
        if sender.currentTitle != "🏳️" && prevTitle != "🏳️" {
            let isDead = appDelegate.board?.isMineClicked(sender, buttons: buttons)
            if isDead! {
                gameOver()
            }
        }
    }
    
    func gameOver(){
        appDelegate.board?.showAllMines(buttons)
        countdownExplosion.invalidate()
        myAlert = UIAlertController(title: "You Lose!", message: "Press New Game to play again", preferredStyle: UIAlertControllerStyle.alert)
        myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(myAlert, animated: true, completion: nil)
    }
    
    
    @IBAction func resetClicked(_ sender: UIButton) {
        if (appDelegate.board!.isGameOn == false){
            resetButtons()
            return 
        }
        myAlert = UIAlertController(title: "Start New Game", message: "Are You Sure ?", preferredStyle: UIAlertControllerStyle.alert)
        myAlert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: resetHandler))
        myAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        self.present(myAlert, animated: true, completion: nil)
    }
    
    func resetHandler(alert: UIAlertAction!) {
        resetButtons()
    }
    
    @IBAction func switchButton(_ sender: UIButton) {
        appDelegate.board!.flagButtonChecked(sender)
    }
    
    @IBAction func settingsPressed(_ sender: Any) {
        myAlert = UIAlertController(title: "Change Game Settings", message: "This will abort current game, Are You Sure ?", preferredStyle: UIAlertControllerStyle.alert)
        myAlert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: viewSettings))
        myAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        self.present(myAlert, animated: true, completion: nil)
    }
    
    func viewSettings(alert: UIAlertAction!) {
        performSegue(withIdentifier: "showSettings", sender: self)
    }
    
    
    //helping functions for view controller
    //reset and timer
    
    func resetButtons(){
        appDelegate.board = TilesArray(bombs: appDelegate.bombs)
        totalBombsLabel.text = "Bombs: \(appDelegate.board!.totalBombs)"
        for i in 0 ..< buttons.count {
            buttons[i].setTitle("", for: .normal)
            buttons[i].isEnabled = true
            buttons[i].backgroundColor = UIColor.blue
        }
        time = appDelegate.time
        timerLabel.text = "Time: \(time)"
        
        countdownExplosion.invalidate()
        countdownExplosion = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        //set the flag mode off
        appDelegate.board!.isFlagSelected = false
        appDelegate.board!.isGameOn = true
    }
    
    //timer controlled function
    @objc func runTimedCode() {
        time -= 1
        timerLabel.text = "Time: \(time)"
        if appDelegate.board!.isFinished() {
            countdownExplosion.invalidate()
            appDelegate.board!.showAllMines(buttons)

            myAlert = UIAlertController(title: "Game Won!!", message: "", preferredStyle: UIAlertControllerStyle.alert)
            myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(myAlert, animated: true, completion: nil)
        }
        if(time==0){
            gameOver()
        }
    }
    
    @objc func longTap(_ sender: UIGestureRecognizer ){
        print("Long tap")
        if sender.state == .ended {
            print("UIGestureRecognizerStateEnded")
            //Do Whatever You want on End of Gesture
        }
        else if sender.state == .began {
            print("UIGestureRecognizerStateBegan.")
            //Do Whatever You want on Began of Gesture
        }
    }
}
