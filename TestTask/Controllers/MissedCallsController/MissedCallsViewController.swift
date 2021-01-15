//
//  MissedCallsViewController.swift
//  TestTask
//
//  Created by Stanislav Slipchenko on 15.01.2021.
//

import UIKit

class MissedCallsViewController: UIViewController {

    @IBOutlet weak var missedCallsTableView: UITableView! {
        didSet {
            missedCallsTableView.dataSource = self
            missedCallsTableView.delegate = self
        }
    }
    
    var viewModel: (MissedCallsViewModelInputs & MissedCallsViewModelOutputs)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MissedCallsViewModel(someData: "www")
        
        viewModel?.missedCallsDelegate = self
    }

}

extension MissedCallsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.tapCell()
    }
}

extension MissedCallsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = missedCallsTableView.dequeueReusableCell(withIdentifier: "missedCalsCell", for: indexPath) as! MissedCallsTableViewCell
        
        cell.callIconImageView.image = UIImage(named: "call inbound missed")
        cell.callDurationLabel.text = "00:14"
        cell.contactAddressLabel.text = "+1 800 123-4567"
        cell.contactNameLabel.text = "Name of contact"
        cell.dateOfCallLabel.text = "10:21 AM"
        
        cell.dataView.layer.masksToBounds = true
        cell.dataView.layer.cornerRadius = 8
        
        cell.shadowView.layer.cornerRadius = 8
        cell.shadowView.layer.shadowRadius = 8
        cell.shadowView.layer.shadowColor = UIColor.black.cgColor
        cell.shadowView.layer.shadowOpacity = 0.1
        cell.shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        if cell.contactNameLabel.text?.count == 0 {
            cell.contactNameLabel.isHidden = true
        }
        
        return cell
    }
}

extension MissedCallsViewController: MissedCallsDelegate {
    
    func goToInfoVC(someData: CallModel?) throws {
        let infoAboutViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoAboutCallViewController") as! InfoAboutCallViewController
        infoAboutViewController.calls = someData
        infoAboutViewController.modalPresentationStyle = .fullScreen
        self.present(infoAboutViewController, animated: true, completion: nil)
    }
}
