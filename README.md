# Musicly #
# Swifty Protocol-Oriented Dependency Injection #
Musicly - iOS App.

![app-preview](https://user-images.githubusercontent.com/27929436/71583233-d1a45b00-2b0d-11ea-9018-1aaf6b453748.png)

    Musicly is an app for searching songs and albums on LastFm endpoints and
    store musics to Realm database.
    End points that are being used: https://www.last.fm/ (http://ws.audioscrobbler.com/)

## Cocoapods ##

    * Using Alamofire (4.8.2)       https://github.com/Alamofire/Alamofire
    * Using Nuke (8.0.1)            https://github.com/kean/Nuke
    * Using SwiftLint (0.34.0)      https://github.com/realm/SwiftLint
    * Using RealmSwift (3.14.0)     https://realm.io/
    * Using XCGLogger (7.0.0)       https://github.com/DaveWoodCom/XCGLogger
    
## Application Design Pattern ##

    - MVC
    - Dependency Injection for Services
    - Storyboardable
    - SegueHandlers
    - Codable

    Inpired by the way of coding by Olivier Voyer and Basem Emara.
    Olivier Voyer: https://linkedin.com/in/oliviervoyer
    Basem Emara: https://linkedin.com/in/basememara
    
## Application GUI ##

    Application UI inspired by:
    https://www.behance.net/gallery/82854189/FMPlay-App

## Structure ##

### Swifty Protocol-Oriented Dependency Injection ###

    * The key to dependency injection is protocols – from there sprouts many variations,
    flavours, and techniques.
    * Battle-tested DI implementation with no outside dependencies or magic. 
    * It combines protocol extension and type erasure to give you a solid, flexible dependency
    injection that works great with unit test and even frameworks.
