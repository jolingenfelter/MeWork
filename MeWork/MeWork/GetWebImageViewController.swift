//
//  GetWebImageViewController.swift
//  MeWork
//
//  Created by Joanna Lingenfelter on 7/7/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class GetWebImageViewController: UIViewController {
    
    let webView = UIWebView()
    let progressView = UIProgressView()
    var loadTimer = Timer()
    let longPressRecognizer = UILongPressGestureRecognizer()
    var webViewIsLoaded = false
    
    var imageURL: URL?
    var currentUserURL: URL?
    
    var tokenBoard: TokenBoard?
    
    convenience init(tokenBoard: TokenBoard) {
        
        self.init()
        
        self.tokenBoard = tokenBoard
        
    }
    
    lazy var urlTextField: UITextField = {
        
        let textField = UITextField()
        
        let indentView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftView = indentView
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        
        textField.delegate = self
        textField.returnKeyType = .go
        textField.keyboardType = .webSearch
        textField.autocorrectionType = .no
        textField.clearButtonMode = .whileEditing
        textField.autocapitalizationType = .none
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(textField)
        
        return textField
    
    }()
    
    lazy var backButton : UIBarButtonItem = {
        
        let button = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(backPressed))
        return button
        
    }()
    
    lazy var forwardButton: UIBarButtonItem = {
        
        let button = UIBarButtonItem(title: ">", style: .plain, target: self, action: #selector(forwardPressed))
        return button
        
    }()
    
    lazy var refreshButton: UIBarButtonItem = {
        
        let button = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshPressed))
        return button
        
    }()
    
    lazy var toolbar: UIToolbar = {
        
        let bar = UIToolbar()
        self.view.addSubview(bar)
        let fixedSpaceItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpaceItem.width = 10
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        bar.setItems([self.backButton, fixedSpaceItem, self.forwardButton, flexibleSpace, self.refreshButton], animated: true)
        self.backButton.isEnabled = false
        self.forwardButton.isEnabled = false
        
        bar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(bar)
        
        return bar
        
    }()
    
    let getImageJavaScript = "function GetImgSourceAtPoint(x,y) { var msg = ''; var e = document.elementFromPoint(x,y); while (e) { if (e.tagName == 'IMG') { msg += e.src; break; } e = e.parentNode; } return msg; }"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Reload URL if returning from saving an image, iPads don't need this for formsheet presentation
        if UIDevice.current.userInterfaceIdiom == .phone {
            if let currentUserURL = currentUserURL {
                let request = URLRequest(url: currentUserURL)
                webView.loadRequest(request)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        webViewSetup()
        navBarSetup()
        longPressGestureSetup()

        // Do any additional setup after loading the view.
    }
    
    func webViewSetup() {
        
        webView.delegate = self
        webView.scalesPageToFit = true
        let url = URL(string: "http://www.google.com")
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
        
    }
    
    func longPressGestureSetup() {
        
        longPressRecognizer.delegate = self
        longPressRecognizer.addTarget(self, action: #selector(longPressAction(sender:)))
        webView.addGestureRecognizer(longPressRecognizer)
        
    }
    
    func navBarSetup() {
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        navigationItem.rightBarButtonItem = cancelButton
        let helpButton = UIBarButtonItem(title: "Help", style: .plain, target: self, action: #selector(helpPressed))
        navigationItem.leftBarButtonItem = helpButton
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        // TextField Constraints
        
        guard let navigationBar = navigationController?.navigationBar else {
            return
        }
        
        NSLayoutConstraint.activate([
            urlTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            urlTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            urlTextField.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 5),
            urlTextField.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        // ProgresViewConstraings
        
        view.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            progressView.topAnchor.constraint(equalTo: urlTextField.bottomAnchor)
            ])
        
        // WebView Constraints
        
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: progressView.bottomAnchor),
            webView.bottomAnchor.constraint(equalTo: toolbar.topAnchor)
            ])
        
        // Toolbar Constraints
        
        NSLayoutConstraint.activate([
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolbar.topAnchor.constraint(equalTo: webView.bottomAnchor),
            toolbar.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])

        
    }
    
    // MARK: - Timer
    
    @objc func timerCallBack() {
        
        if webViewIsLoaded == true {
            
            if progressView.progress >= 1 {
                
                loadTimer.invalidate()
                
            } else {
                
                progressView.progress += 0.1
                
            }
        } else {
            
            progressView.progress += 0.05
            
            if progressView.progress >= 0.95 {
                progressView.progress = 0.95
            }
            
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(true)
        
        webView.loadHTMLString("", baseURL: nil)
        
    }

}

// MARK: - ToolBar Navigation

extension GetWebImageViewController {
    
    @objc func donePressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func helpPressed() {
//        let helpViewController = WebViewHelpViewController()
//        helpViewController.modalPresentationStyle = .formSheet
//        self.present(helpViewController, animated: true, completion: nil)
    }
    
    @objc func backPressed() {
        webView.goBack()
    }
    
    @objc func forwardPressed() {
        webView.goForward()
    }
    
    @objc func refreshPressed() {
        webView.reload()
    }
    
    func updateButtons() {
        
        if webView.canGoBack {
            backButton.isEnabled = true
        } else {
            backButton.isEnabled = false
        }
        
        if webView.canGoForward {
            forwardButton.isEnabled = true
        } else {
            forwardButton.isEnabled = false
        }
    }
    
}

// MARK: - UIWebViewDelegate

extension GetWebImageViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
       
        progressView.isHidden = false
        progressView.progress = 0.0
        webViewIsLoaded = false
        loadTimer = Timer.scheduledTimer(timeInterval: 0.01667, target: self, selector: #selector(timerCallBack), userInfo: nil, repeats: true)
        updateButtons()
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        self.urlTextField.text = webView.request?.url?.absoluteString
        webViewIsLoaded = true
        progressView.isHidden = true
        updateButtons()
        
        // Disable user text selection
        webView.stringByEvaluatingJavaScript(from: "document.documentElement.style.webkitUserSelect='none';")
        webView.stringByEvaluatingJavaScript(from: "document.documentElement.style.webkitTouchCallout='none';")
        
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
        webViewIsLoaded = true
        progressView.isHidden = true
        updateButtons()
        
    }
    
}

extension GetWebImageViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        urlTextField.resignFirstResponder()
        
        if var urlString = urlTextField.text {
            
            if urlString.contains(" ") {
                let searchString = urlString.replacingOccurrences(of: " ", with: "+")
                urlString = "google.com/search?q=\(searchString)"
            }
            
            let characterSet = "-0123456789."
            
            if !isAnyCharacter(from: characterSet, containedIn: urlString) {
                let searchString = urlString
                urlString = "google.com/search?q=\(searchString)"
            }
            
            var userURL = URL(string: "")
            let url = URL(string: urlString)
            
            if var url = url {
                
                if (url.scheme == nil) {
                    
                    url = URL(string: "http://\(url)")!
                    userURL = url
                    
                } else {
                    
                    userURL = url
                    
                }
                
                let request = URLRequest(url: userURL!)
                webView.loadRequest(request)
            }
        }
        
        return false

    }
    
    func isAnyCharacter(from characterSetString: String, containedIn string: String) -> Bool {
        return Set(characterSetString).isDisjoint(with: Set(string)) == false
    }
    
}

// MARK: - GestureRecognizerDelegate & Gesture Selector

extension GetWebImageViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
        
    }
    
    @objc func longPressAction(sender: UILongPressGestureRecognizer) {
        
        webView.stringByEvaluatingJavaScript(from: getImageJavaScript)
        
        if sender.state == UIGestureRecognizerState.recognized {
            
            currentUserURL = webView.request?.url
            let point = sender.location(in: webView)
            
            guard let imageSRC = webView.stringByEvaluatingJavaScript(from: "GetImgSourceAtPoint(\(point.x),\(point.y));"), imageSRC != "" else {
                return
            }
            
            imageURL = URL(string: imageSRC)
            
            guard let imageURL = imageURL else {
                return
            }
            
            
            let saveImageVC = SaveWebImageViewController(imageURL: imageURL)
            
            switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                
                saveImageVC.modalPresentationStyle = .formSheet
                self.present(saveImageVC, animated: true, completion: nil)
                
            case .phone:
                
                let navigationController = UINavigationController(rootViewController: saveImageVC)
                self.present(navigationController, animated: true, completion: nil)
                
            default:
                break
            }
        
        }
        
    }
}
