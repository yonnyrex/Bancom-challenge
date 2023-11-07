//
//  CreatePostView.swift
//  Bancom
//
//  Created by Yonny on 7/11/23.
//

import SwiftUI

struct CreatePostView: View {
    // MARK: - PropertyWrappers
    @State var title: String = ""
    @State var descripcion: String = ""
    @State var value = 0.0
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    
    // MARK: - Body
    var body: some View {
        
        VStack(alignment: .center) {
            closeButton
            titleText
            form
            saveButton
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20.0))
        .frame(width: UIScreen.main.bounds.size.width - 32)
        .shadow(radius: 3)
    }
    
    // MARK: - CloseButton
    var closeButton: some View {
        Button {
            self.viewControllerHolder?.dismiss(animated: true, completion: nil)
        } label: {
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.darkGray)
        }
        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
        .padding(20)
    }
    
    // MARK: - TitleText
    var titleText: some View {
        Text("Crear post")
            .font(.system(size: 24, weight: .medium))
            .foregroundColor(Color("Black"))
            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
    }
    
    // MARK: - Form
    var form: some View {
        VStack(alignment: .center) {
            FloatingTextField(placeholder: "Título", text: $title).padding(.horizontal, 20)
            FloatingTextField(placeholder: "Descripción", text: $descripcion).padding([.horizontal, .vertical], 20)
        }
    }
    
    // MARK: - SaveButton
    var saveButton: some View {
        Button(
            action: {
                self.viewControllerHolder?.dismiss(animated: true, completion: nil)
            }, label: {
                HStack(alignment: .center, spacing: 15){
                    Text("Guardar")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color("White"))
                        .padding(.vertical, 15)
                }
                .frame(maxWidth: .greatestFiniteMagnitude)
            }
        )
        .frame(width: 200)
        .background {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color("Primary"))
        }
        .padding([.top, .bottom], 30)
    }
    
}

#Preview {
    CreatePostView()
}
