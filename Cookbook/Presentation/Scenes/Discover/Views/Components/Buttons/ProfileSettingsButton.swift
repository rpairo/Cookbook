//
//  ProfileSettingsButton.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 5/3/21.
//

import SwiftUI

struct ProfileSettingsButton: View {
    // MARK: Properties
    var action: () -> Void

    // MARK: View
    var body: some View {
        button
    }
}

extension ProfileSettingsButton {
    // MARK: Components
    private var button: some View {
        Button(action: {
            action()
        }, label: {
            image
        })
    }

    private var image: some View {
        Image(systemName: "gear")
    }
}
