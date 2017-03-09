//
//  ViewController.swift
//  Translate
//
//  Created by Robert O'Connor on 16/10/2015.
//  Copyright © 2015 WIT. All rights reserved.
//

import UIKit
import Speech


@available(iOS 10.0, *)
class ViewController: UIViewController, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, SFSpeechRecognizerDelegate {
    

    @IBOutlet var textToTranslate: UITextView!
    @IBOutlet weak var translatedText: UITextView!
    @IBOutlet var languagePicker: UIPickerView!
    @IBOutlet var speechButton: UIButton!
    @IBOutlet weak var clearText: UIButton!
    
    //var data = NSMutableData()
    
    var languageAnswer = 0
    var pickerData = ["French", "Italian", "German"]

    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))  //1
    
    
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //connect
        languagePicker.delegate=self
        languagePicker.dataSource=self
        
        
        
        speechButton.isEnabled = false  //2
        
        speechRecognizer?.delegate = self  //3
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in  //4
            
            var isButtonEnabled = false
            
            switch authStatus {  //5
            case .authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            OperationQueue.main.addOperation() {
                self.speechButton.isEnabled = isButtonEnabled
            }
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        languageAnswer = row
    }
    
    

    
    @IBAction func translate(_ sender: AnyObject) {
        if (languageAnswer==0){
            
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
        
      NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { response, data, error in
            
            indicator.stopAnimating()
            
            if let httpResponse = response as? HTTPURLResponse {
                if(httpResponse.statusCode == 200){
                    
                    let jsonDict: NSDictionary!=(try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
                    
                    if(jsonDict.value(forKey: "responseStatus") as! NSNumber == 200){
                       let responseData: NSDictionary = jsonDict.object(forKey: "responseData") as! NSDictionary
                        
                       result = responseData.object(forKey: "translatedText") as! String
                    }
                }
                
                self.translatedText.text = result
           }
            
    }
}
            
            
            
            
            
           
            else if(languageAnswer==1){
                
            let str = textToTranslate.text
            let escapedStr = str?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            
            let langStr = ("en|it").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            
            let urlStr:String = ("https://api.mymemory.translated.net/get?q="+escapedStr!+"&langpair="+langStr!)
            
            let url = URL(string: urlStr)
            
            let request = URLRequest(url: url!)// Creating Http Request
            
            //var data = NSMutableData()var data = NSMutableData()
            
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            indicator.center = view.center
            view.addSubview(indicator)
            indicator.startAnimating()
            
            var result = "<Translation Error>"
            
            NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { response, data, error in
                
                indicator.stopAnimating()
                
                if let httpResponse = response as? HTTPURLResponse {
                    if(httpResponse.statusCode == 200){
                        
                        let jsonDict: NSDictionary!=(try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
                        
                        if(jsonDict.value(forKey: "responseStatus") as! NSNumber == 200){
                            let responseData: NSDictionary = jsonDict.object(forKey: "responseData") as! NSDictionary
                            
                            result = responseData.object(forKey: "translatedText") as! String
                        }
                    }
                    
                    self.translatedText.text = result
                }
                
            }
                
                
    }
            
            
            
            
            
            
            
            
            
            else
            {
                let str = textToTranslate.text
                let escapedStr = str?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                
                let langStr = ("en|de").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                
                let urlStr:String = ("https://api.mymemory.translated.net/get?q="+escapedStr!+"&langpair="+langStr!)
                
                let url = URL(string: urlStr)
                
                let request = URLRequest(url: url!)// Creating Http Request
                
                //var data = NSMutableData()var data = NSMutableData()
                
                let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                indicator.center = view.center
                view.addSubview(indicator)
                indicator.startAnimating()
                
                var result = "<Translation Error>"
                
                NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { response, data, error in
                    
                    indicator.stopAnimating()
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        if(httpResponse.statusCode == 200){
                            
                            let jsonDict: NSDictionary!=(try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
                            
                            if(jsonDict.value(forKey: "responseStatus") as! NSNumber == 200){
                                let responseData: NSDictionary = jsonDict.object(forKey: "responseData") as! NSDictionary
                                
                                result = responseData.object(forKey: "translatedText") as! String
                            }
                        }
                        
                        self.translatedText.text = result
                    }
                    
                }
                
                
            }
        }
    
    
    
    
    
    
    //AppCoda - http://www.appcoda.com/siri-speech-framework/
    
    @IBAction func speechTapped(_ sender: Any) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            speechButton.isEnabled = false
            speechButton.setTitle("Start Recording", for: .normal)
        } else {
            startRecording()
            speechButton.setTitle("Stop Recording", for: .normal)
        }
    }
    
    
    func startRecording() {
        
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                
                self.textToTranslate.text = result?.bestTranscription.formattedString
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.speechButton.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        textToTranslate.text = "Say something, I am ready to translate for you!"
        
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            speechButton.isEnabled = true
        } else {
            speechButton.isEnabled = false
        }
    }
    
    @IBAction func clearText(_ sender: AnyObject)
    {
        textToTranslate.text=""
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n")
        {
            textToTranslate.resignFirstResponder()
            return false
        }
        return true
    }
}






