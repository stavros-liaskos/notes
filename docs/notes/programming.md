## Programming Parading
A programming paradigm is a a way of seeing the world as a programmer. 2 of the most popular paradigms consist of **declarative** and __imperative__ programming.


## Declarative Programming
**Declarative** programming is a programming paradigm focused on "what we want to achieve" rather than "how to achieve it".
Some of the advantages of Declarative programming are:    
1. Improves **readability** of code  
2. Helps avoid "surprises" aka **no side-effects**  
3. Code modules and functions are easier to **maintain** and **test**      

### Functional Programming
**Functional** programming is also a declarative programming paradigm. It's a style of building software with the use of functions as values that avoid changing the state. These functions are also known as **pure** functions.  
**Immutability** is critical in functional programming. Data **cannot** be altered and are considered immutable in order to avoid side effects.
To achieve this, we need to make **copies** of the original data and perform actions only on the copies.  
In order to make exact copies, sometimes **swallow** copies are not enough as it can happen that other objects are nested in the object we are copying and also we don't want to alter any of the original data structure accidentally. 
In order to ensure identical copies, we need to _clone_ our data, what we call **deep** copy.   
```javascript
// swallow copy
const movies = [{rating: 10, title: "Best movie ever"},{rating: 1, title: "Worst movie ever"}];
const newMovies = [...movies];

// deep copy
const newMovies = JSON.parse(JSON.stringify(movies));
```
  
 

### Pure functions
A function is pure when:  
1. it has **no observable side effects** (it doesn't alter the DOM, no I/O, doesn't alter app's state, no HTTP calls)  
2. has **referential transparency** (it can be replaced by its result without any side-effect)  
  
A pure function is a function that doesn’t modify the environment and its return value depends only on its arguments. 
Since the pure functions _always_ return the same value for the same arguments, they _are_ values and can be used _as_ arguments.
In JS we have seen this pattern for example in `map`, `filter` etc.

### HOF
The fact that functions in JS are values, allows the use of **high-order functions (HOF)**: functions that receive other functions as arguments and/or return new functions.


## Imperative Programming
**Imperative** programming is a programming paradigm where the developers instructs the computer how to achieve a certain task (or which steps, in detail, it needs to take).  
OOP is an **imperative** programming paradigm




## Examples
Return the even numbers of an array
```javascript
const arr = [1,2,3,4,5,6,7,8,9];

// Imperative style
let evenArr = [];
for (let i = 0; i < arr.length; i++) {
    if (arr[i] % 2 === 0) {
        evenArr.push(arr[i]);
    }
}


// Declarative style
arr.filter(n => n%2 === 0)

```
