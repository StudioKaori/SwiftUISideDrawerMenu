//
//  ContentView.swift
//  SwiftUISideDrawerMenu
//
//  Created by Kaori Persson on 2023-02-20.
//

import SwiftUI

struct MenuContent: View {
  var body: some View {
    ZStack {
      
    }
  }
}

struct SideMenu: View {
  var body: some View {
    ZStack {
      
    }
  }
}

struct ContentView: View {
  @State var menuOpened = false
  
  var body: some View {
    ZStack {
      Button {
        // Open menu
      } label: {
        Text("Open menu")
          .bold()
          .foregroundColor(Color.white)
          .frame(width: 200, height: 50, alignment: .center)
          .background(Color(.systemBlue))
      }

    }
    .edgesIgnoringSafeArea(.all)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .preferredColorScheme(.dark)
  }
}
