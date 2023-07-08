//
//  ProfileView.swift
//  CryptoMetricsSwiftUI
//
//  Created by Danila Kardashevkii on 22.06.2023.
//

import SwiftUI


struct RegView: View {
    @State private var isLogoVisible = true
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isShowAlert = false
    @State private var alertMessage = ""
    
    
    
    var body: some View {
        VStack {
Spacer()
            Text("Registration")
                .foregroundColor(.white)
                .font(Font.system(size: 20, weight: .bold))
                .padding(.top,10)// Установка жирного шрифта
            
            Spacer()
            
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
                
                
                //TEXTFIEL PASSWORD
                HStack{
                    Image(systemName: "lock.shield")
                                .foregroundColor(.white)
                                .padding(.leading, 10)
           
                    TextField("REPEAT PASSWORD", text: $confirmPassword)
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
                    print("User Registration...")
                    
                    guard password == confirmPassword else {
                        self.alertMessage = "Пароли не совпадают!"
                        self.isShowAlert.toggle()
                        return
                    }
                    
                    AuthService.shared.signUp(email: email,
                                              password: password) { result in
                        switch result{
                            
                        case .success(let user):
                            alertMessage = "Вы зарегистрировались с почтой \(user.email!)!"
                            self.isShowAlert.toggle()
                            self.email = ""
                            self.password = ""
                            self.confirmPassword = ""
                            //добавить переход на страницу авторизации
                        case .failure(let error):
                            alertMessage = "Ошибка регистрации \(error.localizedDescription)!"
                            self.isShowAlert.toggle()
                        }
                    }
                    
                    
                } label: {
                    Text("SIGN UP")
                        .foregroundColor(.white)
                        .font(Font.system(size: 20, weight: .bold))
                }
                .frame(width: 254, height: 54)
                .background(
                    Color("BtnSignUp")
                        .blur(radius: 10) // Apply the blur effect
                )
                .cornerRadius(30)
                .padding(.top, 30)
            }
            
            Text("YOU HAVE ACCOUNT?")
                .foregroundColor(.gray  )
                .font(Font.system(size: 20, weight: .bold))
                .padding(.top,70)// Установка жирного шрифта
                
            Button {
                
            } label: {
                Text("Sign in")
                    .foregroundColor(.white)
                    .font(Font.system(size: 20, weight: .bold))
                
            }
            .padding(.top,1)


            Spacer()


        }
        .alert( alertMessage,
                isPresented: $isShowAlert){
            Button{} label: {
                Text("OK")
            }
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("background"))
    }
}

struct RegView_Previews: PreviewProvider {
    static var previews: some View {
        RegView()
    }
}
