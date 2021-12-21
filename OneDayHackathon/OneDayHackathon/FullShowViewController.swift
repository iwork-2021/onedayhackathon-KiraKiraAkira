//
//  FullShowViewController.swift
//  OneDayHackathon
//
//  Created by KiraKiraAkira on 2021/12/21.
//

import UIKit

class FullShowViewController: UIViewController {
    var imgNum:Int=0
    @IBOutlet weak var FullPic: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let fullPath = NSHomeDirectory().appending("/Documents/").appending(String(imgNum))
        //print("load",fullPath)
        if let savedImage = UIImage(contentsOfFile:fullPath ) {
            FullPic.image = savedImage
                    } else {
                        print("文件不存在")
                    }
        //print("I will show full.")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
