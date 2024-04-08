# MobileQuickLaunchKit Documentation

<img alt="feature-image" src="./docs/screenshots/MobileQuickLaunchKit-iOS.jpg" />

## Overview

Introducing MobileQuickLaunchKit, a powerful SwiftUI package designed to elevate your app development experience by seamlessly integrating essential features. It has dependencies with on separate packages: MQLCore and MQLCoreUI. With a focus on enhancing user engagement and customization, MobileQuickLaunchKit offers a robust set of functionalities, including a set of modules.

## Table of contents

1. [Modules](./Modules.md)
2. [Prerequisites](#prerequisites)
3. [Installation](#installation)
4. [Usage](#usage)
5. [Mockoon Setup Instructions](./docs/mockoon_setup.md)
6. [API Setup](./docs/apis_setup.md)
7. [Manual Installation](./docs/manual_installation_setup.md)

### Example Screens

Utilize our pre-built screens to jumpstart your app development:

1. **Authentication**: Simplify user sign-in, sign-up, and password recovery processes.

2. **Settings**: Customize user preferences effortlessly for a personalized experience and account management.

3. **Navigation**: Seamlessly organize app content with tab and drawer views.

**[Explore all available screens](./docs/ScreenShots.md)**

# Prerequisites

There are certain requirements to be followed in order to use it:

- Xcode >= 15.0
- SwiftUI
- iOS >= 14.0

# Installation

As it contains three separate packages MobileQuickLaunchKit, MQLCore and MQLCoreUI. Here MQLCore and MQLCoreUI are the independent packages but the package MobileQuickLaunchKit has dependency on these two independent packages. You can go through the [modules](./Modules.md) section for the detailed documentation and decide which package fits your requirements.

You can find these two independent packages: MQLCore and MQLCoreUI inside the MobileQuickLaunchKit package.

* File > Add Package Dependency
* Add `https://github.com/mindfiredigital/MobileQuickLaunchKit-iOS`
* Select "Up to Next Major" with "0.1.0"
* Register your App on the Firebase console, download GoogleService-Info.plist file and add it to your project target.
* Open your project configuration: click the project name in the left tree view. Select your app from the TARGETS section, then select the Info tab, and expand the URL Types section.
* Click the + button, and add a URL scheme for your reversed client ID. To find this value, open the GoogleService-Info.plist configuration file, and look for the REVERSED_CLIENT_ID key. Copy the value of that key, and paste it into the URL Schemes box on the configuration page. Leave the other fields untouched.
* Now you can expand the package and access the files inside the package.
  
# Usage

## 1. Branding your App with Logo

If you want to add your company logo into the views those are defined inside the package like: Splash Screen and Sign In screen. Add a company logo in your project's assest folder by naming it *_"CompanyLogo"_*. As the name is case sensitive so please add your company logo image into your asset folder with same name. It will automatically pick the image from your main project.

## 2. MQLSignInView

MQLSignInView is a ready-to-use View integrated with all authentication screens like: Login, Sign up, Forget Password etc. You can simply add this view into your App and use the following features: SignIn, Sign up, Forget Password. You can present this view on the top of any View you created. Usage example:
  
  
    import SwiftUI
    import MobileQuickLaunchKit

    struct  YourView: View {
        @State  var  isLoginModalPresented = !MQLAppState.shared.isUserLoggedIn()
        var body: some View {
            NavigationView {
                HomeView()
            }
            .fullScreenCover(isPresented: $isLoginModalPresented) {
                MQLSignInView(isModalPresented: $isLoginModalPresented)
            }
        }
    }
    
### 2.1 Auth Callbacks

For adding extra action after successful sign-in or sign-up you can use the following callbacks - 

```
MQLSignInView(isModalPresented: $isLoginModalPresented,
    didSignIn: {
        //Add your actions here
         debugPrint("Hello sign in")
    },
    didSignUp: {
        //Add your actions here
        debugPrint("Hello sign up")
    }
)
```
  

## 3. MQLSettingsView

MQLSettingsView is a ready-to-use View inbuilt authentication feature. This view contains following features: Edit Profile, Change Password, Privacy, Logout, Help, About Us. Usage example:
```
    import SwiftUI
    import MobileQuickLaunchKit

    struct  YourView: View {
        @State  var  isLoginModalPresented = !MQLAppState.shared.isUserLoggedIn()
        
        var body: some View {
            NavigationView {
                MQLSettingsView(isLoginModalPresented: $isLoginModalPresented)
            }
        }
    }
```
  * You can also use the ChangePassword view and EditProfile view separately by calling the below view structs
      * MQLChangePasswordView()
      * MQLEditProfileView()

## 4. Initializing the App with Package ContentView and Authentication

Here is a guide to intialize your App with MQLContentView and use authentication in your App.

* import MobileQuickLaunchKit and GoogleSignIn in you main App.swift file
* Create a ThemeManager object to pass the current theme as an environment Object
* Initialize you App class and set your MQLAppState values.
* Initialize MQLContentView by providing the main view of your App
```
        import SwiftUI
        import MobileQuickLaunchKit
        import MQLCoreUI
        
        @main
        struct MobileQuickLaunchKitExampleApp: App {
            @StateObject public var themes = ThemeManager() //Object of ThemeManager
            init() {
                //Set the local storage value to the MQLAppState
                MQLAppState.shared.setValues()
            }
            
            var body: some Scene {
                WindowGroup {
                    // Initializing MQLContentView by providing the main view of your App
                    MQLContentView(
                        mainView: MainView()
                        )
                        .environmentObject(themes.current) // This will help us to access the members of current theme
                    }
                }
            }
```
  * Here is an example to create ThemeManager class.

        import SwiftUI
        import MQLCoreUI

        @available(iOS 13.0, *)
        class  ThemeManager: ObservableObject {
            init(){}
            ///  Colors are being initialized from the assets
            
            @Published var current: Theme = Theme(
                colors: MQLColors(
                     primary: Color(YOUR_THEME_COLOR),
                     secondary: Color("YOUR_THEME_COLOR),
                     tertiary: Color(YOUR_THEME_COLOR),
                     buttonTextPrimary: Color(YOUR_THEME_COLOR),
                     buttonTextSecondary: Color(YOUR_THEME_COLOR),
                     placeholderText: Color(YOUR_THEME_COLOR),
                     backGroundPrimary: Color(YOUR_THEME_COLOR),
                     backGroundSecondary:Color(YOUR_THEME_COLOR),
                     error: Color(YOUR_THEME_COLOR),
                     warning: Color(YOUR_THEME_COLOR),
                     success: Color(YOUR_THEME_COLOR),
                     defaultColor: Color("Default"),
                     borderColor: Color("BorderColor")
                   ),
              typography: Typography(
                    h1: Font.custom("Arial-BoldMT", size: 30), //Use for bold headers
                    h2: Font.custom("Arial-BoldMT", size: 24),
                    h3: Font.custom("Arial-BoldMT", size: 18),
                    h4: Font.custom("Arial-BoldMT", size: 15), // Use for button text
                    h5: Font.custom("Arial-BoldMT", size: 12),
                    h6: Font.custom("Arial-BoldMT", size: 10),
                    body1: Font.custom("ArialMT", size: 15), // Use for body text
                    body2: Font.custom("ArialMT", size: 14),
                    body3: Font.custom("ArialMT", size: 16)
                )
            )
        }
  
* Here is an Example how to add Authentication to your App's MainView.swift:
```
        import SwiftUI
        import MobileQuickLaunchKit
        import MQLCoreUI
        
        struct  MainView: View {
            @EnvironmentObject  var  theme : Theme
            @State  private var  selectedTab = 0
            @State public var isLoginModalPresented = !MQLAppState.shared.isUserLoggedIn()
            
            var  body: some  View {
                NavigationView {
                    TabView(selection: $selectedTab) {
                        HomeView()
                            .tabItem {
                                Label("Home", systemImage: "house")
                            }
                            .tag(0)
                            // Defined inside the MobileQuickLaunchKit package
                            MQLSettingsView(isLoginModalPresented: $isLoginModalPresented)
                                .tabItem {
                                    Label("Settings", systemImage: "gearshape")
                                }
                                .tag(1)
                            }
                            .accentColor(theme.colors.primary) // Setting the color fro theme
                            .onAppear {
                            UITabBar.appearance().backgroundColor = UIColor(theme.colors.backGroundPrimary)
                        }
                    }
                    .navigationViewStyle(StackNavigationViewStyle())
                    .navigationBarBackButtonHidden()
                    .fullScreenCover(isPresented: $isLoginModalPresented) {
                    
                        /// Defined inside the MobileQuickLaunchKit package
                        /// Used to Authenticate the user
                        MQLSignInView(isModalPresented: $isLoginModalPresented)
                    }
                    .onChange(of: isLoginModalPresented) {
                        selectedTab = 0
                    }
            }
        }
```
  

* Here is simply a text added in HomeView you can create your own.
```
        import SwiftUI
        import MobileQuickLaunchKit
        import MQLCoreUI
        
        struct  HomeView: View {
        // To get the current theme data
        @EnvironmentObject  var  theme : Theme
        
            var body: some View {
            ZStack {
            // View Background
            theme.colors.backGroundPrimary
                .ignoresSafeArea()
            Text("Welcome")
                .font(theme.typography.h2)
                .foregroundColor(theme.colors.secondary)
             }
         }
        }
```
  

## 5. Configuring App BaseURL and Settings Links

The default baseURL is "http://localhost:3001/api/v1/"  and the Settings Links is "https://www.google.co.in/" being used by the package. You can change this to your URLs when you initialize your app by calling the setConfigValues function as given below and adding a config JSON file in the app. For example:
```
    import SwiftUI
    import MobileQuickLaunchKit
    import MQLCore
    
    @main
    struct MobileQuickLaunchKitExampleApp: App {
    
        init() {
            //Set the json config values to the package value
            MQLAppState.shared.setConfigValues()
        }
    
        var body: some Scene {
            WindowGroup {
                // Initializing MQLContentView by providing the main view of your App
                    MQLContentView(
                        mainView: MainView()
                    )
                }
            }
        }
```
config.json

```
    {
        "baseURL": "your_base_url",
        "privacyURL": "your_privacy_url",
        "helpURL": "your_help_url",
        "aboutUsURL": "your_aboutUs_url",
    }
```
Note: The name of the JSON file should be config.json.
  

## 6. MQLCore

To find the detailed usage documentation for the package click [here](MQLCore/README.md)

  

## 7.  MQLCoreUI

To find the detailed usage documentation for the package click [here](MQLCoreUI/README.md)

  
#

* The sample App contains both kinds of navigation using the Tabbar and using Side Menu. 

* To unveil the full potential and seamless integration of the Package, please explore the MobileQuickLaunchKitExample project.
