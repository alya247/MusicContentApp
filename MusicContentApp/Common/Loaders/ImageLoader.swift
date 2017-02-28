//
//  ImageLoader.swift
//  MusicContentApp
//
//  Created by Alya Filon on 19.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import Foundation
import UIKit

let imageLoaderQueue: OperationQueue = {
    let operationQueue = OperationQueue()
    operationQueue.maxConcurrentOperationCount = 5
    return operationQueue
}()

class ImageLoader {
    
    enum LoadingResult {
        case success(image: UIImage)
        case failure
    }
    
    static func loadImage(withURLString url: String, handler: @escaping(_ result: LoadingResult) -> Void) {
        let operation = BlockOperation {
            if let photoURL = url as String! {
                guard let url = URL(string: photoURL) else {
                    return
                }
                do {
                    let data = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        if image != nil {
                            handler(.success(image: image!))
                        }
                    }
                } catch(let error) {
                    handler(.failure)
                }
            } else {
                DispatchQueue.main.async {
                    handler(.failure)
                }
            }
        }
        imageLoaderQueue.addOperation(operation)
    }
}
