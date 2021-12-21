//
//  ImageItem.swift
//  OneDayHackathon
//
//  Created by KiraKiraAkira on 2021/12/21.
//

import UIKit

class ImageItem: NSObject {
    var image:String
    var imgType:String
    init(image:String,imgType:String) {
        self.image=image
        self.imgType=imgType
    }
}
