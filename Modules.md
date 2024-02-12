# Modules

### 1. MQLCore

The Core module includes essential components for setting up the project. It includes:
- **Connectivity**: It can be used to check the network connectivty.
- **MQLBaseService**: It can be used to send HTTP requests to the server.
- **Utility**: The Utility module houses various utility functions that can be shared across different parts of the app. It includes:

|         Class Name         |         Usage         |
|-----------------------|--------------------|
| **MQLValidations** | It can be used to check for valid email, phone number, password, numeric input, url etc. |
| **MQLDateFormatter** | It can be used for converting Date object to string, change format for date time string etc. |
| **ScreenSize** | It can be used to get screen width, height, top safe area height, bottom safe area height. I can also be used to get scaled width and height. |
| **SecureUserDefaults** | It can be used to securely store, remove and fetch values from the UserDefaults. |
| **NavigationUtils** | By using this you can perform navigation options in your app. E.g. Pop to root view, find navigation controller etc. |


### 2. MQLCoreUI
CoreUI contains theming data, reusable views, and view modifiers for creating a consistent user interface across the app.

#### 2.1 Theme
Theme is basically a blueprint to set theme data like diferent colors and fonts to be used in the App. It contains following properties:

- **colors-** A variable of a MQLColors struct defined in the package with various properties of Color used to configure and set colors across the App.
- **typography-** An object of Typography class defined in the package with various text styles like: h1, h2 ... h6, body1, body2, body3. These typography can be cofigure in App scope and used across the App.

Here are the MQLColors properties being used inside the package:

|Properties           |Usage                              |
|---------------------|---------------------------------|
|primary              |`Main Theme color`                  |
|secondary            |`Secondary Theme color`          |
|tertiary                |`Back Button`                    |
|buttonTextPrimary    |`Buttons with background color`    |
|buttonTextSecondary  |`Button without background color`|
|placeholderText      |`TextField placeholder`            |
|backGroundPrimary    |`Screen's Main Views`            |
|backGroundSecondary  |`Subviews`                        |
|error                |`On Error Text`                    |
|warning                |`On Warning Text`                |
|success                |`--------`                        |
|defaultColor            |`--------`                        |
|borderColor            |`On Views Borders`                |
You can define these colors as per your color theme in the App.

Here are the Typography properties being used inside the package:

|Properties           |Usage                              |
|---------------------|---------------------------------|
|h1                        |`Heading Texts`                  |
|h2                        |`Sub-Heading Texts`                 |
|h3                       |`--------`                         |
|h4                        |`--------`                         |
|h5                        |`--------`                          |
|h6                        |`--------`                        |
|body1                    |`Body Texts with Larger size`    |
|body2                    |`Body Texts with Medium size`    |
|body3                    |`Body Texts with Small size`     |
You can define these typography as per your need in the App.

#### 2.2 Reusable Views
You can use the custom and ready-to-use reusable views across your app. The list of custom reusable views are mentioned below:

- **BackButton**: It can be used to add a back button with chevron left icon.
- **BackButtonWithTitle**: It can b shared across the App to show a back button with a navigation title.
- **CustomSocialButton**: If you want to create a social button in your app you can simply use this view.
- **ThemeTextField**: It can be shared across the App to add a TextField on a view.
- **SecureTextField**: It can be shared across the App to add a Password TextField on a view.

#### 2.2 View Modifiers
You can use these view modifiers across your app. The list of view modifiers are mentioned below:
- **themeButtonModifier()**: You can use this if you want to add  a theme button on a view inside your App. 
- **loader(isLoading: Binding<Bool>)**:  You can use this view modifier if you want to show a loader on a view in your App. 
- **textFieldModifier(icon: Image?, text: Binding<String>, error: Binding<String?>)**: You can use this view modifier to modify your TextField.
- **SecureTextField**: It can be shared across the App to add a Password TextField on a view.

### 3. MobileQuickLaunchKit
### 3.1 Auth

Auth module encompasses features related to user authentication, including:

- Login
- Signup
- Forgot Password
- OTP Verification
- Set Password

All screens come with API integration for seamless authentication processes.

### 3.2 Settings

Settings module provides basic setting screens with common options such as:

- Edit Profile
- Change Password
- Privacy
- Logout
- Help
- About Us

### 3.3 MQLContentView
MQLContentView is basically used to initilaize the Firebase and Google SignIn SDK, to show the splash screen and load the MainView of your App on top of it.

### 3.4 MQL AppState
 MQL AppState is basically used to store and fetch the user's current authentication status and also storing and fetching the auth token. It can be shared across the App for the same.

### 4. Sample
The Sample project serves as a guide on how to use all the provided modules in your app with examples.
