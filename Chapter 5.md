# Chapter 5

## Strategy Pattern
Strategy patterns are binded to families of objects not necessarily one.
This allows interchangeable uses of the strategy protocol.

What this means is they are able to be used as you wish through implementing the same protocol that could be inherited by other classes.
This allows the same function names to have a different result according to how you plan them.
```swift
e.g) Sequential vs Randomized
```


- This pattern allows objects to be set and switched during runtime
- Object using strategy, strategy protocol, family of strategy objects
- They are similar to delegation, but are MEANT to be switched. whereas delegations are fixed.


- One of the reasons I've experienced with using Strategy pattern is,
we would be able to change the functions without altering the original.
This allows flexible changes across every objects that conforms the following protocol.

Through implementing strategy Pattern, we are able to alter functions as we like and also follow the clean architecture, OCP(Open-Closed Principle).
- What need to be thought of is, implementing the method through directly and through the use of protocol is totally different. Implementing through protocol reduces the "duplicate method issue".

- Strategy patterns will be used for the similar actions?
(how vehicles move, how questions will be presented?)
- 2 types of strategy > Railroad, Road > conforming to Single Strategy.
This enables separate implementation of similar functions but also leave each strategies to be implemented with additional methods.

