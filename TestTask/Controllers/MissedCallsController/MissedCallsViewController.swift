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
    var calls: CallModel? {
        didSet {
            DispatchQueue.main.async {
                self.missedCallsTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MissedCallsViewModel(calls: calls, newCalls: { [weak self] newCals in
            guard let strongSelf = self else {return}
            strongSelf.calls = newCals
        })
        
        viewModel?.loadDataFromDevice()
        viewModel?.loadDataFromServer()
        viewModel?.missedCallsDelegate = self
    }

}

extension MissedCallsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.tapCell(index: indexPath)
    }
}

extension MissedCallsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.calls?.requests.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = missedCallsTableView.dequeueReusableCell(withIdentifier: "missedCalsCell", for: indexPath) as! MissedCallsTableViewCell
        
        let call = self.calls?.requests[indexPath.row]
        let stringDate = call?.created
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let secDateFormatter = DateFormatter()
        secDateFormatter.dateFormat = "HH:mm a"
        
        let date = dateFormatter.date(from: stringDate!)
        
        var duration = ""
        if let strongDuration = call?.duration {
            duration = viewModel?.changeDuration(duration: strongDuration) ?? ""
        }
        
        var telephone = ""
        if let strongTelephone = call?.client.address {
            
            telephone = viewModel?.changeNumber(string: strongTelephone) ?? ""
        }
        
        cell.callIconImageView.image = UIImage(named: "call inbound missed")
        cell.callDurationLabel.text = duration
        cell.contactAddressLabel.text = telephone
        cell.contactNameLabel.text = call?.client.name
        cell.dateOfCallLabel.text = secDateFormatter.string(from: date ?? Date())
        
        cell.dataView.layer.masksToBounds = true
        cell.dataView.layer.cornerRadius = 8
        
        cell.shadowView.layer.cornerRadius = 8
        cell.shadowView.layer.shadowRadius = 8
        cell.shadowView.layer.shadowColor = UIColor.black.cgColor
        cell.shadowView.layer.shadowOpacity = 0.1
        cell.shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        if cell.contactNameLabel.text == nil {
            cell.contactNameLabel.isHidden = true
            cell.contactAddressLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        }
        
        return cell
    }
}

extension MissedCallsViewController: MissedCallsDelegate {
    
    func goToInfoVC(someData: Request?) throws {
        let infoAboutViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoAboutCallViewController") as! InfoAboutCallViewController
        infoAboutViewController.call = someData
        infoAboutViewController.modalPresentationStyle = .fullScreen
        self.present(infoAboutViewController, animated: true, completion: nil)
    }
}
