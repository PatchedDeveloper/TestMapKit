//
//  ProfileView.swift
//  CryptoMetricsSwiftUI
//
//  Created by Danila Kardashevkii on 22.06.2023.
//

import SwiftUI

extension View {
    @ViewBuilder
    func underline() -> some View {
        self.modifier(Underline())
    }
}

struct Underline: ViewModifier {
    func body(content: Content) -> some View {
        VStack {
            content
                .padding(.leading, 18)
                .foregroundColor(.white)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.white)
        }
    }
}


struct ProfileView: View {
    @State private var isLogoVisible = true
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        VStack {
Spacer()
            Text("Authorization")
                .foregroundColor(.white)
                .font(Font.system(size: 20, weight: .bold))
                .padding(.top,10)// Установка жирного шрифта
            
            
            //TEXTFIEL EMAIL/pass
            VStack{
                HStack{
                    Image(systemName: "mail")
                                .foregroundColor(.white)
                                .padding(.leading, 10)

                    TextField("E-MAIL", text: $email)
                        .foregroundColor(.white) // Color of the entered text
                        .underline()
                        .accentColor(.white) // Color of the placeholder text
                        .colorScheme(.dark)
                    
                    
     
                }
                .cornerRadius(20)
                .padding(.vertical,30)
                .padding(.horizontal,1)
                //TEXTFIEL PASSWORD
                HStack{
                    Image(systemName: "lock.shield")
                                .foregroundColor(.white)
                                .padding(.leading, 10)
           
                    TextField("PASSWORD", text: $password)
                        .foregroundColor(.white) // Color of the entered text
                        .underline()
                        .accentColor(.white) // Color of the placeholder text
                        .colorScheme(.dark)
                    
     
                }
                .cornerRadius(20)
                .padding(.vertical,30)
                .padding(.horizontal,1)
            }
            .padding(.top,15)
            
            ZStack{

                
                Button {
                    
                } label: {
                    Text("SIGN IN")
                        .foregroundColor(.white)
                        .font(Font.system(size: 20, weight: .bold))
                }
                .frame(width: 254, height: 54)
                .background(
                    Color("BtnSignIn")
                        .blur(radius: 10) // Apply the blur effect
                )
                .cornerRadius(30)
                .padding(.top, 30)
            }
            
            Text("DON’T HAVE ACCOUNT?")
                .foregroundColor(.gray  )
                .font(Font.system(size: 20, weight: .bold))
                .padding(.top,70)// Установка жирного шрифта
                
            Button {
                
            } label: {
                Text("Sign up")
                    .foregroundColor(.white)
                    .font(Font.system(size: 20, weight: .bold))
                
            }
            .padding(.top,1)


            Spacer()


        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("background"))
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
