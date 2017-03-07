//
//  ViewController.swift
//  Translate
//
//  Created by Robert O'Connor on 16/10/2015.
//  Copyright © 2015 WIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet var textToTranslate: UITextView!
    @IBOutlet weak var translatedText: UITextView!
    @IBOutlet var languagePicker: UIPickerView!
    
    //var data = NSMutableData()
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //connect
        self.languagePicker.delegate = self
        self.languagePicker.dataSource = self
        
        //input
        pickerData = ["French", "German", "Spanish"]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    func numberOfComponents(in: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent: Int) -> Int{
        return pickerData.count
    }
    

    
    @IBAction func translate(_ sender: AnyObject) {
        
        let str = textToTranslate.text
        let escapedStr = str?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        let langStr = ("en|fr").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        let urlStr:String = ("https://api.mymemory.translated.net/get?q="+escapedStr!+"&langpair="+langStr!)
        
        let url = URL(string: urlStr)
        
        let request = URLRequest(url: url!)// Creating Http Request
        
        //var data = NSMutableData()var data = NSMutableData()
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
        
        var result = "<Translation Error>"
        
      // NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { response, data, error in
            
            indicator.stopAnimating()
            
            //if let httpResponse = response as? HTTPURLResponse {
                //if(httpResponse.statusCode == 200){
                    
                    //let jsonDict: NSDictionary!=(try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
                    
                    //if(jsonDict.value(forKey: "responseStatus") as! NSNumber == 200){
                      // let responseData: NSDictionary = jsonDict.object(forKey: "responseData") as! NSDictionary
                        
                      // result = responseData.object(forKey: "translatedText") as! String
                    //}
                }
                
               // self.translatedText.text = result
           // }
            
            
        //}
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n")
        {
            textToTranslate.resignFirstResponder()
            return false
        }
        return true
    }
}




//}


