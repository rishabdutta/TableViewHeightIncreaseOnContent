//
//  MyTableViewCell.swift
//  TableViewHeightIncreaseOnContent
//
//  Created by Rishab Dutta on 09/04/18.
//  Copyright © 2018 Rishab Dutta. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    private var dynamicViewHeight: CGFloat = 0.0

    private var subviewArray: [UIView]? = []
    
    var indexPath: IndexPath!
    
    lazy var addCellSubviews: () -> () = { [unowned self] in
        let yView = UIView()
        yView.backgroundColor = .yellow
        yView.translatesAutoresizingMaskIntoConstraints = false
        self.addAsSubview(sView: yView)
        NSLayoutConstraint.activate([
            yView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            yView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            yView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -275),
            yView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
            ])
        UIView.animate(withDuration: 1, animations: {
            self.layoutIfNeeded()
        })
    }
    
    var changeCellHeightCompletion: ((IndexPath, CGFloat) -> ())!
    
    @IBAction func deletePressed(_ sender: Any) {
        dynamicViewHeight = 0
        removeAsSubview()
        changeCellHeightCompletion(indexPath, dynamicViewHeight)
    }
    
    @IBAction func addPressed(_ sender: Any) {
        dynamicViewHeight = 200
        changeCellHeightCompletion(indexPath, dynamicViewHeight)

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func addAsSubview(sView: UIView) {
        subviewArray?.append(sView)
        addSubview(sView)
    }
    
    private func removeAsSubview() {
        if subviewArray!.isEmpty {
            return
        }
        subviewArray?.last?.removeFromSuperview()
        subviewArray?.removeLast()
    }
    
}
