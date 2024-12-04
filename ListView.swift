import SwiftUI
import Firebase
import FirebaseAuth

struct ListView: View {
    @Binding var userIsLoggedIn: Bool // Binding to manage user login state
    
    var body: some View {
        VStack {
            Text("Welcome to the main content!")
                .font(.largeTitle)
                .padding()
            
            Button("Logout") {
                logout()
            }
            .bold()
            .frame(width: 200, height: 40)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(.linearGradient(colors: [.pink, .red], startPoint: .top, endPoint: .bottomTrailing))
            )
            .foregroundColor(.white)
            .padding()
        }
        .background(Color.black)
        .ignoresSafeArea()
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            userIsLoggedIn = false // Update the login state after logout
        } catch let error {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ListView(userIsLoggedIn: .constant(true))
}
