//
//  LoginView.swift
//  Bancom
//
//  Created by Yonny on 7/11/23.
//

import SwiftUI

struct LoginView: View {
    // MARK: - PropertyWrappers
    @State var email: String = ""
    @State var password: String = ""
    @State private var isOn = false

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            welcomeTitle
            form
            forgetPassword
            rememberEmail
            Spacer()
            loginButton
            loginGoogleButton
        }
        .padding(.horizontal, 20)

    }
    
    // MARK: - WelcomeTitle
    var welcomeTitle: some View {
        VStack(alignment: .leading) {
            Text("Bienvenido")
                .font(.system(size: 16, weight: .regular))
            Text("Inicia sesión")
                .font(.system(size: 30, weight: .bold))
        }
        .frame(
            maxWidth: .greatestFiniteMagnitude,
            alignment: .leading
        )
        .padding(.top, 100)
    }
    
    // MARK: - Form
    var form: some View {
        VStack(spacing: 40) {
            FloatingTextField(placeholder: "Correo electrónico", text: $email)
            FloatingTextField(placeholder: "Contraseña", isPassword: true, text: $password)

        }.padding(.top, 31)
    }
    
    // MARK: - ForgetPassword
    var forgetPassword: some View {
        Button(
            action: {
                
            },
            label: {
                Text("¿Olvidaste tu contraseña?")
                    .font(.system(size: 14, weight: .regular))
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .foregroundColor(Color("Tertiary"))
                    .padding(.top, 8)
            }
        )
    }
    
    // MARK: - RememberEmail
    var rememberEmail: some View {
        Toggle(isOn: $isOn) {
            Text("Recordar correo")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(Color("Secondary"))
        }
        .toggleStyle(CheckBox())
        .padding(.top, 20)
    }
    
    // MARK: - LoginButton
    var loginButton: some View {
        Button(
            action: {
                
            }, label: {
                Text("Ingresar")
                    .font(.system(size: 16, weight: .bold))
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .center)
                    .foregroundColor(Color("White"))
                    .padding(15)
            }
        )
        .frame(maxWidth: .greatestFiniteMagnitude)
        .background {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color("Primary"))
        }
        .padding(.bottom, 18)
    }
    
    // MARK: - LoginGoogleButton
    var loginGoogleButton: some View {
        Button(
            action: {
                
            }, label: {
                HStack(alignment: .center, spacing: 15){
                    Image("icon-google", bundle: nil)
                    Text("Ingresar  con google")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color("White"))
                        .padding(.vertical, 15)
                }
                .frame(maxWidth: .greatestFiniteMagnitude)
            }
        )
        .frame(maxWidth: .greatestFiniteMagnitude)
        .background {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color("Secondary"))
        }
        .padding(.bottom, 50)
    }
}

#Preview {
    LoginView()
}
