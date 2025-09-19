import SwiftUI

struct CMLaunchView: View {
    
    @State private var progress: CGFloat = 0.0
    @State private var isActive = false
    @AppStorage("firstOpenApp") var firstOpenApp = true
    @AppStorage("stringURL") var stringURL = ""
    
    @State private var showPrivacy = false
    @State private var showHome = false

    var body: some View {
        NavigationView {
            VStack {
                
                Spacer()
                
                loader
                
                // - Transition
                NavigationLink(
                    destination: PrivacyView(),
                    isActive: $showPrivacy
                ) {
                    EmptyView()
                }
                
                NavigationLink(
                    destination: CMHomeWebView(),
                    isActive: $showHome
                ) {
                    EmptyView()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
            .background(
                ZStack {
                    Color.white
                    Image(.loadingBackground)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .hideNavigationBar()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                if !firstOpenApp {
                    showHome = true
                } else {
                    showPrivacy = true
                }
            }
        }
    }
}

// MARK: - Loader

extension CMLaunchView {
    var loader: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .frame(height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    .blue1,
                                    .blue1
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 3
                        )
                )
            
            RoundedRectangle(cornerRadius: 8)
                .fill(
                    LinearGradient(
                        colors: [
                            .blue1,
                            .blue1
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    .white,
                                    .white
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 2
                        )
                )
                .frame(width: progress * 280, height: 35)
                .animation(.linear(duration: 3), value: progress)
            
            HStack {
                Text("LOADING...")
                    .foregroundStyle(.red)
                    .font(.system(size: 16, weight: .bold, design: .default))
                
                Text("\(Int(progress * 100))%")
                    .foregroundStyle(.red)
                    .font(.system(size: 16, weight: .bold, design: .default))
            }
            .padding(.horizontal, 12)
        }
        .frame(width: 280)
    }
}

#Preview {
    CMLaunchView()
}
