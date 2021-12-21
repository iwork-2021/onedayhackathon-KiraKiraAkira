//
//  MyTableViewCell.swift
//  OneDayHackathon
//
//  Created by KiraKiraAkira on 2021/12/21.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myType: UILabel!
    @IBOutlet weak var showFull: UIButton!
    
    @IBAction func showFull(_ sender: Any) {
        let  tableView = superTableView()
        let  indexPath = tableView?.indexPath( for :  self )
        print ( "indexPath：\(indexPath!)" )
    }
    @IBAction func showAll(_ sender: Any) {
        let  tableView = superTableView()
        let  indexPath = tableView?.indexPath( for :  self )
        print ( "indexPath：\(indexPath!)" )
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
extension  MyTableViewCell  {
     //返回cell所在的UITableView
     func  superTableView() ->  UITableView? {
         for  view  in  sequence(first:  self .superview, next: { $0?.superview }) {
             if  let  tableView = view  as?  UITableView  {
                 return  tableView
             }
         }
         return  nil
     }
}
