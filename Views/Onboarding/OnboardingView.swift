//
//  Onboarding.swift
//  testev2
//
//  Created by Henrique Pacheco on 10/04/2025.
//

import SwiftUI

struct Onboarding: View {
    

    @ObservedObject var dataModel = OnboardViewModel()
    
    @State var currentPage: Int = OnboardViewModel().currentPage
    
    @AppStorage("firsrLaunch") private var isFirstLaunch: Bool = true
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage.animation()) {
                ForEach(dataModel.Pages.indices, id: \.self) { index in
                    let page = dataModel.Pages[index]
                    OnboardingPage(dataModel: page)
                        .opacity(currentPage == index ? 1 : 0.2)
                        .animation(.easeInOut(duration: 0.4), value: currentPage)
                }
            }
            .ignoresSafeArea()
            .tabViewStyle(.page(indexDisplayMode: .never))
            .onChange(of: currentPage) { oldPage, newPage in
                onAppear(index: newPage)
            }
            
            VStack {
                Button(action: {
                    isFirstLaunch = false
                }) {
                    Text("getstarted".localized)
                        .font(.system(size: 22, weight: .regular, design: .default))
                        .padding(.horizontal, 30)
                        .padding(.vertical, 15)
                        .background(Color.primary)
                        .foregroundColor(colorScheme == .dark ? .black : .white)
                        .cornerRadius(7)
                }
                .opacity(dataModel.isLastPage() ? 1 : 0)
                .offset(y: dataModel.isLastPage() ? 0 : 20)
                .animation(.easeInOut(duration: 0.4), value: dataModel.isLastPage())
            }
            
            PageIndicator(totalPages: dataModel.Pages.count, currentPage: $currentPage)
                .frame(alignment: .bottom)
                .padding(.top, 50)
        }
    }
    
    func onAppear(index: Int) {
        dataModel.onAppear(index: index)
    }
    
}

#Preview {
    Onboarding()
}
