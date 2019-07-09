//
//  FFVideoCutter.swift
//  FFSpotifySignin
//
//  Created by zhou on 2019/7/9.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit
import AVFoundation

extension String {
    var convert: NSString { return (self as NSString)}
}

open class FFVideoCutter: NSObject {

    /// Block based method for crop video url
    ///
    /// - Parameters:
    ///   - url: Video url
    ///   - startTime: The starting point of the video segments
    ///   - duration: Total times, Video Length
    ///   - complation: complation description
    open func cropVideoWithUrl(video url: URL, startTime: CGFloat, duration: CGFloat, complation:((_ videoPaht: URL?, _ error: NSError?) -> Void)?) {
        
        DispatchQueue.global().async {
            let asset = AVURLAsset(url: url, options: nil)
            let exportSession = AVAssetExportSession(asset: asset, presetName: "AVAssetExportPresetHighestQuality")
            let paths: NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
            var outputURL = paths.object(at: 0) as! String
            let manager = FileManager.default
            
            do {
                try manager.createDirectory(atPath: outputURL, withIntermediateDirectories: true, attributes: nil)
            } catch _ {
                
            }
            
            outputURL = outputURL.convert.appendingPathComponent("output.mp4")
            do {
                try manager.removeItem(atPath: outputURL)
            } catch _ {
                
            }
            if let exprotSession = exportSession as AVAssetExportSession? {
                exportSession?.outputURL = URL(fileURLWithPath: outputURL)
                exportSession?.shouldOptimizeForNetworkUse = true
                exportSession?.outputFileType = AVFileType.mp4
                let start = CMTimeMakeWithSeconds(Float64(startTime), preferredTimescale: 600)
                let duration = CMTimeMakeWithSeconds(Float64(duration), preferredTimescale: 600)
                let range = CMTimeRangeMake(start: start, duration: duration)
                exportSession?.timeRange = range
                exportSession?.exportAsynchronously(completionHandler: {
                    switch exprotSession.status {
                    case AVAssetExportSession.Status.completed:
                        complation?(exportSession?.outputURL,nil)
                    case .unknown: break
                        
                    case .waiting: break
                        
                    case .exporting: break
                        
                    case .failed:
                        print("Failed:\(String(describing: exportSession?.error))")
                    case .cancelled:
                         print("Failed:\(String(describing: exportSession?.error))")
                    @unknown default:
                        print("default case")
                    }
                })
            }
            DispatchQueue.main.async {
                
            }
        }
    }
}
