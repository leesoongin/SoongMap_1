//
//  Marker.swift
//  SoongMap_1
//
//  Created by 이숭인 on 2020/12/31.
//

import UIKit
import NMapsMap

struct Marker {
    let marker : NMFMarker
    let document : Document
    
    init(marker : NMFMarker, document : Document) {
        self.marker = marker
        self.document = document
    }
}
