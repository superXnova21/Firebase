import SwiftUI
import Firebase
import FirebaseAuth

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var userIsLoggedIn = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .foregroundColor(.white)
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .padding(.top, 100)
            
            TextField("Email", text: $email)
                .foregroundColor(.white)
                .textFieldStyle(.plain)
                .placeholder(when: email.isEmpty) {
                    Text("Email")
                        .foregroundColor(.white)
                        .bold()
                }
            Rectangle()
                .frame(width: 350, height: 1)
                .foregroundColor(.white)
            
            SecureField("Password", text: $password)
                .foregroundColor(.white)
                .textFieldStyle(.plain)
                .placeholder(when: password.isEmpty) {
                    Text("Password")
                        .foregroundColor(.white)
                        .bold()
                }
            
            Rectangle()
                .frame(width: 350, height: 1)
                .foregroundColor(.white)
            
            Button {
                login()
            } label: {
                Text("Log in")
                    .bold()
                    .frame(width: 200, height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.linearGradient(colors: [.pink, .red], startPoint: .top, endPoint: .bottomTrailing))
                    )
                    .foregroundColor(.white)
            }
            .padding(.top)
            
            Spacer()
        }
        .frame(width: 350)
        .background(Color.black)
        .onAppear {
            Auth.auth().addStateDidChangeListener { auth, user in
                if user != nil {
                    userIsLoggedIn.toggle()
                }
            }
        }
        .ignoresSafeArea()
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                // Handle successful login
                userIsLoggedIn = true
            }
        }
    }
}

#Preview {
    LoginView()
}
