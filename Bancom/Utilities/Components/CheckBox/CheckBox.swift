//
//  CheckBox.swift
//  Bancom
//
//  Created by Yonny on 7/11/23.
//

import SwiftUI

struct CheckBox: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                Image(
                    systemName: configuration.isOn ? "checkmark.square" : "square"
                )
                .foregroundColor(Color( "Primary"))
                configuration.label
            }
        })
    }
}
