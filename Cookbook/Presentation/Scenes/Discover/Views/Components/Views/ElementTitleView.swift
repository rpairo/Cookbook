//
//  ElementTitleView.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 5/3/21.
//

import SwiftUI

struct ElementTitleView: View {
    // MARK: Properties
    var title: String

    // MARK: View
    var body: some View {
        Text(title)
            .padding()
            .font(.title)
            .foregroundColor(.white)
    }
}
