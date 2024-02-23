# MQLCore Usage

## 1. Sending HTTP Requests Using MQLBaseService Class

* Import the package and Extend MQLEndpoint class by defining a new class function for your endpoint like this:

        //Import the MQLCore package
        import MQLCore
        
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

        //Import the MQLCore package
        import MQLCore
        
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

## 2. Connectivity
Connectivity class has been written to check whether the device is connected to the internet or not. Usage Example:

    //Import the MQLCore package
    import MQLCore
    
    //Returns true if the device is connected to the internet
    //Returns false if device is not connected to the internet
    let isConnectedToInerenet = Connectivity.isConnectedToInternet 
    
## 3. ScreenSize
You can use this struct to get the screen screen size of the device. Some of the usage example are given below, for more information please explore the struct.

    //Import the MQLCore package
    import MQLCore
    
    // To get screen width
    let screenWidth = ScreenSize.screenWidth
    // To get screen height
    let screenHeight = ScreenSize.screenHeight
    // To get screen top safe area height
    let topSafeAreaHeight = ScreenSize.topSafeAreaHeight
    // To get screen bottom safe area height
    let bottomSafeAreaHeight = ScreenSize.bottomSafeAreaHeight

## 4. MQLValidations
This document provides a detailed overview of the functions available in the `MQLValidations` class. These functions are written in Swift and can be used for various validation purposes in your application.

**4.1. isValidEmailOrPhoneNumber**: This function determines if the provided string is a valid email address or phone number. Usage example:

    //Import the MQLCore package
    import MQLCore
    
    //To check for a valid email or phone number
    let resp1 = MQLValidations.isValidEmailOrPhoneNumber(text: "123cc")
    print(resp1)
    // Output: False
    
    let resp2 = MQLValidations.isValidEmailOrPhoneNumber(text: "9012231200")
    print(resp2)
    // Output: True
    
    let resp3 = MQLValidations.isValidEmailOrPhoneNumber(text: "test@mail.com")
    print(resp3)
    // Output: True


**4.2. isValidEmail**: This function determines if the provided string is a valid email address. Usage example:

    //Import the MQLCore package
    import MQLCore
    
    //To check for a valid email
    let resp1 = MQLValidations.isValidEmail(email: "123.c")
    print(resp1)
    // Output: False
    
    let resp2 = MQLValidations.isValidEmail(email: "test@mail.com")
    print(resp2)
    // Output: True

**4.3. isValidPhoneNumber**: This function determines if the provided string is a valid phone number. Usage example:

    //Import the MQLCore package
    import MQLCore
    
    //To check for a phone number
    let resp1 = MQLValidations.isValidPhoneNumber(text: "911000123")
    print(resp1)
    // Output: False
    
    let resp2 = MQLValidations.isValidPhoneNumber(text: "9012231200")
    print(resp2)
    // Output: True

**4.4. isStrongPassword**: This function determines if the provided string is a strong password or not. Usage example:

    //Import the MQLCore package
    import MQLCore
    
    //To check for a password
    let resp1 = MQLValidations.isStrongPassword(password: "abcde123")
    print(resp1)
    // Output: False
    
    let resp2 = MQLValidations.isStrongPassword(password: "AB123!Can")
    print(resp2)
    // Output: True


**4.5. isPasswordMatching**: This function determines if the provided strings match and return `true` or `false`. Usage example:

    //Import the MQLCore package
    import MQLCore
    
    //To check for valid matching passwords
    let resp1 = MQLValidations.isPasswordMatching(password: "AB123!Can", confirmPassword: "AB1!Can2")
    print(resp1)
    // Output: False
    
    let resp2 = MQLValidations.isPasswordMatching(password: "AB123!Can", confirmPassword: "AB123!Can")
    // Output: True

**4.6. isValidNumericInput**: This function determines if the provided string is numeric or not. Usage example:

    //Import the MQLCore package
    import MQLCore
    
    //To check for a valid input
    let resp1 = MQLValidations.isValidNumericInput(input: "123cc")
    print(resp1)
    // Output: False
    
    let resp1 = MQLValidations.isValidNumericInput(input: "123123")
    print(resp1)
    // Output: True


**4.7. isValidURL**: This function determines if the provided string is a valid URL. Usage example:

    //Import the MQLCore package
    import MQLCore
    
    //To check for a valid input
    let resp1 = MQLValidations.isValidURL(url: "g2oogle.com")
    print(resp1)
    // Output: False
    
    let resp1 = MQLValidations.isValidURL(url: "http://google.com")
    print(resp1)
    // Output: True


## 5. MQLDateFormatter
This class contains methods which is required for formatting the date and time in an Application. Here is the list of formatter metods:

**5.1. getFormattedDateString**: This function accepts a `Date` object and a `dateFormatter` and returns the date in the specified format as a string. Usage example:

    //Import the MQLCore package
    import MQLCore
    
    //To check for a valid email
    let dateStr = MQLDateFormatter.getFormattedDateString(date: Date(), dateFormat: "dd-MM-YYYY")
    
    print(dateStr)
    
    // Output:  "13-02-2024"


**5.2. changeDateFormat**: Use this function to convert the input date from one format to another. It requires the `date` as a string, `inputFormat`, and `outputFormat`, returning the date in the desired format. Usage example:

    //Import the MQLCore package
    import MQLCore
    
    //To check for a valid email
    let dateStr = MQLDateFormatter.changeDateFormat(date: "02/12/1990", inputFormat: "dd/MM/YYYY, outputFormat: "YYYY/MM/dd")
    
    print(dateStr)
    
    // Output:  "1990/12/02"

**5.3. getFormattedTime**: This function provides flexibility in formatting time. It accepts the format of type `TimeFormat` (an enum) and `currentTime` as a `Date` object, returning the formatted time in either 12-hour or 24-hour notation.Usage example:

    //Import the MQLCore package
    import MQLCore
    
    //To check for a valid email
    let timeStr = MQLDateFormatter.getFormattedTime(time: Date(), format: TimeFormat.TWELVE_HOUR)
    
    print(dateStr)
    
    // Output:  "1:02 PM"

**5.4. parseDateStringToDate**: This function parses a date string based on the specified input format (`dateFormat`) and returns a `Date` object. Usage example:

    //Import the MQLCore package
    import MQLCore
    
    //To check for a valid email
    let dateStr = MQLDateFormatter.parseDateStringToDate(date: "01/02/1996", dateFormat: "dd/MM/YYYY")
    
    print(dateStr)
    
    // Output: 1995-12-24 00:00:00 +0000


## 6. ScreenSize
This class contains propeties and methods to get screen width, height, top and bottom safe area height, scale width and height as follows:

    //Import the MQLCore package
    import MQLCore
    
    // To get screen width
    let width = ScreenSize.screenWidth
    
    // To get screen height
    let height = ScreenSize.screenHeight
    
    // To get screen height
    let topHeight = ScreenSize.topSafeAreaHeight
    
    // To get screen height
    let bottonHeight = ScreenSize.bottomSafeAreaHeight
    
    // To get scaled width by 25%
    let scaledWidth = ScreenSize.scaleWidth(0.25)
    
    // To get scaled height by 25%
    let scaledHeight = ScreenSize.scaleHeight(0.25)

## 7. SecureUserDefaults
This class contains methods to store data securely to the UserDefaults, fetch and remove data securely from the user defaults, as follows:    

    //Import the MQLCore package
    import MQLCore
    
    // To store value to UserDefaults
    SecureUserDefaults.setValue(YOUR_DATA, forKey: YOUR_KEY)
    
    // To get value from UserDefaults
    SecureUserDefaults.getValue(String.self, forKey: YOUR_KEY)
    
    // To remove value from UserDefaults
    SecureUserDefaults.removeValue(forKey: YOUR_KEY)

## 8. Utilities
This class contains some utility functions which can be used across the app as follows:


**8.1. loadImage**: This function loads an image from a given URL and returns an Image object. Usage Example:

    //Import the MQLCore package
    import MQLCore
    
    guard let url = URL(string: "IMAGE_URL") else {
        return
    }
    // To load image from a URL
    Utilities.loadImage(from: url) { image in
        DispatchQueue.main.async {
            // Set image on your UI
        }
    }

**8.2. openShareSheet**: This function lets you share a content string to other Apps using the share sheet. Usage Example:
    
    //Import the MQLCore package
    import MQLCore
    
    // Sharing a string using share sheet
    Utilities.openShareSheet(activityItem: "Hi there!")


