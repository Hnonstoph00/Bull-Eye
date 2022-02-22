//
//  ViewController.swift
//  BullEye
//
//  Created by Huy Hà on 2/21/22.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet var slider: UISlider!
    @IBOutlet var targetLabel : UILabel!
    @IBOutlet var scoreLabel : UILabel!
    @IBOutlet var roundLabel : UILabel!
    
    // MARK: - Variables
    var currentValue : Int = 30
    var targetNumber = 0
    var score = 0
    var round = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        startNewGame()
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        let insets = UIEdgeInsets(
              top: 0,
              left: 14,
              bottom: 0,
              right: 14)
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(
            withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
    
    
    
    
    //MARK: - IBActions
    @IBAction func showAlert()
    {
        let diferrence = abs(currentValue - targetNumber)
        var point = 100 - diferrence
        let title: String
        if diferrence == 0 {
            title = "Perfect, you earn plus 100 points"
            point += 100
        } else if diferrence < 5 {
            title = "You almost make it so plus 50 poins"
            point += 50
        } else if diferrence < 13 {
            title = "You are doing ok"
        } else {
            title = "Not even close, try again my man"
        }
        score += point
        let message = "You score \(point) points"
        let alert = UIAlertController (
            title: title,
            message: message,
            preferredStyle: .alert)
        let action = UIAlertAction (
            title: "OK", style: .default, handler: {
                _ in self.startNewRound()
            })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    @IBAction func slideMoved (_ slider: UISlider) {
        currentValue = lroundf(slider.value)
        
    }
    @IBAction func startNewGame() {
        round = 0
        score = 0
        startNewRound()
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)
    }
    
    
    
    
    //MARK: Function
    func startNewRound()
    {
        round+=1
        targetNumber = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    func updateLabels() {
        targetLabel.text = String(targetNumber)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
}

