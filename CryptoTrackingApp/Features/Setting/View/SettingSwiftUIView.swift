//
//  SettingSwiftUIView.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 12.04.2024.
//

import SwiftUI

protocol SettingSwiftUIViewProtocol: AnyObject {
    func didTappedSignOutButton()
}

struct SettingSwiftUIView: View {
    @StateObject var settingVM = SettingViewModel()
    @State private var isDark  = false
    weak var delegate: SettingSwiftUIViewProtocol?
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: settingVM.user?.imageUrl ?? "https://firebasestorage.googleapis.com:443/v0/b/cryptotrackingapp-697d7.appspot.com/o/Given8D8D9CA1-CF1C-4069-BC3C-5B3168269DA7?alt=media&token=851c1707-cf71-4820-8a2e-273a3c2fc1b8")) { image in
                image.resizable()
                    .frame(width: 100,height: 100)
                    .clipShape(Circle())
                    .padding()
            } placeholder: {
                ProgressView()
                    .padding()
            }

            Text("\(LocalizableKey.Setting.username.title): \(settingVM.user?.username ?? "")")
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.background)
                .cornerRadius(12)
            Text("\(LocalizableKey.Setting.email.title): \(settingVM.user?.email ?? "")")
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.background)
                .cornerRadius(12)
            Button(action: {
                
            }, label: {
                Text(LocalizableKey.Setting.edit.title)
                    .foregroundStyle(.darklight)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(UIColor.tertiaryLabel))
                    .cornerRadius(12)
            })
            .padding(.vertical,12)
            .padding(.bottom,12)
            Divider()
                .background(Color(UIColor.label))
            HStack {
                Text("\(LocalizableKey.Setting.dark.title)")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.background)
                    .cornerRadius(12)
                    .overlay {
                        Toggle(isOn: $isDark) {
                        }
                        .padding(.trailing,5)
                        .onChange(of: isDark) { _ in
                            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = isDark ? .dark : .light
                        }
                    }
            }
            Text(LocalizableKey.Setting.coinGecko.title)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.background)
                .cornerRadius(12)
            Text(LocalizableKey.Setting.github.title)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.background)
                .cornerRadius(12)
            Button(action: {
                
                delegate?.didTappedSignOutButton()
            }, label: {
                Text(LocalizableKey.Setting.signOut.title)
                    .foregroundStyle(.darklight)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(UIColor.tertiaryLabel))
                    .cornerRadius(12)
            })
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    SettingSwiftUIView()
}
