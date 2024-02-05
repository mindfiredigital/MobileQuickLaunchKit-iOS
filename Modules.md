# Modules

## 1. Core

The Core module includes essential components for setting up the project. It includes:

- **AppUtils**: It contains App utility codes has beed used throughout the package and can be shared across different part of the App.
- **Constants**: It contains all the constants being used by the package.
- **UIUtils**: Contains custom reusable views used by the package and can be shared across the App

## 2. MQLAppState

A singleton class can be shared across the app, helping to check the user authentication state and fetch user details from the local storage stored at the time of login.

## 3. Auth

Auth module encompasses features related to user authentication, including:

- Login
- Signup
- Forgot Password
- OTP Verification
- Set Password

All screens come with API integration for seamless authentication processes.

## 4. Settings

Settings module provides basic setting screens with common options such as:

- Edit Profile
- Change Password
- Privacy
- Logout
- Help
- About Us

## 5. MQLContentView
MQLContentView is basically used to initilaize the Firebase and Google SignIn SDK, to show the splash screen and load the MainView of your App on top of it.

## 6. Theme

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

## 7. ServiceManager

Service Manager provides funtionality to send HTTP requests to the server.

## 8. Sample
The Sample project serves as a guide on how to use all the provided modules in your app with examples.
