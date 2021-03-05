//
//  OpaqueLayerView.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 5/3/21.
//

import SwiftUI

struct OpaqueLayerView: View {
    // MARK: View
    var body: some View {
        Rectangle()
            .background(Color.black)
            .opacity(0.3)
    }
}
