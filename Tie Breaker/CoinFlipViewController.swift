//
//  CoinFlipViewController.swift
//  Tie Breaker
//
//  Created by Daniel Kwolek on 1/27/19.
//  Copyright © 2019 Daniel Kwolek. All rights reserved.
//

import UIKit

class CoinFlipViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newFlipsLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    var newFlipsValue: Int = 0
    var coinFlipper: CoinFlipper = CoinFlipper.init(flips: [])
    var heads: Int {
        return coinFlipper.heads
    }
    var tails: Int {
        return coinFlipper.tails
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        if let cflipper = NSKeyedUnarchiver.unarchiveObject(withFile: CoinFlipper.filePath) as? CoinFlipper {
            coinFlipper = cflipper
        }
        update()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func flipsValueChanged(_ sender: UIStepper) {
        newFlipsValue = Int(sender.value)
        newFlipsLabel.text = newFlipsValue.description
    }
    
    @IBAction func generateFlipsPressed(_ sender: Any) {
        var i = newFlipsValue
        coinFlipper.flip(ntimes: &i)
        update()
    }
    
    @IBAction func clearResultsPressed(_ sender: Any) {
        coinFlipper.clearFlips()
        update()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func update() {
        self.navigationItem.title = "H: \(heads.description) | T: \(tails.description)"
    tableView.reloadData()
    }

}

extension CoinFlipViewController: UITableViewDelegate {
    
}

extension CoinFlipViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinFlipper.coinFlips.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CoinFlipCell", for: indexPath) as! CoinFlipTableViewCell
        let flip: CoinFlip = coinFlipper.coinFlips.reversed()[indexPath.row]
        cell.resultLabel.text = (coinFlipper.coinFlips.count - indexPath.row).description + ": " + flip.rawValue
        return cell
    }
}

extension CoinFlipViewController {
    
}

