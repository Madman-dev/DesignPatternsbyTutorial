# Chapter 4

## Delegation Pattern
Enables object to use helpers to provide data / perform task.
When using Delegation, there are three parts that are used.

1. Object that is looking for help
2. Delegate protocol > functions needed help with
3. Delegate > that takes the contract

- As ONLY the protocol needs to be conformed, no need to rely on a concrete object. Making it more flexible.
- It is common to see objects conform to same objects, but it could be set separately.

