//
//  MainView.swift
//  Bancom
//
//  Created by Yonny on 7/11/23.
//

import SwiftUI

struct MainView: View {
    // MARK: - PropertyWrappers
    @ObservedObject var viewModel = MainViewModel()
    @State var showModal: Bool = false
    @State var isCollapsed = (false, 0)
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?

    // MARK: - Body
    var body: some View {
        header
        ScrollView {
            VStack {
                content
                Spacer()
            }
            .onAppear {
                viewModel.setUpViewModel()
            }
        }.navigationBarBackButtonHidden(true)

    }

    // MARK: - Header
    var header: some View {
        HStack(spacing: 20) {
            textCell(text: "Nombre")
            textCell(text: "Username")
            textCell(text: "Dirección")
            textCell(text: "Correo")
            textCell(text: "Phone Number")
            textCell(text: "Post")
        }
        .padding(.vertical, 20)
        .frame(maxWidth: .greatestFiniteMagnitude)
        .background(Color("DarkGray"))
    }
    
    // MARK: - Content
    var content: some View {
        ForEach(viewModel.listUsers) { user in
            VStack(spacing: 0) {
                Button {
                    withAnimation {
                        if isCollapsed.1 == user.id {
                            isCollapsed.0.toggle()
                        } else if isCollapsed.1 != user.id {
                            isCollapsed.0 = true
                        }
                        isCollapsed.1 = user.id
                        viewModel.getPosts(userID: user.id)
                    }
                } label: {
                    VStack {
                        Divider()
                        HStack(spacing: 20) {
                            textCell(text: user.name, textColor: Color("Black"))
                            textCell(text: user.username, textColor: Color("Black"))
                            textCell(text: "\(user.address.street), \(user.address.suite), \(user.address.city)", textColor: Color("Black"))
                            textCell(text: user.email, textColor: Color("Black"))
                            textCell(text: user.phone, textColor: Color("Black"))
                            Image(systemName: isCollapsed.0 && isCollapsed.1 == user.id ? "chevron.up" : "chevron.down")
                                .frame(maxWidth: .infinity)
                        }
                        .padding(.vertical, 20)
                        .frame(maxWidth: .greatestFiniteMagnitude)
                    }
                    .padding(.top, -8)
                }
                if isCollapsed.0 && isCollapsed.1 == user.id {
                    createPostView
                        .transition(transition)
                }
            }
        }
    }
    
    // MARK: - CreatePostView
    var createPostView: some View {
        ZStack(alignment: .center) {
            if viewModel.listUsers.isEmpty {
                VStack(spacing: 10) {
                    Text("Aún no tienes posts")
                        .font(.system(size: 10, weight: .regular)).foregroundColor(Color("Black"))
                    createPostButton
                }
            } else {
                HStack(alignment: .top, spacing: 10) {
                    VStack(spacing: 10) {
                        ForEach(viewModel.listPosts) { post in
                            postView(post: post)
                        }
                    }
                   
                    Spacer()
                    createPostButton
                }.padding(30)
            }
        }
    }
    
    // MARK: - CreatePostButton
    var createPostButton: some View {
        Button(
            action: {
                self.viewControllerHolder?.present(style: .overCurrentContext, transitionStyle: .crossDissolve) {
                    CreatePostView()
                }
            }, label: {
                HStack(alignment: .center, spacing: 15){
                    Text("Crear un post")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color("White"))
                        .padding(.vertical, 10)
                }
                .frame(maxWidth: .greatestFiniteMagnitude)
            }
        )
        .frame(width: 120)
        .background {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color("Primary"))
        }
        .padding(.bottom, 50)
    }
    
    
    // MARK: - Transition
    var transition: AnyTransition {
        .asymmetric(
            insertion: .opacity.animation(.default.delay(0.15)),
            removal: .opacity.animation(.default.speed(2))
        )
    }
    
    // MARK: - TextCell
    @ViewBuilder
    func textCell(text: String, textColor: Color = .white) -> some View {
        Text(text)
            .font(
                .system(
                    size: 10,
                    weight: .regular
                )
            )
            .foregroundColor(textColor)
            .frame(maxWidth: .infinity)
    }
    
    // MARK: - PostView
    @ViewBuilder
    func postView(post: Post) -> some View {
        VStack(spacing: 10) {
            Text(post.title)
                .font(.system(size: 18, weight: .semibold)).foregroundColor(Color("Black")).frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
            Text(post.body)
                .font(.system(size: 12, weight: .regular)).foregroundColor(Color("Black")).frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
        }.padding(.bottom, 10)
    }
}

#Preview {
    MainView()
}
