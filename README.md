# BoomsetEvent
This is a sample event project that assigned to me from the Boomset Inc.

I have created this sample project using with VIPER architectural design pattern, you can see a best practice of the VIPER, Protocol Oriented Programming and Unit Testing on this project.

There are three modules which are Login, Events and Guests in this project. The Login module is responsible for the authenticate the user with sending the credentilas to the api service. The Events module is responsible for representing a list of event getting from the api service, and it has searching capability on the events. The Guests module is responsible for representing guest list of the selected event, it has searching and paging capabilities.

You can see a bunch of test cases for the Login Module for representing implementation of the unit testing with concrete cases in the Login screen.

# Dependencies

The dependencies will be managed by CocoaPods. In order to install CocoaPods

> sudo gem install cocoapods

After installing CocoaPods, install dependencies with the following command

> pod install

Use **BoomsetEvent.xcworkspace** for this project from now on.

# Guides

* [Swift Style Guide](https://github.com/raywenderlich/swift-style-guide)

* [Swift Commenting Guide](https://gist.github.com/hhtopcu/3237e1421eb57ddb135a#file-commentsmarkdownstyle-swift)
