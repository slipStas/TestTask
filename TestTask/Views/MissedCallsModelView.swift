//
//  MissedCallsModelView.swift
//  TestTask
//
//  Created by Stanislav Slipchenko on 15.01.2021.
//

import UIKit

class MissedCallsModelView: UIView {
    
    let mainView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let missedCallsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        missedCallsLabel.font = .systemFont(ofSize: 17, weight: .bold)
        missedCallsLabel.textAlignment = .center
    }
    
    func setupViews() {
        self.addSubview(mainView)
        mainView.addSubview(missedCallsLabel)
        
        missedCallsLabel.text = "Missed calls"
        
        mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        mainView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        mainView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        missedCallsLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        missedCallsLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
    }
}
