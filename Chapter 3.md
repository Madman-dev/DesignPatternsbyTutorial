# Chapter 3

## Fundamental Design Patterns
## MVC (Model - View - Controller) pattern

Models hold Application Data. They are struct or class
Views display elements on screen. They are subclasses of UIViews.
Controllers coordinates view and models. They are subclasses of UIViewController.

Controllers access datas directly thus they are allowed to have strong properties (Strong Reference). Whereas models and views cannot not.
Some times views have a weak reference through delegation. TableViews is an example.

