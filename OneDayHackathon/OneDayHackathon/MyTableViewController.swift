//
//  MyTableViewController.swift
//  OneDayHackathon
//
//  Created by KiraKiraAkira on 2021/12/21.
//
//ImageItem(image: "/Users/kirakiraakira/Documents/NJUCS/ios_develop/onedayhackathon-KiraKiraAkira/1.jpg", imgType: "1"),
//ImageItem(image: "/Users/kirakiraakira/Documents/NJUCS/ios_develop/onedayhackathon-KiraKiraAkira/2.jpg", imgType: "2"),
//ImageItem(image: "/Users/kirakiraakira/Documents/NJUCS/ios_develop/onedayhackathon-KiraKiraAkira/3.jpg", imgType: "3")
import UIKit
import Vision
import CoreMedia
import CoreML
var imgNum:Int=0
class MyTableViewController: UITableViewController {
    lazy var classificationRequest: VNCoreMLRequest = {
                do{
                    let classifier = try snacks(configuration: MLModelConfiguration())
                    
                    let model = try VNCoreMLModel(for: classifier.model)
                    let request = VNCoreMLRequest(model: model, completionHandler: {
                        [weak self] request,error in
                        self?.processObservations(for: request, error: error)
                    })
                    request.imageCropAndScaleOption = VNImageCropAndScaleOption.centerCrop
                    return request
                    
                    
                } catch {
                    fatalError("Failed to create request")
                }
        }()
    func processObservations(for request: VNRequest, error: Error?) {
            if let results = request.results as? [VNClassificationObservation] {
                if results.isEmpty {
                    print("nothing found")
                } else {
                    let result = results[0].identifier
                    let confidence = results[0].confidence
                    let stringtemp = String(format: "%.1f%%", confidence * 100)
                    items.append(ImageItem(image: String(imgNum),imgType: String(imgNum)))
                    if confidence <= 0.7{
                        //self.resultsLabel.text = "i am not sure"
                        items[imgNum].imgType = "others"
                    }else{
                        items[imgNum].imgType = result
                    }
                    
                    imgNum=imgNum+1
                    //self.showResultsView()
                    print(result)
                    self.tableView.reloadData()
                }
            } else if let error = error {
                //self.resultsLabel.text = "Error: \(error.localizedDescription)"
                print("Error: \(error.localizedDescription)")
            } else {
                //self.resultsLabel.text = "???"
                print("???")
            }
        }
    func classify(image: UIImage) {
        DispatchQueue.main.async {
                  let handler = VNImageRequestHandler(cgImage: image.cgImage!)
                  do {
                      try handler.perform([self.classificationRequest])
                  } catch {
                      print("Failed to perform classification: \(error)")
                  }
                  
              }
          
    }
    @IBOutlet weak var photoLibraryButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    var items:[ImageItem]=[
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        print("test table")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("show cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! MyTableViewCell
        let item = items[indexPath.row]
        //cell.myImage.image=UIImage(named: item.imgType)
        cell.myType.text=item.imgType
        // Configure the cell...
        let fullPath = NSHomeDirectory().appending("/Documents/").appending(String(item.image))
        print("load",fullPath)
        if let savedImage = UIImage(contentsOfFile:fullPath ) {
            cell.myImage.image = savedImage
                    } else {
                        print("文件不存在")
                    }
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showFull"{
            print("hit")
            let t = sender as! UIButton
            
            for  view  in  sequence(first:  t.superview, next: { $0?.superview }) {
                if  let  tt = view  as?  UITableViewCell  {
                    //print("hello")
                    var rowNum:Int=tableView.indexPath(for: tt)!.row
                    //print(rowNum)
                    let fsc = segue.destination as! FullShowViewController
                    fsc.imgNum=rowNum
                }
            }
            
            
//                  let addItemViewController = segue.destination as! FullShowViewController
//                  addItemViewController.addItemDelegate=self
//            if sender.
//            let cell = sender.superview as! MyTableViewCell
//            print(tableView.indexPath(for: cell)?.row)
        }else{
            let t = sender as! UIButton
            
            for  view  in  sequence(first:  t.superview, next: { $0?.superview }) {
                if  let  tt = view  as?  UITableViewCell  {
                    print("same kind")
                    var rowNum:Int=tableView.indexPath(for: tt)!.row
                    //print(rowNum)
                    let fsc = segue.destination as! SameKindTableViewController
                    let target_kind=items[rowNum].imgType
                    var target_items:[ImageItem]=[
                    ]
                    for i in items{
                        if i.imgType==target_kind{
                            target_items.append(i)
                        }
                    }
                    fsc.items=target_items
                }
            }
        }
    }
    
    
    @IBAction func choosePhoto(_ sender: Any) {
        presentPhotoPicker(sourceType: .photoLibrary)
    }
    @IBAction func takePicture(_ sender: Any) {
        presentPhotoPicker(sourceType: .camera)
    }
    func presentPhotoPicker(sourceType: UIImagePickerController.SourceType) {
      let picker = UIImagePickerController()
      picker.delegate = self
      picker.sourceType = sourceType
      present(picker, animated: true)
      
    }
    @IBAction func showFullPic(_ sender: Any) {
        print("show me the full size")
    }
    
    @IBAction func showSamePic(_ sender: Any) {
        print("show me all")
    }
    
    
}

extension MyTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    picker.dismiss(animated: true)

    let image = info[.originalImage] as! UIImage
    classify(image: image)
    //items.append(ImageItem(image: String(imgNum), imgType: String(imgNum)))
    if let imageData = image.jpegData(compressionQuality: 1) as NSData? {
        let fullPath = NSHomeDirectory().appending("/Documents/").appending(String(imgNum))
        imageData.write(toFile: fullPath, atomically: true)
//        print("fullPath=\(fullPath)")
//        print(items.count)
//        for i in items{
//            print(i.image)
//        }
//        imgNum=imgNum+1
        self.tableView.reloadData()
    }
  }
}
