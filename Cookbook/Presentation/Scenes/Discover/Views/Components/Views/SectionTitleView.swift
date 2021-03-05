//
//  SectionTitleView.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 5/3/21.
//

import SwiftUI

struct SectionTitleView: View {
    // MARK: Properties
    var title: String

    // MARK: View
    var body: some View {
        Text(title)
            .font(.title)
            .foregroundColor(.blue)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .padding(.top)
            .padding(.horizontal)
    }
}
