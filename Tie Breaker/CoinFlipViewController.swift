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
    
    var newFlipsValue: UInt32 = 0
    var flips: [CoinFlip] = []
    var heads: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.navigationItem.title = "H: 0 | T: 0"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func flipsValueChanged(_ sender: UIStepper) {
        newFlipsValue = UInt32(sender.value)
        newFlipsLabel.text = newFlipsValue.description
    }
    
    @IBAction func generateFlipsPressed(_ sender: Any) {
        var i = newFlipsValue
        while i > 0 {
            let flip = generateCoinFlip()
            if flip == .heads {
                heads = heads + 1
            }
            flips.append(flip)
            i = i - 1
        }
        update()
    }
    
    @IBAction func clearResultsPressed(_ sender: Any) {
        flips = []
        heads = 0
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
        self.navigationItem.title = "H: \(heads.description) | T: \((flips.count - heads).description)"
    tableView.reloadData()
    }

}

extension CoinFlipViewController: UITableViewDelegate {
    
}

extension CoinFlipViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flips.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CoinFlipCell", for: indexPath) as! CoinFlipTableViewCell
        let flip: CoinFlip = flips.reversed()[indexPath.row]
        cell.resultLabel.text = (flips.count - indexPath.row).description + ": " + flip.rawValue
        return cell
    }
}

