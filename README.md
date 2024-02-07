# Introduction to MobileQuickLaunchKit!

Introducing MobileQuickLaunchKit, a powerful SwiftUI package designed to elevate your app development experience by seamlessly integrating essential features. With a focus on enhancing user engagement and customization, MobileQuickLaunchKit offers a robust set of functionalities, including a set of modules.

## Table of contents

1. [Modules](./Modules.md)
2. [Prerequisites](#prerequisites)
3. [Installation](#installation)
4. [Usage](#usage)
5. [Mockoon Setup Instructions](./docs/mockoon_setup.md)
6. [API Setup](./docs/apis_setup.md)

# Prerequisites
There are certain requirements to be followed in order to use it:
- Xcode >= 15.0
- SwiftUI
- iOS >= 14.0

# Installation  
 ## 1. Adding The Package in your Project Target
 * Download the code as zip and extract it.
 * Find the package MobileQuickLaunchKit folder inside the extracted folder.
 * Click on File menu of the Xcode and select "Add Package Dependencies".
 
     <img src="./docs/screenShots/add_package_1.png" >
     
 * On add package window, click on "Add Local", navigate to downoaded project folder and select MobileQuickLaunchKit folder as a package and then click on "Add Package".
     
     <img src="./docs/screenShots/add_package_2.png" >
     
 * Wait for the package to load dependencies, once it loads all the dependencies, again click on "Add Package". Now the package has been added to your project.
      
      <img src="./docs/screenShots/add_package_3.png" >
      
 * Go to build phases, Add MobileQuickLaunchKit in Link Binary With Libraries section. You can ignore this step if it is already added.
 * Register your App on Firbase console, download GoogleService-Info.plist file and add to your project target.
 * Open your project configuration: click the project name in the left tree view. Select your app from the TARGETS section, then select the Info tab, and expand the URL Types section.
* Click the + button, and add a URL scheme for your reversed client ID. To find this value, open the GoogleService-Info.plist configuration file, and look for the REVERSED_CLIENT_ID key. Copy the value of that key, and paste it into the URL Schemes box on the configuration page. Leave the other fields untouched.
 * Now you can expand the package and access the files inside the package.

# Usage  

## 1. Branding your App with Logo
If you want to add your company logo into the views those are defined inside the package like: Splash Screen and Sign In screen. Add a company logo in your project's assest folder by naming it *"CompanyLogo"*. As the name is case sensitive so please add your company logo image into your asset folder with same name. It will automatically pick the image from your main project.

 ## 2. Initializing and Setting Theme
 * Create a Theme object in a to configure the app theme, for example:
 
         let appTheme = Theme(
            colors: MQLColors(
            primary: Color(YOUR_THEME_COLOR),
            secondary: Color("YOUR_THEME_COLOR),
            tertiary: Color(YOUR_THEME_COLOR),
            buttonTextPrimary: Color(YOUR_THEME_COLOR),
            buttonTextSecondary: Color(YOUR_THEME_COLOR),
            placeholderText: Color(YOUR_THEME_COLOR),
            backGroundPrimary: Color(YOUR_THEME_COLOR),
            backGroundSecondary: Color(YOUR_THEME_COLOR),
            error: Color(YOUR_THEME_COLOR),
            warning: Color(YOUR_THEME_COLOR),
            success: Color(YOUR_THEME_COLOR),
            defaultColor: Color("Default"),
            borderColor: Color("BorderColor")
        ),
        typography: Typography(
            h1: Font.custom("Georgia-Bold", size: 30),
            h2: Font.custom("Georgia-Bold", size: 24),
            h3: Font.custom("Georgia-Bold", size: 18),
            h4: Font.custom("Georgia-Bold", size: 14),
            h5: Font.custom("Georgia-Bold", size: 12),
            h6: Font.custom("Georgia-Bold", size: 10),
            body1: Font.custom("Georgia-Regular", size: 15),
            body2: Font.custom("Georgia-Regular", size: 14),
            body3: Font.custom("Georgia-Regular", size: 12)
        )
        ) 
        You can provide the fonts and sizes as per your need.
        
 * Create a ThemeManager class, import the package and initialize it by creating an object of Theme class to manage the theme of your App as it is done in the ExampleApp. For example:

        import SwiftUI
        import MobileQuickLaunchKit

        @available(iOS 13.0, *)
        class  ThemeManager: ObservableObject {
            init**(){}
            @Published **var** current: Theme = .theme2
        }
 * Now create an object for ThemeManager class in your @main App.swift file and and pass the current theme object as an environment object to share across the App. For example:

        import SwiftUI
        import MobileQuickLaunchKit

        @main
        struct MobileQuickLaunchKitExampleApp: App {
            @StateObject public var themes = ThemeManager() //Object of ThemeManager
            
            var body: some Scene {
                WindowGroup {
                    ContentView()
                        .environmentObject(themes.current) // This will help us to access the members of current theme
                }
            }
        }
 
 * Now You can access the the object in any views of your App and you can assign colors and typograpy as per your need. For example:
 
         import SwiftUI
         import MobileQuickLaunchKit
         struct  CustomButton: View {
            @EnvironmentObject  var  theme : Theme

            var title: String
            var  action: () -> Void  // Closure for the action to be performed when the button is tapped

            var body: some View {

                Button(action: {
                    action() // Execute the provided action
                }) {
                    Text(NSLocalizedString(title, bundle: .module, comment: "")) // Use the provided title
                        .foregroundColor(theme.colors.buttonTextSecondary) // Accessing theme coloe
                        .font(theme.typography.body1) // Accessing theme typography
                }
                .padding(.top, 10)
                .padding(.leading, 5)
            }
        }

## 3. MQLSignInView
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
        

## 4. MQLSettingsView
MQLSettingsView is a ready-to-use View inbuilt authentication feature. This view contains following features: Edit Profile, Change Password, Privacy, Logout, Help, About Us. Usage example: 

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
 
 ## 5. Initializing the App with Package ContentView and Authentication
 Here is a guide to intialize your App with MQLContentView and use authentication in your App.
 * import MobileQuickLaunchKit and GoogleSignIn in you main App.swift file
 * Create a ThemeManager object to pass the current theme as an environment Object
 * Initialize you App class and set your MQLAppState values. 
 * Initialize MQLContentView by providing the main view of your App

        import SwiftUI
        import MobileQuickLaunchKit

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

* Here is an Example how to add Authentication to your App's MainView.swift:

        import SwiftUI
        import MobileQuickLaunchKit

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
                    .navigationBarBackButtonHidden()
                    .fullScreenCover(isPresented: $isLoginModalPresented) {
                        /// Defined inside the MobileQuickLaunchKit package
                        /// Used to Authenticate the user
                        MQLSignInView(isModalPresented: $isLoginModalPresented)
                    }
                }
            }

* Here is simply a text added in HomeView you can create your own.

        import SwiftUI
        import MobileQuickLaunchKit

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

## 6. Configuring App BaseURL 
Default baseURL is "http://localhost:3001/api/v1/" being used by the package. You can change this to your base URL at the time you initialize your app. For example:

        import SwiftUI
        import MobileQuickLaunchKit

        @main
        struct MobileQuickLaunchKitExampleApp: App {
            init() {
                //Set your base URL
                MQLConstants.baseURL = "YOUR_BASE_URL"
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

## 7. Sending HTTP Requests Using MQLBaseService Class

* Import the package and Extend MQLEndpoint class by defining a new class function for your endpoint like this:

        import MobileQuickLaunchKit
        extension MQLEndpoint {
            // Sending HTTP GET request without headers
            class func getData() -> MQLEndpoint {
                return MQLEndpoint(path: "YOUR_API_PATH", method: .get)
            }
            
            // Sending HTTP GET request with headers
            class func getData(header: [String: String]) -> MQLEndpoint {
                return MQLEndpoint(path: "YOUR_API_PATH", method: .get, header: header )
            }
            
            // Sending HTTP POST request with headers
            class func postData(data: [String: String], header: [String: String]) -> MQLEndpoint {
                return MQLEndpoint(path: "YOUR_API_PATH", method: .post, body: data, header: header)
            }
            
            // Sending HTTP PUT request with headers
            class func putData(data: [String: String], header: [String: String]) -> MQLEndpoint {
                return MQLEndpoint(path: "YOUR_API_PATH", method: .put, body: data, header: header )
            }
        }

    **Note:** The parameters body and header are optional in MQLEndpoint initializer. The default value for these are **nil**, if you don't pass any value these data will not be sent to your request.
    

* Create a Codable response model as per your API response to decode your response data. For example:

        struct DataResponse: Codable {
            let status: String
            let message: String
            let data: String?
            let error: String?
        }
    
* Now, you have everything set-up to send the HTTP request. Simply add a HTTP request in your App using MQLBaseService class. For example:

        import MobileQuickLaunchKit
        
        // Sending HTTP request to the server and receiving the response decoded in your provided response model.
        // MQLEndpoint.getData(): To get all details about the Endpoint like: path, url, method, body, header etc.
        // DataResponse: Used to convert JSON response into a model object/variable
        MQLBaseService.shared.request(endpoint: MQLEndpoint.getData()) { (result: Result<DataResponse, APIError>)  in
            switch result {
                case .success(let response):
                    /// Your code to handle the response
                case .failure(let error):
                    /// Your code to handle the failure case
            }
        }

## 8. Utilities Structs and Classes
### 1. Connectivity
Connectivity class has been written to check whether the device is connected to the internet or not. Usage example:

    import  MobileQuickLaunchKit
    
    //Returns true if the device is connected to the internet
    //Returns false if device is not connected to the internet
    let isConnectedToInerenet = Connectivity.isConnectedToInternet 
    
### 2. ScreenSize
You can use this struct to get the screen screen size of the device. Some of the usage example are given below, for more information please explore the struct.

    import  MobileQuickLaunchKit
    
    // To get screen width
    let screenWidth = ScreenSize.screenWidth
    // To get screen height
    let screenHeight = ScreenSize.screenHeight
    // To get screen top safe area height
    let topSafeAreaHeight = ScreenSize.topSafeAreaHeight
    // To get screen bottom safe area height
    let bottomSafeAreaHeight = ScreenSize.bottomSafeAreaHeight

### 3. Utilities
This class contains various functions for validating mobile numbers, emails etc. It also contains functions to load image from url, and opening the share sheet. 

### 4. Custom Views
This package also contains some customized views. You can use these as per your requirements. List of the custom views as follows:

#### 4.1 BackButton 
A simple back button uses theme's tertiary color as its icon color
    
    BackButton(action: {
        // Your action
    })

#### 4.2 themeButton() 
A modifire for your button which sets theme's primary color as background and button text primary color as text color. Default height for the button is 50 which you can override.
    
    Button {
        // Action
    } label: {
        Text("Button", bundle: .module)
            .themeButton() // Button Modifier
    }

#### 4.3 ThemeTextField
You can use this text field in your App to match your theme.

    // Declare these state variables
    @State var emailText: String = ""
    @State var emailError: String = ""

    // Add modifier to your view
    ThemeTextField(placeholderText: "email", iconName: Icon.email, keyBoardType: .emailAddress, text: $emailText, error: $emailError)

#### 4.4 Loader as a View Modifier
A view modifier, you can use it wherever you want to show a loader in your App. Usage example:

    // Declare a state variable to show/hide the loader
    @State var isLoading: Bool = false
    
    // Add modifier to your view
    YourView().loader(isLoading: $isLoading)
##
* The sample App contains both kind of navigation using Tabbar and using Side Menu. You can choose anyone. For more information about the navigation please explore our sample project.
* To unveil the full potential and seamless integration of the Package, please explore the MobileQuickLaunchKitExample project.

