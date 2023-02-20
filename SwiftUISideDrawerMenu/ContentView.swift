//
//  ContentView.swift
//  SwiftUISideDrawerMenu
//
//  Created by Kaori Persson on 2023-02-20.
//

import SwiftUI

struct MenuItem: Identifiable {
  let id = UUID()
  let label: String
  let iconName: String
  let handler: () -> Void = {
    print("Tapped item")
  }
}

struct MenuContent: View {
  let items: [MenuItem]
  let fontColor: Color
  let fontSize: Font
  let backgroundColor: Color
  let topPadding: CGFloat
  
  var body: some View {
    ZStack {
      backgroundColor
      
      VStack(alignment: .leading, spacing: 0) {
        ForEach(items) { item in
          HStack {
            Image(systemName: item.iconName)
              .font(fontSize)
              .foregroundColor(Color.white)
              
            
            Text(item.label)
              .foregroundColor(fontColor)
              .font(fontSize)
              .multilineTextAlignment(.leading)
            
            Spacer()
          }
          .onTapGesture {
            item.handler()
          }
          .padding()
          
        }
        Spacer()
      }
      .padding(.top, topPadding)
    }
  }
}

struct SideMenu: View {
  let width: CGFloat
  let menuOpened: Bool
  let toggleMenuHandler: () -> Void
  let menuItems: [MenuItem]
  let fontColor: Color
  let fontSize: Font
  let backgroundColor: Color
  let dimmedBgColor: Color
  let menuTopPadding: CGFloat
  
  var body: some View {
    ZStack {
      // Dimmed background view
      GeometryReader {_ in
        EmptyView()
      }
      .background(dimmedBgColor)
      .opacity(self.menuOpened ? 1 : 0)
      //.animation(Animation.easeIn.delay(0.25))
      .onTapGesture {
        withAnimation(Animation.easeIn.delay(0.6)) {
          self.toggleMenuHandler()
        }
      }
      
      // Menu content
      HStack {
        MenuContent(items: menuItems,
                    fontColor: fontColor,
                    fontSize: fontSize,
                    backgroundColor: backgroundColor,
                    topPadding: menuTopPadding)
          .frame(width: width)
          .offset(x: menuOpened ? 0 : -width)
          .animation(Animation.easeInOut(duration: 0.25), value: menuOpened)
        
        Spacer()
      }
      
    }
  }
}

struct ContentView: View {
  @State var menuOpened = false
  
  let menuItems: [MenuItem] = [
    MenuItem(label: "Home", iconName: "house"),
    MenuItem(label: "Settings", iconName: "person.circle"),
    MenuItem(label: "Profile", iconName: "bell"),
    MenuItem(label: "Activity", iconName: "airplane"),
    MenuItem(label: "Flights", iconName: "gear"),
    MenuItem(label: "Share", iconName: "square.and.arrow.up")
  ]
  let menuWidth = UIScreen.main.bounds.width/1.6
  let menuBgColor = Color(UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1))
  let fontColor = Color.white
  let fontSize = Font.body
  let dimmedBgColor = Color.red.opacity(0.15)
  let menuTopPadding: CGFloat = 60
  
  func toggleMenu() {
    menuOpened.toggle()
  }
  
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
      
      SideMenu(width: menuWidth,
               menuOpened: menuOpened,
               toggleMenuHandler: toggleMenu,
               menuItems: menuItems,
               fontColor: fontColor,
               fontSize: fontSize,
               backgroundColor: menuBgColor,
               dimmedBgColor: dimmedBgColor,
               menuTopPadding: menuTopPadding)
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
