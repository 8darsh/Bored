//
//  BoringViewModel.swift
//  BoringApp
//
//  Created by Adarsh Singh on 06/09/23.
//

import Foundation

final class BoringViewModel{
    
    var bored: Boring?
    
    var eventHandler:((_ event: Event)-> Void)?
    func fetchActivity(){
        
        self.eventHandler?(.loading)
        ApiManager.shared.fetchData{ response in
            
            self.eventHandler?(.stopLoading)
            switch response{
                
            case .success(let boring):
                
                self.bored = boring
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                
                self.eventHandler?(.error(error))
                
            }

            
        }
    }
}

extension BoringViewModel{
    
    enum Event{
        
        case loading
        case stopLoading
        case dataLoaded
        
        case error(Error?)
    }
}
