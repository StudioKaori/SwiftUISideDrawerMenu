//
//  ContentView.swift
//  SwiftUISideDrawerMenu
//
//  Created by Kaori Persson on 2023-02-20.
//

import SwiftUI

struct MenuItem: Identifiable {
  let id = UUID()
  let text: String
  let imageName: String
  let handler: () -> Void = {
    print("Tapped item")
  }
}

struct MenuContent: View {
  let items: [MenuItem] = [
    MenuItem(text: "Home", imageName: "house"),
    MenuItem(text: "Settings", imageName: "person.circle"),
    MenuItem(text: "Profile", imageName: "bell"),
    MenuItem(text: "Activity", imageName: "airplane"),
    MenuItem(text: "Flights", imageName: "gear"),
    MenuItem(text: "Share", imageName: "square.and.arrow.up")
  ]
  
  var body: some View {
    ZStack {
      Color(UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1))
      
      VStack(alignment: .leading, spacing: 0) {
        ForEach(items) { item in
          HStack {
            Image(systemName: item.imageName)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .foregroundColor(Color.white)
              .frame(width: 32, height: 32, alignment: .center)
            
            Text(item.text)
              .foregroundColor(Color.white)
              .bold()
              .font(.system(size: 22))
              .multilineTextAlignment(.leading)
            
            Spacer()
          }
          .padding()
          
          Divider()
          
        }
        Spacer()
      }
      .padding(.top, 25)
    }
  }
}

struct SideMenu: View {
  let width: CGFloat
  let menuOpened: Bool
  let toggleMenu: () -> Void
  
  var body: some View {
    ZStack {
      // Dimmed background view
      GeometryReader {_ in
        EmptyView()
      }
      .background(Color.red.opacity(0.15))
      .opacity(self.menuOpened ? 1 : 0)
      //.animation(Animation.easeIn.delay(0.25))
      .onTapGesture {
        withAnimation(Animation.easeIn.delay(0.6)) {
          self.toggleMenu()
        }
      }
      
      // Menu content
      HStack {
        MenuContent()
          .frame(width: width)
          .offset(x: menuOpened ? 0 : -width)
          .animation(Animation.easeIn(duration: 1.0), value: menuOpened)
        
        Spacer()
      }
      
    }
  }
}

struct ContentView: View {
  @State var menuOpened = false
  
  var body: some View {
    ZStack {
      if !menuOpened {
        Button {
          // Open menu
          self.menuOpened.toggle()
        } label: {
          Text("Open menu")
            .bold()
            .foregroundColor(Color.white)
            .frame(width: 200, height: 50, alignment: .center)
            .background(Color(.systemBlue))
        }
      }
      
      SideMenu(width: UIScreen.main.bounds.width/1.6,
               menuOpened: menuOpened,
               toggleMenu: toggleMenu)
    }
    .edgesIgnoringSafeArea(.all)
  }
  
  func toggleMenu() {
    menuOpened.toggle()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      //.preferredColorScheme(.dark)
  }
}
