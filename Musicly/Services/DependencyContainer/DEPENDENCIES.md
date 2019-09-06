# DEPENDENCIES #

### Swifty Protocol-Oriented Dependency Injection ###

    The key to dependency injection is protocols – from there sprouts many 
    variations, flavours, and techniques.
    Battle-tested DI implementation with no outside dependencies or magic. 
    It combines protocol extension and type erasure to give you a solid, flexible
    dependency injection that works great with unit test and even frameworks.

###  The Dependency Container ###

    The first thing we must do is come up with a container that will 
    house all our dependencies.
    This will be referenced later from consumers to grab dependencies they want.
    This is where the main meat of the dependency injection occurs. 
    The dependency objects implement the protocols so the concrete types are hidden
    from the caller. 
    This way, the dependency types can be swapped out underneath without affecting 
    the rest of the application.
    
### The Dependencies ###

    There are no singleton dependencies in our container because we 
    always want to deal with immutable objects,
    otherwise state management will bite you later. Instead, its a  factory
    serving fresh instances. 
    The dependencies are structs that implement the protocols.

### The Injection ###

    It’s now time to start using our dependency container. 
    We will use a protocol extension to pass in the dependency container so the caller
    can start resolving the dependency types it wants.

    We need a singleton to hold a reference to the dependency container. 
    So although we couldn’t get away from singletons altogether, the dependency container 
    is a factory and still serving immutable instances.

### The Unit Test ###

    Not only does this dependency injection work great for frameworks, but of course works 
    great for unit tests. 
    It can be configured on a global and scoped level too!

    For the global level of your unit tests, you can create a TestDependency that subclasses 
    CoreDependency.

### Conclusion ###

    The combination of a dependency container, a protocol extension to expose it, and immutable
    dependencies give you a pure Swift DI that works well with frameworks and unit tests.
