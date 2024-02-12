# MQLCoreUI Usage Examples

## 1. Initializing and Setting Theme
 * Create a Theme object in a to configure the app theme, for example:
 
         //Import the package
         import MQLCoreUI
     
         // Let's create a theme Object
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
        import MQLCoreUI

        @available(iOS 13.0, *)
        class  ThemeManager: ObservableObject {
            init**(){}
            @Published **var** current: Theme = .theme2
        }
 * Now create an object for ThemeManager class in your @main App.swift file and and pass the current theme object as an environment object to share across the App. For example:

        import SwiftUI
        import MQLCoreUI

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
         import MQLCoreUI
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



## 2.  Custom Views
You can use the custom and ready-to-use reusable views across your app. The list of custom reusable views are mentioned below:

**2.1. BackButton**: It can be used to add a back button with chevron left icon. Usage Example:
    
    //Import the MQLCoreUI package
    import MQLCoreUI
    
    BackButton(action: {
        // Your action
    })


**2.2. BackButtonWithTitle**: It can b shared across the App to show a back button with a navigation title. Usage Example:
    
    //Import the MQLCoreUI package
    import MQLCoreUI
    
    BackButtonWithTitle(
        title: "Title",
        action: {
            // Your action
        }
    )

**2.3. CustomSocialButton**: If you want to create a social button in your app you can simply use this view. Usage Example:
    
    //Import the MQLCoreUI package
    import MQLCoreUI
    
    CustomSocialButton(
        image: Image("image_name"),
        action: {
            // Your action
        }
    )

**2.4. ThemeTextField**: It can be shared across the App to add a TextField on a view. Usage Example:

    //Import the MQLCoreUI package
    import MQLCoreUI
    
    // Declare these state variables
    @State var emailText: String = ""
    @State var emailError: String = ""

    // Add modifier to your view
    ThemeTextField(placeholderText: "email", iconName: Icon.email, keyBoardType: .emailAddress, text: $emailText, error: $emailError)


## 3. View Modifiers 
You can use these view modifiers across your app. The list of view modifiers are mentioned below:

**3.1. themeButtonModifier**: You can use this if you want to add  a theme button on a view inside your App. Usage Example:
    
    Button {
        // Action
    } label: {
        Text("Button", bundle: .module)
            .themeButtonModifier() // Button Modifier
    }

**3.2 loader**:  You can use this view modifier if you want to show a loader on a view in your App. Usage Example:

    //Import the MQLCoreUI package
    import MQLCoreUI
    
    // Declare a state variable to show/hide the loader
    @State var isLoading: Bool = false
    
    // Add modifier to your view
    YourView().loader(isLoading: $isLoading)

**3.3. textFieldModifier**: You can use this view modifier to modify your TextField. Usage Example:

    //Import the MQLCoreUI package
    import MQLCoreUI
    
    // Declare state variables
    @State var text: String = ""
    @State var error: String = ""
    
    // Add modifier to your view
    TextField().textFieldModifier(icon: Image("icon_name"), text: $text, error: $error)

**3.4. SecureTextField**: It can be shared across the App to add a Password TextField on a view. Usage Example:

    //Import the MQLCoreUI package
    import MQLCoreUI
    
    // Declare state variables
    @State var text: String = ""
    @State var error: String = ""
    @State var isSecurePassword: Bool = False
    
    SecureTextField(icon: Image("icon_name"), text: $text, isSecure: $isSecurePassword, placeholderName: "Placeholder" error: $error)





