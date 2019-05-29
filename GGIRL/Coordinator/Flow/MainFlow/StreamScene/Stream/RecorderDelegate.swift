//
//  RecorderDelegate.swift
//  GGIRL
//
//  Created by VARVAR on 05.03.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import HaishinKit
import UIKit
import AVFoundation
import Photos
import VideoToolbox

class RecorderDelegate: DefaultAVRecorderDelegate {
    override func didFinishWriting(_ recorder: AVRecorder) {
        guard let writer: AVAssetWriter = recorder.writer else { return }
        PHPhotoLibrary.shared().performChanges({() -> Void in
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: writer.outputURL)
        }, completionHandler: { _, error -> Void in
            do {
                try FileManager.default.removeItem(at: writer.outputURL)
            } catch {
                print(error)
            }
        })
    }
}
