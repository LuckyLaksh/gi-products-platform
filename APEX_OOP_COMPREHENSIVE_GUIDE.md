# Comprehensive Apex OOP Concepts, DSA, and Design Patterns Guide

## Overview

This project provides a comprehensive, real-world demonstration of all key Object-Oriented Programming (OOP) concepts in Salesforce Apex, along with essential Data Structures and Algorithms (DSA) and Design Patterns. The code is structured around a **Library Management System** that serves as a practical learning resource.

## Table of Contents

1. [OOP Concepts](#oop-concepts)
   - [Encapsulation](#1-encapsulation)
   - [Inheritance](#2-inheritance)
   - [Polymorphism](#3-polymorphism)
   - [Abstraction](#4-abstraction)
2. [Data Structures and Algorithms](#data-structures-and-algorithms)
3. [Design Patterns](#design-patterns)
4. [Exception Handling](#exception-handling)
5. [Project Structure](#project-structure)
6. [How to Use](#how-to-use)
7. [Key Classes Reference](#key-classes-reference)

---

## OOP Concepts

### 1. Encapsulation

**Definition**: Bundling data (fields) and methods that operate on that data within a single unit (class), while controlling access through access modifiers.

**Key Features Demonstrated**:
- Private fields with public getters/setters
- Data validation in setters
- Controlled access to internal state
- Information hiding

**Example Classes**:
- `LibraryItem.cls` - Base class demonstrating encapsulation with private fields and public accessors

**Key Code Example**:
```apex
// Private field - data hiding
private String title;

// Public getter - controlled access
public String getTitle() {
    return this.title;
}

// Public setter with validation - encapsulation benefit
public void setTitle(String title) {
    if (String.isNotBlank(title)) {
        this.title = title;
    } else {
        throw new IllegalArgumentException('Title cannot be blank');
    }
}
```

---

### 2. Inheritance

**Definition**: A mechanism where a child class inherits properties and methods from a parent class, establishing an "is-a" relationship.

**Key Features Demonstrated**:
- Class extension using `extends` keyword
- Constructor chaining with `super()`
- Method overriding with `override` keyword
- Access to parent class members
- Code reuse

**Example Classes**:
- `LibraryItem.cls` - Parent class
- `Book.cls` - Child class extending LibraryItem
- `Magazine.cls` - Another child class extending LibraryItem

**Key Code Example**:
```apex
// Child class extends parent
public class Book extends LibraryItem {
    // Additional fields specific to Book
    private Integer numberOfPages;
    
    // Constructor chaining
    public Book(String title, String author, Integer year) {
        super(title, author, year); // Call parent constructor
    }
    
    // Method overriding
    public override String getItemInfo() {
        String baseInfo = super.getItemInfo(); // Call parent method
        return baseInfo + ', Pages: ' + this.numberOfPages;
    }
}
```

---

### 3. Polymorphism

**Definition**: "Many forms" - the ability of objects of different types to be accessed through the same interface, with different implementations.

**Two Types Demonstrated**:

#### A. Compile-time Polymorphism (Method Overloading)
- Same method name, different parameters
- Determined at compile time

**Example Class**: `PolymorphismExample.cls`

**Key Code Example**:
```apex
// Method overloading - same name, different parameters
public List<Book> searchBooks(String title) { }
public List<Book> searchBooks(String title, String author) { }
public List<Book> searchBooks(String title, String author, String category) { }
```

#### B. Runtime Polymorphism (Method Overriding)
- Same method signature, different implementations in inheritance hierarchy
- Determined at runtime based on actual object type

**Key Code Example**:
```apex
// Runtime polymorphism
LibraryItem item1 = new Book(...);
LibraryItem item2 = new Magazine(...);

// Same method call, different implementations
item1.getItemInfo(); // Calls Book.getItemInfo()
item2.getItemInfo(); // Calls Magazine.getItemInfo()
```

---

### 4. Abstraction

**Definition**: Hiding complex implementation details and showing only essential features.

**Two Mechanisms Demonstrated**:

#### A. Interfaces
- Define contracts that implementing classes must follow
- All methods are implicitly public and abstract
- Support multiple inheritance (a class can implement multiple interfaces)

**Example Interfaces**:
- `ILoanable.cls` - Defines loanable behavior
- `IPrintable.cls` - Defines printable behavior

**Key Code Example**:
```apex
// Interface definition
public interface ILoanable {
    Boolean loan(String borrowerId, Date loanDate);
    Boolean returnLoan(Date returnDate);
    Boolean isOnLoan();
}

// Class implementing interface
public class LoanableBook extends Book implements ILoanable, IPrintable {
    // Must implement all interface methods
    public Boolean loan(String borrowerId, Date loanDate) {
        // Implementation
    }
}
```

#### B. Abstract Classes
- Cannot be instantiated directly
- Can contain both abstract methods (must be implemented) and concrete methods
- Can have instance variables and constructors

**Example Classes**:
- `AbstractLibraryService.cls` - Abstract base class
- `BookLoanService.cls` - Concrete implementation

**Key Code Example**:
```apex
// Abstract class
public abstract class AbstractLibraryService {
    // Concrete method
    public String getServiceName() {
        return this.serviceName;
    }
    
    // Abstract method - must be implemented by subclass
    public abstract Boolean validate();
    public abstract void execute();
}

// Concrete implementation
public class BookLoanService extends AbstractLibraryService {
    public override Boolean validate() {
        // Implementation required
    }
    
    public override void execute() {
        // Implementation required
    }
}
```

---

## Data Structures and Algorithms

### Data Structures

#### 1. Lists (Dynamic Arrays)
- Ordered, indexed collections
- Can contain duplicates
- Dynamic sizing

**Key Operations**:
- `add()`, `addAll()`, `remove()`, `get()`, `size()`, `isEmpty()`, `contains()`

**Example Class**: `DSAExamples.cls`

#### 2. Sets
- Unordered collections of unique elements
- No duplicates allowed
- Fast lookup

**Key Operations**:
- `add()`, `addAll()`, `remove()`, `contains()`, `retainAll()` (intersection)

**Common Use Cases**:
- Removing duplicates
- Finding common elements
- Membership testing

#### 3. Maps (Key-Value Pairs)
- Unordered collection of key-value pairs
- Keys must be unique
- Fast key-based lookup

**Key Operations**:
- `put()`, `get()`, `containsKey()`, `containsValue()`, `keySet()`, `values()`

**Common Use Cases**:
- Grouping data
- Counting frequencies
- Caching/lookup tables

### Algorithms

#### 1. Sorting Algorithms

**Bubble Sort** (Educational):
- Time Complexity: O(n²)
- Simple but inefficient for large datasets

**Quick Sort** (Efficient):
- Time Complexity: O(n log n) average case
- More efficient for large datasets

**Example Methods**:
- `sortBooksByTitle()` - Bubble sort implementation
- `quickSortByPrice()` - Quick sort implementation

#### 2. Searching Algorithms

**Linear Search**:
- Time Complexity: O(n)
- Works on unsorted data
- Simple implementation

**Binary Search**:
- Time Complexity: O(log n)
- Requires sorted data
- Much faster for large datasets

**Example Methods**:
- `linearSearchByTitle()` - Linear search
- `binarySearchByPrice()` - Binary search

#### 3. Common DSA Patterns

**Grouping Pattern**:
```apex
Map<String, List<Book>> groupBooksByAuthor(List<Book> books)
```

**Counting Pattern**:
```apex
Map<String, Integer> countBooksByCategory(List<Book> books)
```

**Finding Max/Min**:
```apex
Book findMaxPriceBook(List<Book> books)
```

**Deduplication**:
```apex
List<Book> removeDuplicates(List<Book> books)
```

**Merging Sorted Lists**:
```apex
List<Book> mergeSortedLists(List<Book> list1, List<Book> list2)
```

---

## Design Patterns

### 1. Singleton Pattern

**Purpose**: Ensure a class has only one instance and provide global access.

**Use Cases**:
- Configuration management
- Logging systems
- Cache management
- Database connections

**Example Class**: `LibraryManagerSingleton.cls`

**Key Features**:
- Private constructor
- Private static instance
- Public static getInstance() method
- Lazy initialization

**Usage**:
```apex
LibraryManagerSingleton manager = LibraryManagerSingleton.getInstance();
manager.registerItem(book);
```

---

### 2. Factory Pattern

**Purpose**: Create objects without specifying the exact class, encapsulating object creation logic.

**Benefits**:
- Encapsulates creation logic
- Provides flexibility to add new types
- Centralizes creation logic
- Follows Open/Closed Principle

**Example Class**: `LibraryItemFactory.cls`

**Usage**:
```apex
LibraryItem book = LibraryItemFactory.createItem('Book', 'Title', 'Author', 2020);
LoanableBook loanable = LibraryItemFactory.createLoanableBook('Title', 'Author', 2020, 400, 'ISBN', 14);
```

---

### 3. Strategy Pattern

**Purpose**: Define a family of algorithms, encapsulate each one, and make them interchangeable at runtime.

**Components**:
- **Strategy Interface**: `PricingStrategy.cls`
- **Concrete Strategies**: 
  - `StandardPricingStrategy.cls`
  - `DiscountPricingStrategy.cls`
  - `AgeBasedPricingStrategy.cls`
- **Context**: `PriceCalculator.cls`

**Benefits**:
- Runtime algorithm selection
- Easy to add new strategies
- Eliminates conditional statements

**Usage**:
```apex
PricingStrategy strategy = new DiscountPricingStrategy(20); // 20% discount
PriceCalculator calculator = new PriceCalculator(strategy);
Decimal price = calculator.calculate(basePrice, item);

// Change strategy at runtime
calculator.setStrategy(new AgeBasedPricingStrategy(0.05));
Decimal newPrice = calculator.calculate(basePrice, item);
```

---

### 4. Observer Pattern

**Purpose**: Define a one-to-many dependency between objects. When one object changes state, all dependents are notified.

**Components**:
- **Observer Interface**: `ILibraryObserver.cls`
- **Subject**: `LibrarySubject.cls`
- **Concrete Observer**: `LibraryLoggerObserver.cls`

**Benefits**:
- Loose coupling
- Event-driven architecture
- Easy to add/remove observers

**Usage**:
```apex
LibrarySubject subject = new LibrarySubject();
ILibraryObserver observer = new LibraryLoggerObserver('Logger');
subject.attach(observer);

// When event occurs
subject.notifyObservers('ITEM_ADDED', item, eventData);
```

---

## Exception Handling

### Custom Exceptions

**Example Class**: `LibraryException.cls`

**Features**:
- Extends Exception class
- Custom error codes
- Contextual information
- Formatted error messages

**Usage**:
```apex
throw new LibraryException('Item not found', 'ERR_404', itemId);
```

### Exception Handling Patterns

**Example Class**: `ExceptionHandlingExample.cls`

**Patterns Demonstrated**:
- Try-Catch blocks
- Try-Catch-Finally blocks
- Multiple catch blocks
- Exception propagation
- Custom exception handling
- Safe method execution

**Best Practices**:
- Always catch specific exceptions first
- Use finally for cleanup code
- Don't catch exceptions you can't handle
- Provide meaningful error messages
- Log exceptions appropriately

---

## Project Structure

```
force-app/main/default/classes/
├── LibraryItem.cls                    # Base class - Encapsulation
├── Book.cls                           # Inheritance example
├── Magazine.cls                       # Inheritance example
├── LoanableBook.cls                   # Multiple inheritance (interfaces)
├── ILoanable.cls                      # Interface - Abstraction
├── IPrintable.cls                     # Interface - Abstraction
├── AbstractLibraryService.cls         # Abstract class - Abstraction
├── BookLoanService.cls                # Abstract class implementation
├── PolymorphismExample.cls            # Method overloading
├── DSAExamples.cls                    # Data Structures & Algorithms
├── LibraryManagerSingleton.cls        # Singleton Pattern
├── LibraryItemFactory.cls             # Factory Pattern
├── PricingStrategy.cls                # Strategy Pattern interface
├── StandardPricingStrategy.cls        # Strategy implementation
├── DiscountPricingStrategy.cls        # Strategy implementation
├── AgeBasedPricingStrategy.cls         # Strategy implementation
├── PriceCalculator.cls               # Strategy Pattern context
├── ILibraryObserver.cls               # Observer Pattern interface
├── LibrarySubject.cls                 # Observer Pattern subject
├── LibraryLoggerObserver.cls          # Observer Pattern observer
├── LibraryException.cls               # Custom exception
├── ExceptionHandlingExample.cls       # Exception handling patterns
└── OOPConceptsDemo.cls                # Comprehensive demo class
```

---

## How to Use

### 1. Deploy to Salesforce

```bash
# Using Salesforce CLI
sf project deploy start --source-dir force-app/main/default/classes
```

### 2. Run Demo Methods

Open **Developer Console** or **VS Code** and execute:

```apex
// Comprehensive demonstration of all concepts
OOPConceptsDemo.demonstrateAllConcepts();

// Individual concept demonstrations
OOPConceptsDemo.demonstrateEncapsulation();
OOPConceptsDemo.demonstrateInheritance();
OOPConceptsDemo.demonstratePolymorphism();
OOPConceptsDemo.demonstrateAbstraction();
OOPConceptsDemo.demonstrateDSA();
OOPConceptsDemo.demonstrateDesignPatterns();
OOPConceptsDemo.demonstrateExceptionHandling();

// Real-world scenario
OOPConceptsDemo.realWorldScenario();
```

### 3. Study Individual Classes

Each class is heavily commented with explanations. Read through:
1. Class-level comments explaining the concept
2. Method-level comments explaining functionality
3. Inline comments explaining implementation details

---

## Key Classes Reference

### Core OOP Classes

| Class | Purpose | Key Concepts |
|-------|---------|--------------|
| `LibraryItem` | Base class for all library items | Encapsulation, Data Hiding |
| `Book` | Book-specific implementation | Inheritance, Method Overriding |
| `Magazine` | Magazine-specific implementation | Inheritance, Polymorphism |
| `LoanableBook` | Book with loan functionality | Multiple Inheritance (Interfaces) |

### Abstraction Classes

| Class | Purpose | Key Concepts |
|-------|---------|--------------|
| `ILoanable` | Interface for loanable items | Interface, Contract |
| `IPrintable` | Interface for printable items | Interface, Multiple Inheritance |
| `AbstractLibraryService` | Abstract service base class | Abstract Class, Template Method |

### Design Pattern Classes

| Class | Purpose | Pattern |
|-------|---------|---------|
| `LibraryManagerSingleton` | Single instance manager | Singleton |
| `LibraryItemFactory` | Object creation | Factory |
| `PricingStrategy` (interface) | Pricing algorithm contract | Strategy |
| `PriceCalculator` | Pricing context | Strategy |
| `LibrarySubject` | Event notification | Observer |
| `LibraryLoggerObserver` | Event logging | Observer |

### Utility Classes

| Class | Purpose |
|-------|---------|
| `DSAExamples` | Data Structures & Algorithms examples |
| `PolymorphismExample` | Method overloading examples |
| `ExceptionHandlingExample` | Exception handling patterns |
| `OOPConceptsDemo` | Comprehensive demonstration class |

---

## Best Practices Demonstrated

1. **Encapsulation**: Always use private fields with public getters/setters
2. **Validation**: Validate input in setters and constructors
3. **Documentation**: Comprehensive comments explaining concepts
4. **Error Handling**: Proper exception handling with custom exceptions
5. **Design Patterns**: Use appropriate patterns for common problems
6. **Code Reuse**: Leverage inheritance and composition
7. **Abstraction**: Use interfaces and abstract classes appropriately
8. **Naming Conventions**: Clear, descriptive names following Apex conventions

---

## Learning Path

### Beginner Level
1. Start with `LibraryItem.cls` - Understand encapsulation
2. Study `Book.cls` - Understand inheritance
3. Review `PolymorphismExample.cls` - Understand method overloading

### Intermediate Level
1. Study interfaces: `ILoanable.cls`, `IPrintable.cls`
2. Understand abstract classes: `AbstractLibraryService.cls`
3. Learn DSA basics: `DSAExamples.cls` (Lists, Sets, Maps)

### Advanced Level
1. Master design patterns: Singleton, Factory, Strategy, Observer
2. Advanced DSA: Sorting and searching algorithms
3. Exception handling: Custom exceptions and error management
4. Real-world integration: `OOPConceptsDemo.realWorldScenario()`

---

## Additional Resources

- [Salesforce Apex Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/)
- [Design Patterns: Elements of Reusable Object-Oriented Software](https://en.wikipedia.org/wiki/Design_Patterns)
- [Apex Best Practices](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_best_practices.htm)

---

## Notes

- All code includes comprehensive comments explaining each concept
- Code follows Salesforce Apex best practices
- Examples are production-ready patterns (with appropriate error handling)
- This project serves as both a learning resource and reference guide

---

## Author

This comprehensive guide was created to demonstrate all key OOP concepts, DSA, and Design Patterns in Salesforce Apex.

**Last Updated**: 2024

---

## License

This project is for educational purposes.

