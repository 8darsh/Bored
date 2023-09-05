//
//  BoringViewController.swift
//  BoringApp
//
//  Created by Adarsh Singh on 06/09/23.
//

import UIKit

class BoringViewController: UIViewController {
    
    private var viewModel = BoringViewModel()
    var link:String!
    @IBOutlet var boredBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        viewModel.fetchActivity()
    }
    
    
    @IBAction func boredBtnAction(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Activity", message: "Let's Do It!", preferredStyle: .alert)
        
        
        alert.message = """
Activity: \((viewModel.bored?.activity)!)\n
Type: \((viewModel.bored?.type)!)\n
Participants: \((viewModel.bored?.participants)!)
"""
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        alert.addAction(UIAlertAction(title: "New Activity", style: .default){
            _ in
            self.viewModel.fetchActivity()
        })
        if viewModel.bored?.link != ""{
            alert.addAction(UIAlertAction(title: "Link", style: .default){
                _ in
                if let url = NSURL(string: "\(self.viewModel.bored?.link ?? "hehe")"){
                    UIApplication.shared.open(url as URL)
                }
            })
        }
       present(alert, animated: true)
    }
    
    
    
    
    
    
}
