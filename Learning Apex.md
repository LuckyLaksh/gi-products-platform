# Apex Mastery Programs


# 1. Object-Oriented Programming (OOP)

Encapsulation : Hiding the internal state of an object and only exposing controlled access

Basic class with private variables and public getters/setters (e.g., BankAccount with balance)

Getters retrieve private data, while setters allow controlled updates to that data.
They help enforce data validation, ensuring only appropriate values are assigned.
Direct access to fields is prevented, reducing accidental data corruption or misuse.
This approach increases code maintainability, flexibility, and security.
```apex
public class BankAccount {
    public String BankName;
    private Decimal accountBalance;
    private Integer accountNumber;
    private String AccountHolderName;

    public Decimal getAccountBalance() {
        return accountBalance;
    }

    public Integer getAccountNumber() {
        return accountNumber;
    }

    public String getAccountHolderName() {
        return AccountHolderName;
    }

    public void setAccountBalance(Decimal amount) {
        if(amount >= 0) {
            this.accountBalance = amount;

        } else {
            throw new IllegalArgumentException('Balance cannot be negative');
        }
    }

    public void setAccountNumber(Integer accNum) {
        this.accountNumber = accNum;
    }

    public void setAccountHolderName(String name) {
        this.AccountHolderName = name;
    }
}

```
Modifying internal state safely via methods (e.g., deposit/withdraw for BankAccount)

Controlling how an object's data or variables are changed. This is done by using specific functions (methods) instead of allowing direct access to internal variables. 
Such methods can enforce rules, validate inputs, or trigger other necessary operations. 
This approach helps maintain the integrity and consistency of the object's data over time.

Safely via methods
``` apex
public class BankAccount {
    // Private variable hides internal state
    private Decimal balance;
    
    // Constructor initializes balance
    public BankAccount(Decimal initialBalance) {
        this.balance = initialBalance;
    }
    
    // Method safely modifies internal state
    public void deposit(Decimal amount) {
        // Validates input to ensure only positive deposits
        if (amount > 0) {
            balance += amount;
        }
    }
    
    // Method to read the state in a controlled way
    public Decimal getBalance() {
        return balance;
    }
}
```
Unsafe State Modification Example 
``` apex
public class BankAccountUnsafe {
    // Public variable exposes internal state directly
    public Decimal balance;
    
    public BankAccountUnsafe(Decimal initialBalance) {
        this.balance = initialBalance;
    }
}
// External code can now modify balance without any checks or logic:
// BankAccountUnsafe acct = new BankAccountUnsafe(100);
// acct.balance = -500; // Unsafely puts account in invalid state


Read-only properties using private set (e.g., Employee with immutable employeeId)
Read-only properties using a private setter allow data to be set within the class but prevent changes from outside. 
public class Employee {
    // Read-only property with a private setter
    public final String employeeId;
    public String name;

    // employeeId set only at construction and cannot be changed later
    public Employee(String empId, String name) {
        this.employeeId = empId;
        this.name = name;
    }
}
// Usage:
// Employee emp = new Employee('E123', 'Alice');
// emp.employeeId = 'E456'; // Compilation error – property is read-only

// employeeId is set once in constructor and cannot be changed after.
// This protects the object's integrity, ensuring the employee's identity never changes after creation.

Using inner classes for scoping (e.g., Order with OrderItem inner class)
public class Order {
    public String orderNumber;
    public List<OrderItem> items = new List<OrderItem>();

    public Order(String orderNumber) {
        this.orderNumber = orderNumber;
    }

    // Inner class scoped within Order, not directly accessible outside
    public class OrderItem {
        public String productName;
        public Integer quantity;

        public OrderItem(String productName, Integer quantity) {
            this.productName = productName;
            this.quantity = quantity;
        }
    }

    public void addItem(String productName, Integer quantity) {
        items.add(new OrderItem(productName, quantity));
    }
}

// Usage:
// Order order = new Order('O1001');
// order.addItem('Laptop', 2);
// // Can't create OrderItem directly from outside: new Order.OrderItem() is only valid inside Order context.

OrderItem is tightly scoped within Order to prevent misuse elsewhere.
This design emphasizes that OrderItem exists only as part of an Order, keeping implementation details encapsulated and clear.


Using inner classes for scoping keeps related functionality bundled together, improving encapsulation and code organization. An inner class, like OrderItem inside Order, is only meaningful within the context of its outer class.

Using inner classes in Apex enhances encapsulation by restricting the visibility of helper or component classes to their enclosing context. An inner class bundles related functionality, making maintenance and logical grouping easier.
It signals that the inner class should only be used as part of the outer class, improving code organization.
This design reduces accidental misuse and changes the way responsibilities are modeled in code.

A classic example is placing OrderItem inside the Order class, clarifying that an item is conceptually linked to an order.
public class Order {
    public String orderId;
    public List<OrderItem> items;

    // Constructor initializes orderId and item list
    public Order(String orderId) {
        this.orderId = orderId;
        this.items = new List<OrderItem>();
    }

    // Inner class: Only meaningful within the context of its enclosing Order
    public class OrderItem {
        public String productName;
        public Integer quantity;

        // Constructor initializes product and quantity
        public OrderItem(String productName, Integer quantity) {
            this.productName = productName;
            this.quantity = quantity;
        }
    }

    // Adds a new OrderItem to the order's item list
    public void addItem(String productName, Integer quantity) {
        items.add(new OrderItem(productName, quantity));
    }
}

// Usage example:
// Order order = new Order('O-1001');
// order.addItem('Monitor', 2);
// // Note: OrderItem can't be created outside Order context, keeping it scoped and organized.

This code defines an Order class representing a customer order, with an inner class OrderItem that only makes sense within an order’s context. By making OrderItem an inner class, its scope is naturally limited and its use is logically grouped with Order, enhancing both structure and maintainability.

Encapsulation with validation logic (e.g., setting age with checks in Person)

Encapsulation involves bundling data (fields) with methods that control access or mutation, often through properties or setters.
Validation logic inside setters or methods ensures fields only hold valid data, protecting object integrity.
For example, setting age should check that values are reasonable (e.g., non-negative and not excessively large).
Direct access to the underlying field is restricted, forcing use of the validation logic.
This approach helps catch errors early and makes the class safer to use.

public class Person
{
    private int age; // Private field to store the person's age

    // Public property exposes age but only allows safe values through set
    public int Age
    {
        get { return age; }
        set
        {
            // Validation: age must be between 0 and 150
            if (value < 0 || value > 150)
            {
                throw new ArgumentOutOfRangeException(nameof(Age), "Age must be between 0 and 150.");
            }
            age = value;
        }
    }

    // Optional: constructor that uses the property for assigning initial value
    public Person(int initialAge)
    {
        this.Age = initialAge;
    }
}

// Usage example:
// Person p = new Person(25); // Valid age
// p.Age = -5; // Throws exception due to invalid age
This Person class uses a private age field to hide direct access, exposing it through a property that enforces validation for realistic human ages. All attempts to set the Age property must pass the validation logic, ensuring only acceptable values are assigned—demonstrating classic encapsulation with built-in data protection.


Inheritance

Base class (Shape) and subclasses (Circle, Rectangle), each overriding an area() method

Inheritance allows a base class (like Shape) to define a common structure and interface for related subclasses.
Subclasses (Circle, Rectangle) extend the base class, specializing its behavior for particular shapes.
Overriding enables each subclass to provide its own logic for methods like area().
Polymorphism lets you interact with different shapes through a unified interface, improving flexibility.
This pattern makes code organization, reuse, and extension easier when modeling real-world hierarchies.

public virtual class Shape {
    // Base area method, can be overridden by subclasses
    public virtual Decimal area() {
        return 0;
    }
}

public class Circle extends Shape {
    private Decimal radius;

    public Circle(Decimal radius) {
        this.radius = radius;
    }

    // Override area to calculate circle area
    public override Decimal area() {
        // Area = π * r^2, Apex has Math.PI()
        return Math.PI * radius * radius;
    }
}

public class Rectangle extends Shape {
    private Decimal width, height;

    public Rectangle(Decimal width, Decimal height) {
        this.width = width;
        this.height = height;
    }

    // Override area to calculate rectangle area
    public override Decimal area() {
        return width * height;
    }
}

// Example usage (can be in an execute anonymous block):
// Shape s1 = new Circle(3);
// System.debug(s1.area()); // Outputs area of circle
// Shape s2 = new Rectangle(4, 5);
// System.debug(s2.area()); // Outputs area of rectangle

The Shape base class defines a general interface for calculating area. Subclasses Circle and Rectangle inherit from Shape and override the area() method to provide shape-specific formulas. This enables polymorphic behavior and allows shapes to be managed through a common interface, improving code flexibility and maintainability.

Hierarchical inheritance (e.g., Vehicle -> Car, Truck)
Hierarchical inheritance occurs when multiple subclasses inherit from a single parent class.
The parent class (Vehicle) defines common properties or methods all subclasses share.
Each subclass (Car, Truck) adds or customizes features unique to its type.
This structure boosts code reuse, clarity, and consistency when modeling related objects.
It’s widely used in object-oriented designs to represent real-world categories and subcategories.

public virtual class Vehicle {
    public String make;
    public String model;

    // Constructor assigns basic vehicle properties
    public Vehicle(String make, String model) {
        this.make = make;
        this.model = model;
    }

    // Method to be optionally overridden by subclasses
    public virtual String vehicleType() {
        return 'Generic Vehicle';
    }
}

public class Car extends Vehicle {
    public Integer numberOfDoors;

    public Car(String make, String model, Integer numberOfDoors) {
        super(make, model);
        this.numberOfDoors = numberOfDoors;
    }

    public override String vehicleType() {
        return 'Car';
    }
}

public class Truck extends Vehicle {
    public Decimal payloadCapacity;

    public Truck(String make, String model, Decimal payloadCapacity) {
        super(make, model);
        this.payloadCapacity = payloadCapacity;
    }

    public override String vehicleType() {
        return 'Truck';
    }
}

// Example usage (in execute anonymous window):
// Vehicle v1 = new Car('Toyota', 'Camry', 4);
// System.debug(v1.vehicleType()); // Outputs 'Car'
// Vehicle v2 = new Truck('Ford', 'F-150', 1000.5);
// System.debug(v2.vehicleType()); // Outputs 'Truck'


In this Apex example, Vehicle is the base class for shared fields like make and model. Car and Truck extend Vehicle, inheriting these properties while defining their own specific attributes and behaviors. 
This classic hierarchical inheritance arranges related types in a clear structure, enabling both code reuse and logical organization


Use of super keyword to extend base constructors (e.g., PremiumCustomer extending Customer)

The super keyword in Apex allows a subclass to call its parent class’s constructor or methods.
This ensures that base class initialization logic runs before additional subclass-specific setup.
Using super streamlines code reuse and consistency for shared attributes.
It’s especially valuable when the parent constructor has parameters or important logic.
A common pattern: PremiumCustomer calls the Customer constructor with super() first, then adds its own fields.

public class Customer {
    public String name;
    public String email;

    // Base constructor for all customers
    public Customer(String name, String email) {
        this.name = name;
        this.email = email;
    }
}

public class PremiumCustomer extends Customer {
    public Decimal loyaltyPoints;

    // Constructor for PremiumCustomer extends the base Customer constructor
    public PremiumCustomer(String name, String email, Decimal loyaltyPoints) {
        // Calls the Customer constructor to set common fields
        super(name, email);
        // Sets additional fields unique to PremiumCustomer
        this.loyaltyPoints = loyaltyPoints;
    }
}

// Usage example (run in Execute Anonymous):
// PremiumCustomer pc = new PremiumCustomer('Jane Doe', 'jane@abc.com', 123.45);
// System.debug(pc.name);          // 'Jane Doe'
// System.debug(pc.loyaltyPoints); // 123.45

Explanation:
In this Apex example, PremiumCustomer extends Customer and uses super(name, email) to initialize inherited fields, ensuring all base logic runs first. Afterward, it sets its own loyaltyPoints property. 
This pattern makes subclass construction concise and maintains proper base initialization.

Method overriding vs. overloading demonstration
Method Overriding happens when a subclass provides its own implementation of a method defined in its superclass, using the same method signature.
Method Overloading involves defining multiple methods in the same class with the same name but different parameter lists (types or number of parameters).
Overriding supports polymorphism and dynamic behavior—subclass methods replace or extend superclass logic.
Overloading improves convenience and readability by allowing methods to handle different argument combinations.
Both enhance code flexibility but serve distinct purposes in object-oriented design.

// Method Overriding Example

public virtual class Animal {
    public virtual String speak() {
        return 'Some generic animal sound';
    }
}

public class Dog extends Animal {
    // Overriding the speak() method
    public override String speak() {
        return 'Woof!';
    }
}

// Method Overloading Example

public class Calculator {
    // Adds two integers
    public Integer add(Integer a, Integer b) {
        return a + b;
    }
    
    // Overloaded add: Adds three integers (different parameter count)
    public Integer add(Integer a, Integer b, Integer c) {
        return a + b + c;
    }
    
    // Overloaded add: Adds two decimals (different types)
    public Decimal add(Decimal a, Decimal b) {
        return a + b;
    }
}

// Usage Examples (run in Execute Anonymous):
// Overriding:
Animal a = new Dog();
System.debug(a.speak()); // Outputs 'Woof!'

// Overloading:
Calculator calc = new Calculator();
System.debug(calc.add(2, 3));         // Outputs 5
System.debug(calc.add(2, 3, 4));      // Outputs 9
System.debug(calc.add(2.5, 3.5));     // Outputs 6.0

Summary:

In the Animal example, the Dog subclass overrides the speak() method, giving custom behavior.
In the Calculator example, multiple add methods are overloaded with different parameter signatures, enabling various addition scenarios.


An abstract class in Apex can’t be directly instantiated and usually contains abstract methods (without implementation) that must be implemented by subclasses.
Abstract classes provide a blueprint for concrete subclasses, enforcing certain methods or properties.
Concrete subclasses implement the abstract methods and can be instantiated.
This pattern ensures all child classes share a consistent interface but can differ in behavior.
Example: PaymentMethod defines an abstract processPayment() method; CreditCardPayment implements it.
// Abstract class representing the concept of a payment method
public abstract class PaymentMethod {
    // Abstract method: must be implemented by all subclasses
    public abstract void processPayment(Decimal amount);
}

// Concrete child class: must implement the abstract method
public class CreditCardPayment extends PaymentMethod {
    public String cardNumber;
    public String cardHolder;

    public CreditCardPayment(String cardNumber, String cardHolder) {
        this.cardNumber = cardNumber;
        this.cardHolder = cardHolder;
    }

    // Implement the abstract method with actual logic
    public override void processPayment(Decimal amount) {
        // In real world, logic would be more complex (call gateway, etc.)
        System.debug('Processing credit card payment for ' + amount + ' by ' + cardHolder);
    }
}

// Usage example (run in Execute Anonymous):
// PaymentMethod pm = new CreditCardPayment('4111111111111111', 'Alice Smith');
// pm.processPayment(200.00); 
Explanation:

PaymentMethod is an abstract class; you can’t use new PaymentMethod().
CreditCardPayment extends PaymentMethod and provides the processPayment implementation.
This guarantees that all payment method subclasses (like CreditCardPayment, PaypalPayment, etc.) promise to implement processPayment() as required.

Polymorphism

Parent-type variables holding child class objects, invoking overridden methods
In Apex, you can declare a variable of a parent class type and assign it an instance of a child class.
When you call an overridden method using this parent reference, the child class's method executes (dynamic or runtime polymorphism).
This pattern maximizes code flexibility: you can work with objects via their shared interface but retain specific behaviors.
It’s especially useful in systems (like banking) where multiple account types behave differently but share common operations.
Example: An abstract Account class with overridden calculateInterest() in each child account type.
public abstract class Account {
    public String accountNumber;
    public Decimal balance;
    
    public Account(String accountNumber, Decimal balance) {
        this.accountNumber = accountNumber;
        this.balance = balance;
    }
    
    public abstract Decimal calculateInterest();
}

public class SavingsAccount extends Account {
    public Decimal interestRate = 0.05;
    
    public SavingsAccount(String accountNumber, Decimal balance) {
        super(accountNumber, balance);
    }
    
    public override Decimal calculateInterest() {
        // Simple interest calculation for savings account
        return balance * interestRate;
    }
}

public class CurrentAccount extends Account {
    public Decimal interestRate = 0.01;
    
    public CurrentAccount(String accountNumber, Decimal balance) {
        super(accountNumber, balance);
    }
    
    public override Decimal calculateInterest() {
        // Lower interest for current account
        return balance * interestRate;
    }
}

// Usage demonstration (run in Execute Anonymous):
// Parent-type variable holding child class object
Account acc1 = new SavingsAccount('SA001', 10000);
Account acc2 = new CurrentAccount('CA001', 15000);

System.debug('SavingsAccount interest: ' + acc1.calculateInterest()); // Outputs 500.00
System.debug('CurrentAccount interest: ' + acc2.calculateInterest()); // Outputs 150.00

// Even though acc1/acc2 are Account type, the overridden calculateInterest() of the child runs

The Account class is abstract and defines mandatory structure.
SavingsAccount and CurrentAccount inherit from Account and override its calculateInterest() logic.
Even though acc1 and acc2 are declared as Account, when you call calculateInterest(), Apex executes the child class's overridden method—demonstrating polymorphism.

Array of base-class objects storing different child types, iterating to call methods

You can declare a List of a base class (Account) and store instances of any classes that extend it (SavingsAccount, CurrentAccount, etc.).
When iterating over the list and calling an overridden method (e.g., calculateInterest()), the specific child class’s method runs for each object.
This enables flexible and scalable code; you can easily handle new account types by adding more subclasses without changing your list logic.
It’s especially useful in banking or financial systems handling multiple account types with common operations.
This pattern keeps code DRY (Don’t Repeat Yourself) and perfectly utilizes polymorphism.

public abstract class Account {
    public String accountNumber;
    public Decimal balance;
    public Account(String accountNumber, Decimal balance) {
        this.accountNumber = accountNumber;
        this.balance = balance;
    }
    public abstract Decimal calculateInterest();
}

public class SavingsAccount extends Account {
    public SavingsAccount(String accountNumber, Decimal balance) {
        super(accountNumber, balance);
    }
    public override Decimal calculateInterest() {
        return balance * 0.05; // 5% interest
    }
}

public class CurrentAccount extends Account {
    public CurrentAccount(String accountNumber, Decimal balance) {
        super(accountNumber, balance);
    }
    public override Decimal calculateInterest() {
        return balance * 0.01; // 1% interest
    }
}

// Example: Array/List of base-class objects holding different child objects
List<Account> accounts = new List<Account>();
accounts.add(new SavingsAccount('SA123', 10000));
accounts.add(new CurrentAccount('CA456', 20000));
accounts.add(new SavingsAccount('SA789', 25000));

// Iterate and invoke overridden methods
for (Account acc : accounts) {
    System.debug('Account ' + acc.accountNumber + ': Interest = ' + acc.calculateInterest());
}

The accounts list holds both SavingsAccount and CurrentAccount objects.
When you loop through the list and call calculateInterest(), Apex executes the method based on the true object type for each item.
This means your banking logic can process mixed account types seamlessly, without needing to know specifics at loop time.


Store multiple child-class objects (SavingsAccount, CurrentAccount, etc.) in a single list typed to the base class (Account).
When you iterate and call an overridden method (like calculateInterest()), the correct child method runs for each object.
This supports flexible, scalable code—as new account types are added, no change in iteration logic is needed.
Polymorphism enables treating different account types uniformly, while each behaves according to its subclass logic.
This is a best practice for handling operations across varied entity types sharing a common interface.

public abstract class Account {
    public String accountNumber;
    public Decimal balance;
    public Account(String accountNumber, Decimal balance) {
        this.accountNumber = accountNumber;
        this.balance = balance;
    }
    public abstract Decimal calculateInterest();
}

public class SavingsAccount extends Account {
    public SavingsAccount(String accountNumber, Decimal balance) {
        super(accountNumber, balance);
    }
    public override Decimal calculateInterest() {
        return balance * 0.05; // 5% savings account interest
    }
}

public class CurrentAccount extends Account {
    public CurrentAccount(String accountNumber, Decimal balance) {
        super(accountNumber, balance);
    }
    public override Decimal calculateInterest() {
        return balance * 0.01; // 1% current account interest
    }
}

// Example usage: array of base-class objects with different child types
List<Account> accountList = new List<Account>{
    new SavingsAccount('SA123', 10000),
    new CurrentAccount('CA456', 20000),
    new SavingsAccount('SA789', 30000)
};

for (Account acc : accountList) {
    System.debug('Account Number: ' + acc.accountNumber +
                 ', Interest: ' + acc.calculateInterest());
}
// Output:
// Account Number: SA123, Interest: 500.0
// Account Number: CA456, Interest: 200.0
// Account Number: SA789, Interest: 1500.0

You maintain a single List<Account> that can flexibly hold any future account types.
The for-loop calls calculateInterest() on each, with run-time dispatch ensuring correct interest logic for each account type.
This structure minimizes maintenance and error-prone code as your system grows.

Interface usage for different payment options (Payable interface for multiple payment classes)


An interface in Apex defines a set of method signatures that must be implemented by any class using it, but provides no logic itself.
Interfaces enable polymorphism: code can interact with objects implementing the interface, regardless of their specific type.
This is ideal for payment systems, where each payment type should promise the same operations (e.g., makePayment()), but the logic differs.
Adding new payment options only requires a new implementation of the Payable interface, not code changes elsewhere.
A list of Payable objects can process multiple payment types uniformly.
// 1. Define a Payable interface
public interface Payable {
    void makePayment(Decimal amount);
}

// 2. Credit Card payment class implementing Payable
public class CreditCardPayment implements Payable {
    public String cardNumber;
    public String cardHolder;

    public CreditCardPayment(String cardNumber, String cardHolder) {
        this.cardNumber = cardNumber;
        this.cardHolder = cardHolder;
    }

    public void makePayment(Decimal amount) {
        System.debug('Credit card payment of ' + amount + ' by ' + cardHolder);
    }
}

// 3. PayPal payment class implementing Payable
public class PaypalPayment implements Payable {
    public String email;

    public PaypalPayment(String email) {
        this.email = email;
    }

    public void makePayment(Decimal amount) {
        System.debug('PayPal payment of ' + amount + ' from account ' + email);
    }
}

// 4. Cryptocurrency payment class implementing Payable
public class CryptoPayment implements Payable {
    public String walletId;

    public CryptoPayment(String walletId) {
        this.walletId = walletId;
    }

    public void makePayment(Decimal amount) {
        System.debug('Crypto payment of ' + amount + ' from wallet ' + walletId);
    }
}

// Usage demo (run in Execute Anonymous):
List<Payable> payments = new List<Payable>{
    new CreditCardPayment('4111111111111111', 'Jane Doe'),
    new PaypalPayment('jane.doe@example.com'),
    new CryptoPayment('crypto-wallet-xyz')
};
for (Payable p : payments) {
    p.makePayment(100.00);
}

An interface defines a contract—methods all implementing classes must provide—but supplies no code.
Classes like CreditCardPayment, PaypalPayment, and CryptoPayment all implement the same interface, so they can be processed polymorphically.
You can keep a collection of the interface type and treat all payment options identically at processing time.
This structure supports extensibility: adding new payment types only involves creating a new class implementing Payable.
It's ideal in payment or transaction systems for uniform processing and code clarity.
// Payable interface definition
public interface Payable {
    void makePayment(Decimal amount);
}

// Concrete class for credit card payments
public class CreditCardPayment implements Payable {
    public String cardNumber;
    public CreditCardPayment(String cardNumber) {
        this.cardNumber = cardNumber;
    }
    public void makePayment(Decimal amount) {
        System.debug('Credit card payment of ' + amount + ' using card ' + cardNumber);
    }
}

// Concrete class for PayPal payments
public class PaypalPayment implements Payable {
    public String email;
    public PaypalPayment(String email) {
        this.email = email;
    }
    public void makePayment(Decimal amount) {
        System.debug('PayPal payment of ' + amount + ' from ' + email);
    }
}

// Concrete class for crypto payments
public class CryptoPayment implements Payable {
    public String walletId;
    public CryptoPayment(String walletId) {
        this.walletId = walletId;
    }
    public void makePayment(Decimal amount) {
        System.debug('Crypto payment of ' + amount + ' from wallet ' + walletId);
    }
}

// Usage: storing different payment types in a single list
List<Payable> payments = new List<Payable>{
    new CreditCardPayment('4111-xxxx-xxxx-1234'),
    new PaypalPayment('alice@example.com'),
    new CryptoPayment('WALLET123XYZ')
};

for (Payable p : payments) {
    p.makePayment(100.00);
}

The interface ensures all payment types provide a makePayment() method.
Storing them as List<Payable> enables flexible, unified processing.
Adding a new payment method just means implementing the Payable interface, with no changes elsewhere.


An interface defines a contract of methods without implementation.
Each payment type (e.g., credit card, PayPal) implements the Payable interface.
This lets you handle all payment types polymorphically using a single reference type.
New payment options require only a new class that implements the interface.
You can iterate over a list of Payable to process multiple payment types seamlessly

public interface Payable {
    void makePayment(Decimal amount);
}

public class CreditCardPayment implements Payable {
    public String cardNumber;
    public CreditCardPayment(String cardNumber) {
        this.cardNumber = cardNumber;
    }
    public void makePayment(Decimal amount) {
        System.debug('Credit card payment of ' + amount + ' using ' + cardNumber);
    }
}

public class PaypalPayment implements Payable {
    public String email;
    public PaypalPayment(String email) {
        this.email = email;
    }
    public void makePayment(Decimal amount) {
        System.debug('PayPal payment of ' + amount + ' from ' + email);
    }
}

public class CryptoPayment implements Payable {
    public String walletId;
    public CryptoPayment(String walletId) {
        this.walletId = walletId;
    }
    public void makePayment(Decimal amount) {
        System.debug('Crypto payment of ' + amount + ' from wallet ' + walletId);
    }
}

// Demonstration: store different payment types, process each
List<Payable> payments = new List<Payable>{
    new CreditCardPayment('4111-xxxx-xxxx-1111'),
    new PaypalPayment('user@example.com'),
    new CryptoPayment('crypto-wallet-abc')
};
for (Payable p : payments) {
    p.makePayment(250.00);
}

The Payable interface enforces a consistent makePayment() method.
Each class implements this method in its own way.
The list of Payable allows you to process all payment types with the same logic, demonstrating polymorphism and flexibility.


An interface in Apex defines required methods without implementation.
Each payment type (credit card, PayPal, crypto, etc.) implements the same makePayment() method per the Payable interface.
You can store any implementing class in a collection of the interface type.
This lets you process payments generically, regardless of their underlying type.
This is ideal for extensible and maintainable payment processing systems

public interface Payable {
    void makePayment(Decimal amount);
}

public class CreditCardPayment implements Payable {
    public String cardNumber;
    public CreditCardPayment(String cardNumber) {
        this.cardNumber = cardNumber;
    }
    public void makePayment(Decimal amount) {
        System.debug('Processing credit card payment of ' + amount + ' with card ' + cardNumber);
    }
}

public class PaypalPayment implements Payable {
    public String accountEmail;
    public PaypalPayment(String accountEmail) {
        this.accountEmail = accountEmail;
    }
    public void makePayment(Decimal amount) {
        System.debug('Processing PayPal payment of ' + amount + ' from account ' + accountEmail);
    }
}

public class CryptoPayment implements Payable {
    public String walletId;
    public CryptoPayment(String walletId) {
        this.walletId = walletId;
    }
    public void makePayment(Decimal amount) {
        System.debug('Processing cryptocurrency payment of ' + amount + ' from wallet ' + walletId);
    }
}


// Example: managing different payments polymorphically
List<Payable> paymentList = new List<Payable>{
    new CreditCardPayment('4111-xxxx-xxxx-1234'),
    new PaypalPayment('user@example.com'),
    new CryptoPayment('WALLET-XYZ-456')
};

for (Payable payment : paymentList) {
    payment.makePayment(150.00);
}

Any class implementing the interface must provide the makePayment() method.
You can add new payment types by simply implementing the interface—no changes to processing logic needed.
The list allows iterating over all payment methods and treating them identically, while invoking their custom logic at runtime.


An interface in Apex enforces a contract: all implementing classes must define specific methods.
Multiple payment classes (e.g., credit card, PayPal, cryptocurrency) implement the Payable interface.
You can hold all payment types in a single collection of type Payable.
Calling a method on Payable executes the specific implementation for each payment type.
This design allows easy expansion for future payment methods with minimal code change.

public interface Payable {
    void makePayment(Decimal amount);
}

public class CreditCardPayment implements Payable {
    public String cardNumber;
    public CreditCardPayment(String cardNumber) {
        this.cardNumber = cardNumber;
    }
    public void makePayment(Decimal amount) {
        System.debug('Processing credit card payment: ' + amount +
                     ', Card: ' + cardNumber);
    }
}

public class PaypalPayment implements Payable {
    public String paypalEmail;
    public PaypalPayment(String paypalEmail) {
        this.paypalEmail = paypalEmail;
    }
    public void makePayment(Decimal amount) {
        System.debug('Processing PayPal payment: ' + amount +
                     ', Email: ' + paypalEmail);
    }
}

public class CryptoPayment implements Payable {
    public String walletAddress;
    public CryptoPayment(String walletAddress) {
        this.walletAddress = walletAddress;
    }
    public void makePayment(Decimal amount) {
        System.debug('Processing crypto payment: ' + amount +
                     ', Wallet: ' + walletAddress);
    }
}

// Usage: store and process various payment types
List<Payable> paymentList = new List<Payable>{
    new CreditCardPayment('1234-****-****-5678'),
    new PaypalPayment('test@domain.com'),
    new CryptoPayment('crypto-wallet-789')
};

for (Payable p : paymentList) {
    p.makePayment(100.00);
}

All payment types implement the same makePayment() method as required by the Payable interface.
Payments can be processed polymorphically within a loop, without knowing their specific type at compile time.
Adding a new payment type (e.g., Apple Pay) just requires a new class implementing Payable.


The Payable interface enforces that all payment classes implement makePayment().
How the Payable Interface Enforces Implementation
What Does “Enforces” Mean Here?

When you define an interface in Apex, every class that declares implements Payable must provide its own complete version of every method listed in that interface.
If a class claims to implement Payable but does not implement all its methods (e.g., forgets to provide makePayment()), Apex compilation will fail, and the system will prompt an error.
This enforcement guarantees consistency across all payment classes and enables reliable polymorphism—your code can always expect a makePayment() capability from any Payable object.


Polymorphism in Collections: List of shape types, each with area calculation
Polymorphism allows parent-type collections (e.g., list of Shape) to hold different child objects (like Circle, Rectangle, Triangle).
Each shape class implements a common contract (getArea()), so you can calculate the area for each polymorphically.
This lets you write cleaner, more maintainable code—processing various shapes together without knowing their exact types.

// Step 1: Define a Shape interface
public interface Shape {
    Decimal getArea();
}

// Step 2: Implement different shape types
public class Circle implements Shape {
    public Decimal radius;
    public Circle(Decimal radius) { this.radius = radius; }
    public Decimal getArea() {
        return Math.PI * radius * radius;
    }
}

public class Rectangle implements Shape {
    public Decimal width;
    public Decimal height;
    public Rectangle(Decimal width, Decimal height) {
        this.width = width; this.height = height;
    }
    public Decimal getArea() {
        return width * height;
    }
}

public class Triangle implements Shape {
    public Decimal baseLen;
    public Decimal height;
    public Triangle(Decimal baseLen, Decimal height) {
        this.baseLen = baseLen; this.height = height;
    }
    public Decimal getArea() {
        return (baseLen * height) / 2;
    }
}

// Step 3: Create a collection of different shapes and compute area
List<Shape> shapes = new List<Shape>{
    new Circle(3),
    new Rectangle(4, 5),
    new Triangle(6, 2)
};

for (Shape s : shapes) {
    System.debug('Area: ' + s.getArea());
}
// Output:
// Area: 28.274...
// Area: 20
// Area: 6

Explanation

The Shape interface ensures all shape types implement getArea().
The shapes list holds various shape types but is declared as List<Shape>.
When iterating through the list, calling getArea() invokes the right logic for each underlying shape—polymorphism in action!
This makes it easy to add new shapes in the future, or process all shapes in one loop.

Applying polymorphism to sort custom objects

How Polymorphism Enables Sorting in Collections

Comparable Interface: Apex’s Comparable interface enforces that any implementing class must supply a compareTo() method that defines how two objects are compared.
Polymorphism: When you have a List<Comparable>, the runtime will call the correct compareTo() logic for each object—even if you have different subclasses.
Practical Benefit: Sort complex objects (like orders by amount, shapes by area, students by grade) just by calling List.sort().

Let's apply this using the previous shapes scenario—sorting a list of various shapes by their area (smallest to largest):

// Step 1: Shape interface with area calculation
public interface Shape {
    Decimal getArea();
}

// Step 2: Make a wrapper class that is Comparable
public class ComparableShape implements Shape, Comparable {
    public Shape underlyingShape;
    public ComparableShape(Shape s) { this.underlyingShape = s; }
    public Decimal getArea() { return underlyingShape.getArea(); }
    
    // Required by Comparable
    public Integer compareTo(Object obj) {
        ComparableShape other = (ComparableShape)obj;
        if (this.getArea() == other.getArea()) return 0;
        return (this.getArea() < other.getArea()) ? -1 : 1;
    }
}

// Step 3: Concrete shape implementations
public class Circle implements Shape {
    public Decimal radius;
    public Circle(Decimal radius) { this.radius = radius; }
    public Decimal getArea() { return Math.PI * radius * radius; }
}
public class Rectangle implements Shape {
    public Decimal w; public Decimal h;
    public Rectangle(Decimal w, Decimal h){ this.w=w; this.h=h;}
    public Decimal getArea() { return w * h; }
}
public class Triangle implements Shape {
    public Decimal b; public Decimal h;
    public Triangle(Decimal b, Decimal h){ this.b=b; this.h=h;}
    public Decimal getArea() { return (b * h) / 2; }
}

// Step 4: Populate, wrap, and sort
List<ComparableShape> toSort = new List<ComparableShape>{
    new ComparableShape(new Circle(2)),
    new ComparableShape(new Rectangle(2, 7)),
    new ComparableShape(new Triangle(5, 4))
};
toSort.sort(); // Sorts in ascending order by area

for (ComparableShape cs : toSort) {
    System.debug('Area: ' + cs.getArea());
}
// Output: Shape areas from smallest to largest

Each shape implements Shape.
ComparableShape wraps any Shape and implements Comparable, allowing it to be sorted by area.
The compareTo() logic centralizes the comparison—polymorphic because any shape can be wrapped and thus sorted.
You can use this same principle to sort custom objects like Account, Order, or Invoice by name, amount, or any other property—just implement Comparable and define your sort logic!


Parameterized Constructors

Class with multiple constructors (default + parameterized) (e.g., Book)

Book Class with Default and Parameterized Constructors
Concept Overview

Default Constructor: Automatically provided by Apex if you define no constructors. If you define any constructor yourself, you must explicitly define a default one if you want both.
Parameterized Constructor: Accepts arguments to immediately set object fields during instantiation.
Benefit: Provides flexibility; you can create a book with preset values or supply details up front.

public class Book {
    public String title;
    public String author;
    public Decimal price;

    // Default no-args constructor
    public Book() {
        this.title = 'Unknown';
        this.author = 'Unknown';
        this.price = 0.0;
    }

    // Parameterized constructor
    public Book(String title, String author, Decimal price) {
        this.title = title;
        this.author = author;
        this.price = price;
    }
}

// Example usage:
Book defaultBook = new Book();  // Uses default values
System.debug('Default Book: ' + defaultBook.title + ', ' + defaultBook.author + ', $' + defaultBook.price);

Book customBook = new Book('Clean Code', 'Robert Martin', 29.99);  // Uses custom values
System.debug('Custom Book: ' + customBook.title + ', ' + customBook.author + ', $' + customBook.price);

Explanation:

The class provides two constructors: a default and a parameterized.
When you create new Book(), it sets fields to default values.
When you use new Book('Clean Code', 'Robert Martin', 29.99), it initializes the book with those values.
This pattern is highly extensible and a standard for classes where objects can be created both with and without initial data.

Constructor chaining (where one constructor calls another), or an example with additional fields or validation?
public class Book {
    public String title;
    public String author;
    public Decimal price;

    // Default (no-argument) constructor
    public Book() {
        this.title = 'Untitled';
        this.author = 'Unknown';
        this.price = 0.0;
    }

    // Parameterized constructor
    public Book(String title, String author, Decimal price) {
        this.title = title;
        this.author = author;
        this.price = price;
    }
}

// Example usage:
Book defaultBook = new Book();  // Uses the default constructor
System.debug('Default: ' + defaultBook.title + ', ' + defaultBook.author + ', ' + defaultBook.price);

Book customBook = new Book('Dune', 'Frank Herbert', 18.99); // Uses parameterized constructor
System.debug('Custom: ' + customBook.title + ', ' + customBook.author + ', ' + customBook.price);

How this works:

new Book() uses the default constructor, assigning placeholder values.
new Book('Dune', 'Frank Herbert', 18.99) lets you specify all fields at creation.
This flexibility is helpful whenever you want to create empty objects first (for later population) or construct fully-detailed objects immediately.

Overloading constructors for different initialization scenarios

public class Book {
    public String title;
    public String author;
    public Decimal price;

    // 1. Default constructor (no arguments)
    public Book() {
        this.title = 'Untitled';
        this.author = 'Unknown';
        this.price = 0.0;
    }

    // 2. Constructor with title and author only
    public Book(String title, String author) {
        this.title = title;
        this.author = author;
        this.price = 0.0; // Default price
    }

    // 3. Constructor with all details
    public Book(String title, String author, Decimal price) {
        this.title = title;
        this.author = author;
        this.price = price;
    }
}

// Example usage:
Book b1 = new Book();                                         // Default values
Book b2 = new Book('The Hobbit', 'J.R.R. Tolkien');           // Title and author, default price
Book b3 = new Book('1984', 'George Orwell', 15.99);           // Full detail

System.debug(b1.title + ', ' + b1.author + ', $' + b1.price); // Output: Untitled, Unknown, $0.0
System.debug(b2.title + ', ' + b2.author + ', $' + b2.price); // Output: The Hobbit, J.R.R. Tolkien, $0.0
System.debug(b3.title + ', ' + b3.author + ', $' + b3.price); // Output: 1984, George Orwell, $15.99

Explanation

Default constructor: Allows creation with no information.
Title and author constructor: Use this if price isn’t always known up front.
Full parameterized constructor: Enables full customization at object creation.
Apex determines which constructor to call based on the number and type of parameters provided.

Benefits of Constructor Overloading

Flexibility: Users of your class can initialize objects the way that best suits their data availability.
Clarity: Different service or data input pathways can point to the appropriate constructor.
Maintainability: Reduces the need for lots of null checks or for “setup” methods after construction.

Passing objects as constructor parameters (e.g., Student takes Department)

Passing objects as constructor parameters enables composition in your class design, where one object contains another. 
This promotes modularity and allows you to build complex types from simpler ones. 
For instance, if each Student belongs to a Department, you can pass a Department object into the Student constructor to establish this relationship. 
This technique increases flexibility and code reuse. It also lets you easily access associated data within your objects.

public class Department {
    public String name;
    public Department(String name) { this.name = name; }
}

public class Student {
    public String studentName;
    public Department dept;
    public Student(String studentName, Department dept) {
        this.studentName = studentName;
        this.dept = dept;
    }
}

// Usage
Department csDept = new Department('Computer Science');
Student alice = new Student('Alice', csDept);
System.debug(alice.studentName + ' -> ' + alice.dept.name); // Output: Alice -> Computer Science

Using constructors for deep copies (e.g., copying an Order)
A deep copy constructor creates a new object with the same data as the original, ensuring any referenced objects are also copied, not just their references. This prevents side effects from changes to the original or its nested objects. In Apex, you can define such a constructor by accepting another object as a parameter and duplicating all fields, including custom objects. This approach is ideal for objects like Order that include sub-objects (e.g., items, customer info). Deep copying promotes data integrity and safe manipulation of object graphs.
public class OrderItem {
    public String itemName;
    public OrderItem(String itemName) {
        this.itemName = itemName;
    }
    // Deep copy constructor
    public OrderItem(OrderItem original) {
        this.itemName = original.itemName;
    }
}

public class Order {
    public String orderNumber;
    public List<OrderItem> items;
    public Order(String orderNumber, List<OrderItem> items) {
        this.orderNumber = orderNumber;
        this.items = new List<OrderItem>();
        for (OrderItem item : items) {
            this.items.add(item);
        }
    }
    // Deep copy constructor
    public Order(Order original) {
        this.orderNumber = original.orderNumber;
        this.items = new List<OrderItem>();
        for (OrderItem item : original.items) {
            this.items.add(new OrderItem(item));
        }
    }
}

The Order deep copy constructor duplicates both the orderNumber and a new list of copied OrderItem objects. This ensures changes to copied items don't affect the originals since each nested object is recreated.


Initializing immutable objects via constructor only (e.g., Config class)
Initializing immutable objects exclusively via constructors ensures that their fields cannot be changed after creation. This pattern is common for classes like a Config object, where consistent, reliable values are necessary for security or integrity. By setting fields as final (if supported) or removing setters, you enforce immutability. All values are supplied at object creation, promoting thread safety and reducing bugs from unintended state changes.
public class Config {
    public final String environment;
    public final String serviceEndpoint;
    public final Integer timeout;

    // Constructor to initialize all fields
    public Config(String environment, String serviceEndpoint, Integer timeout) {
        this.environment = environment;
        this.serviceEndpoint = serviceEndpoint;
        this.timeout = timeout;
    }
}

// Usage example
Config prodConfig = new Config('Production', 'https://api.example.com', 5000);
System.debug(prodConfig.environment); // Output: Production

All fields are set once via the constructor and can’t be modified after, ensuring the object stays constant throughout its lifecycle. This is ideal for configuration or constant-value objects.


# 2. Control Structures

Conditional Logic

Multi-step if/else chain (e.g., grading calculator, score to grade)

A multi-step if/else chain evaluates conditions sequentially, executing the first matching block and skipping the rest.
This pattern is ideal for scenarios like grading systems where scores map to letter grades based on ranges.
Each condition is checked in order, making it easy to handle multiple thresholds.
The final else clause handles any values not caught by previous conditions.

public class GradingCalculator {
    public static String calculateGrade(Decimal score) {
        String grade;
        if (score >= 90) {
            grade = 'A';
        } else if (score >= 80) {
            grade = 'B';
        } else if (score >= 70) {
            grade = 'C';
        } else if (score >= 60) {
            grade = 'D';
        } else {
            grade = 'F';
        }
        return grade;
    }
}

// Usage example (run in Execute Anonymous):
// String result = GradingCalculator.calculateGrade(85);
// System.debug('Grade: ' + result); // Output: Grade: B

```


The method checks score ranges from highest to lowest, assigning the appropriate letter grade.
This structure ensures only one grade is assigned per score, making the logic clear and maintainable.

Nested if statements for validation (e.g., sign-up requirements)

Nested if statements allow you to check multiple conditions in a hierarchical manner, where inner conditions only execute if outer conditions are met.
This pattern is perfect for validation scenarios where you need to verify multiple requirements before proceeding.
Each nested level adds another layer of validation, ensuring all criteria are satisfied.
This approach provides fine-grained control over complex validation logic.

```apex
public class SignUpValidator {
    public static String validateSignUp(String username, String email, Integer age) {
        String errorMessage = '';
        
        if (username != null && username.length() > 0) {
            if (username.length() >= 5) {
                if (email != null && email.contains('@')) {
                    if (age >= 18) {
                        errorMessage = 'Valid sign-up';
                    } else {
                        errorMessage = 'Age must be 18 or older';
                    }
                } else {
                    errorMessage = 'Invalid email format';
                }
            } else {
                errorMessage = 'Username must be at least 5 characters';
            }
        } else {
            errorMessage = 'Username cannot be empty';
        }
        
        return errorMessage;
    }
}

// Usage example (run in Execute Anonymous):
// String result1 = SignUpValidator.validateSignUp('john123', 'john@example.com', 25);
// System.debug(result1); // Output: Valid sign-up
// String result2 = SignUpValidator.validateSignUp('joe', 'joe@example.com', 20);
// System.debug(result2); // Output: Username must be at least 5 characters

```


Each nested if statement checks a specific validation rule, building a comprehensive validation chain.
Only when all outer conditions pass does the inner validation execute, ensuring all requirements are met.

Switch case for day of week or user role handling

Switch statements provide a clean way to handle multiple discrete values, executing code based on a variable's value.
They're more readable than long if/else chains when dealing with specific enumerated values.
Each case represents a possible value, with a default case handling unexpected values.
This pattern is ideal for role-based access control or day-of-week logic.

```apex
public class DayOfWeekHandler {
    public static String getDayType(String day) {
        String dayType;
        switch on day.toLowerCase() {
            when 'monday', 'tuesday', 'wednesday', 'thursday', 'friday' {
                dayType = 'Weekday';
            }
            when 'saturday', 'sunday' {
                dayType = 'Weekend';
            }
            when else {
                dayType = 'Invalid day';
            }
        }
        return dayType;
    }
}

public class UserRoleHandler {
    public static String getAccessLevel(String role) {
        String accessLevel;
        switch on role {
            when 'Admin' {
                accessLevel = 'Full Access';
            }
            when 'Manager' {
                accessLevel = 'Department Access';
            }
            when 'User' {
                accessLevel = 'Limited Access';
            }
            when else {
                accessLevel = 'No Access';
            }
        }
        return accessLevel;
    }
}

// Usage examples (run in Execute Anonymous):
// System.debug(DayOfWeekHandler.getDayType('Monday')); // Output: Weekday
// System.debug(UserRoleHandler.getAccessLevel('Admin')); // Output: Full Access

```


Switch statements use pattern matching to execute code based on the input value.
Multiple values can be grouped in a single when clause, and the when else clause handles all other cases.

Switch with fall-through logic and default cases

In Apex, switch statements don't have traditional fall-through like some languages, but you can group multiple cases together.
The when else clause serves as the default case, handling any values not explicitly matched.
You can use multiple when clauses to handle different values with the same logic.
This provides flexibility in handling various scenarios with shared behavior.

```apex
public class StatusHandler {
    public static String processStatus(String status) {
        String action;
        switch on status {
            when 'Active' {
                action = 'Process active record';
            }
            when 'Pending', 'In Progress' {
                action = 'Queue for review';
            }
            when 'Completed', 'Closed' {
                action = 'Archive record';
            }
            when 'Cancelled' {
                action = 'Mark as cancelled';
            }
            when else {
                action = 'Unknown status - manual review required';
            }
        }
        return action;
    }
}

// Usage example (run in Execute Anonymous):
// System.debug(StatusHandler.processStatus('Pending')); // Output: Queue for review
// System.debug(StatusHandler.processStatus('Invalid')); // Output: Unknown status - manual review required

```


Multiple values in a single when clause share the same logic, similar to fall-through behavior.
The when else clause ensures all possible values are handled, preventing unexpected behavior.

Using ternary operator for compact decisions (e.g., even/odd)

The ternary operator provides a concise way to make simple conditional assignments in a single line.

## It follows the pattern: condition ? valueIfTrue : valueIfFalse.


## This is ideal for simple decisions where a full if/else block would be verbose.

It improves code readability for straightforward conditional logic.

```apex
public class TernaryExamples {
    public static String checkEvenOdd(Integer number) {
        return (Math.mod(number, 2) == 0) ? 'Even' : 'Odd';
    }
    
    public static String getStatus(Boolean isActive) {
        return isActive ? 'Active' : 'Inactive';
    }
    
    public static Decimal calculateDiscount(Decimal price, Boolean isPremium) {
        return isPremium ? price * 0.9 : price; // 10% discount for premium
    }
}

// Usage examples (run in Execute Anonymous):
// System.debug(TernaryExamples.checkEvenOdd(7)); // Output: Odd
// System.debug(TernaryExamples.getStatus(true)); // Output: Active
// System.debug(TernaryExamples.calculateDiscount(100, true)); // Output: 90.0

```


The ternary operator evaluates the condition and returns one of two values based on the result.
It's more compact than if/else for simple assignments, but should be used judiciously to maintain readability.

Loops

Simple for loop iteration (sum of first n numbers)

A simple for loop iterates a fixed number of times, executing code on each iteration.
It's perfect for calculations that require sequential processing, like summing numbers.

## The loop variable increments automatically, controlling the iteration count.

This pattern is fundamental for many algorithms and data processing tasks.

```apex
public class LoopExamples {
    public static Integer sumFirstN(Integer n) {
        Integer sum = 0;
        for (Integer i = 1; i <= n; i++) {
            sum += i;
        }
        return sum;
    }
    
    public static Integer factorial(Integer n) {
        Integer result = 1;
        for (Integer i = 1; i <= n; i++) {
            result *= i;
        }
        return result;
    }
}

// Usage example (run in Execute Anonymous):
// System.debug(LoopExamples.sumFirstN(10)); // Output: 55 (sum of 1 to 10)
// System.debug(LoopExamples.factorial(5)); // Output: 120 (5!)

```


The for loop initializes a counter, checks a condition, and increments the counter each iteration.
This structure is ideal for operations that need to repeat a known number of times.

Enhanced for loop over arrays or collections

Enhanced for loops (for-each) iterate over collections without needing an index variable.

## They automatically handle iteration through lists, sets, and maps.

This syntax is cleaner and less error-prone than traditional for loops with indices.
It's the preferred method for iterating through collections in Apex.

```apex
public class EnhancedLoopExamples {
    public static Integer sumList(List<Integer> numbers) {
        Integer sum = 0;
        for (Integer num : numbers) {
            sum += num;
        }
        return sum;
    }
    
    public static List<String> processStrings(List<String> words) {
        List<String> processed = new List<String>();
        for (String word : words) {
            processed.add(word.toUpperCase());
        }
        return processed;
    }
    
    public static void iterateMap(Map<String, Integer> scores) {
        for (String key : scores.keySet()) {
            System.debug(key + ': ' + scores.get(key));
        }
    }
}

// Usage example (run in Execute Anonymous):
// List<Integer> nums = new List<Integer>{1, 2, 3, 4, 5};
// System.debug(EnhancedLoopExamples.sumList(nums)); // Output: 15
// List<String> words = new List<String>{'hello', 'world'};
// System.debug(EnhancedLoopExamples.processStrings(words)); // Output: (HELLO, WORLD)

```


Enhanced for loops automatically iterate through each element in the collection.
They eliminate the need for index management and reduce the chance of index-related errors.

While loop: user input simulation (e.g., guessing game)


## While loops continue executing as long as a condition remains true.

They're ideal for scenarios where the number of iterations is unknown beforehand.
This pattern is useful for simulations, input validation, or processing until a condition is met.
The loop condition is checked before each iteration.

```apex
public class GuessingGame {
    private static Integer secretNumber = 42;
    
    public static String checkGuess(Integer guess) {
        if (guess == secretNumber) {
            return 'Correct!';
        } else if (guess < secretNumber) {
            return 'Too low';
        } else {
            return 'Too high';
        }
    }
    
    public static void simulateGame() {
        Integer attempts = 0;
        Integer guess = 0;
        
        while (guess != secretNumber && attempts < 10) {
            attempts++;
            // Simulate guesses (in real scenario, this would be user input)
            guess = attempts * 5; // Simulated guess pattern
            System.debug('Attempt ' + attempts + ': ' + checkGuess(guess));
        }
        
        if (guess == secretNumber) {
            System.debug('Game won in ' + attempts + ' attempts!');
        } else {
            System.debug('Game over - maximum attempts reached');
        }
    }
}

// Usage example (run in Execute Anonymous):
// GuessingGame.simulateGame();

```


While loops continue until the condition becomes false or a break statement is encountered.
They're perfect for scenarios where iteration count depends on runtime conditions.

Do-while loop for at-least-once execution (e.g., continue until a valid email)


## Do-while loops guarantee at least one execution before checking the condition.

The condition is evaluated after each iteration, ensuring the loop body runs at least once.

## This is ideal for input validation where you need to prompt at least once.

Apex doesn't have a native do-while, but you can simulate it with a while loop and a flag.

```apex
public class EmailValidator {
    public static Boolean isValidEmail(String email) {
        return email != null && email.contains('@') && email.contains('.');
    }
    
    public static String validateEmailInput() {
        // Simulate do-while: execute at least once, then check condition
        String email = 'invalid'; // Simulated first input
        Boolean isValid = false;
        
        // Simulate multiple attempts until valid
        Integer attempts = 0;
        while (!isValid && attempts < 5) {
            attempts++;
            // In real scenario: email = getUserInput();
            email = attempts == 3 ? 'user@example.com' : 'invalid';
            isValid = isValidEmail(email);
            
            if (!isValid) {
                System.debug('Invalid email format. Please try again.');
            }
        }
        
        return isValid ? email : 'Validation failed after maximum attempts';
    }
}

// Usage example (run in Execute Anonymous):
// System.debug(EmailValidator.validateEmailInput());

```


The pattern ensures the validation logic runs at least once before checking if it should continue.
This is essential for scenarios requiring initial execution regardless of the condition state.

Nested loops: matrix multiplication

Nested loops place one loop inside another, allowing you to work with multi-dimensional data structures.
They're essential for operations like matrix multiplication, where you need to iterate through rows and columns.

## The outer loop controls one dimension while the inner loop handles another.

This pattern enables complex data processing and algorithmic operations.

```apex
public class MatrixOperations {
    public static List<List<Integer>> multiplyMatrices(
        List<List<Integer>> matrixA, 
        List<List<Integer>> matrixB
    ) {
        Integer rowsA = matrixA.size();
        Integer colsA = matrixA[0].size();
        Integer colsB = matrixB[0].size();
        
        List<List<Integer>> result = new List<List<Integer>>();
        
        // Initialize result matrix
        for (Integer i = 0; i < rowsA; i++) {
            List<Integer> row = new List<Integer>();
            for (Integer j = 0; j < colsB; j++) {
                row.add(0);
            }
            result.add(row);
        }
        
        // Perform matrix multiplication
        for (Integer i = 0; i < rowsA; i++) {
            for (Integer j = 0; j < colsB; j++) {
                Integer sum = 0;
                for (Integer k = 0; k < colsA; k++) {
                    sum += matrixA[i][k] * matrixB[k][j];
                }
                result[i][j] = sum;
            }
        }
        
        return result;
    }
}

// Usage example (run in Execute Anonymous):
// List<List<Integer>> A = new List<List<Integer>>{
//     new List<Integer>{1, 2},
//     new List<Integer>{3, 4}
// };
// List<List<Integer>> B = new List<List<Integer>>{
//     new List<Integer>{5, 6},
//     new List<Integer>{7, 8}
// };
// System.debug(MatrixOperations.multiplyMatrices(A, B));

```


## Nested loops enable processing of multi-dimensional data structures.

The innermost loop performs the core calculation, while outer loops control the traversal pattern.

Breaking out of a loop with break under specific condition


## The break statement immediately exits a loop when a specific condition is met.

It's useful for stopping iteration once a target is found or a condition is satisfied.

## This prevents unnecessary iterations and improves efficiency.

Break only exits the innermost loop when used in nested structures.

```apex
public class BreakExamples {
    public static Integer findFirstEven(List<Integer> numbers) {
        for (Integer num : numbers) {
            if (Math.mod(num, 2) == 0) {
                return num; // Exit immediately when found
            }
        }
        return null;
    }
    
    public static Boolean containsValue(List<String> items, String target) {
        for (String item : items) {
            if (item == target) {
                return true; // Exit as soon as found
            }
        }
        return false;
    }
    
    public static void processUntilLimit(List<Integer> data, Integer limit) {
        Integer count = 0;
        for (Integer value : data) {
            if (value > limit) {
                break; // Exit loop when limit exceeded
            }
            count++;
            System.debug('Processing: ' + value);
        }
        System.debug('Processed ' + count + ' items');
    }
}

// Usage example (run in Execute Anonymous):
// List<Integer> nums = new List<Integer>{1, 3, 5, 8, 9};
// System.debug(BreakExamples.findFirstEven(nums)); // Output: 8
// BreakExamples.processUntilLimit(nums, 6); // Processes only 1, 3, 5

```


Break statements provide early exit from loops when further iteration is unnecessary.
They improve performance by avoiding processing of remaining elements once a condition is met.

Using continue to skip elements (e.g., skip negative numbers in array)

The continue statement skips the current iteration and proceeds to the next one.

## It's useful for filtering out unwanted elements during iteration.

This allows you to process only specific items without exiting the loop entirely.
Continue is ideal for conditional processing within loops.

```apex
public class ContinueExamples {
    public static List<Integer> filterPositives(List<Integer> numbers) {
        List<Integer> positives = new List<Integer>();
        for (Integer num : numbers) {
            if (num < 0) {
                continue; // Skip negative numbers
            }
            positives.add(num);
        }
        return positives;
    }
    
    public static Integer sumEvenNumbers(List<Integer> numbers) {
        Integer sum = 0;
        for (Integer num : numbers) {
            if (Math.mod(num, 2) != 0) {
                continue; // Skip odd numbers
            }
            sum += num;
        }
        return sum;
    }
    
    public static void processValidEmails(List<String> emails) {
        for (String email : emails) {
            if (email == null || !email.contains('@')) {
                continue; // Skip invalid emails
            }
            System.debug('Processing: ' + email);
        }
    }
}

// Usage example (run in Execute Anonymous):
// List<Integer> nums = new List<Integer>{-2, 1, -3, 4, 5, -6};
// System.debug(ContinueExamples.filterPositives(nums)); // Output: (1, 4, 5)
// System.debug(ContinueExamples.sumEvenNumbers(nums)); // Output: 4 (only 4, -6 is negative so skipped)

```


Continue skips the current iteration's remaining code and moves to the next iteration.
It's perfect for filtering operations where you want to exclude certain elements from processing.

Reversing an array via looping

Reversing an array requires swapping elements from opposite ends until the middle is reached.
You can use a traditional for loop with indices to access elements from both ends.

## The loop continues until the start and end indices meet or cross.

This is a fundamental array manipulation technique.

```apex
public class ArrayReversal {
    public static List<Integer> reverseList(List<Integer> original) {
        List<Integer> reversed = new List<Integer>();
        for (Integer i = original.size() - 1; i >= 0; i--) {
            reversed.add(original[i]);
        }
        return reversed;
    }
    
    public static void reverseInPlace(List<Integer> list) {
        Integer start = 0;
        Integer end = list.size() - 1;
        while (start < end) {
            Integer temp = list[start];
            list[start] = list[end];
            list[end] = temp;
            start++;
            end--;
        }
    }
}

// Usage example (run in Execute Anonymous):
// List<Integer> nums = new List<Integer>{1, 2, 3, 4, 5};
// System.debug(ArrayReversal.reverseList(nums)); // Output: (5, 4, 3, 2, 1)
// ArrayReversal.reverseInPlace(nums);
// System.debug(nums); // Output: (5, 4, 3, 2, 1)

```


Reversing can be done by creating a new list in reverse order or by swapping elements in place.
The in-place method is more memory-efficient but modifies the original list.

Iterating backwards through a list


## Iterating backwards accesses list elements from the last index to the first.

This is useful when you need to process elements in reverse order or when removing elements during iteration.

## The loop starts at the last index (size - 1) and decrements to 0.

This pattern is essential for certain algorithms and data processing tasks.

```apex
public class BackwardIteration {
    public static void printReverse(List<String> items) {
        for (Integer i = items.size() - 1; i >= 0; i--) {
            System.debug(items[i]);
        }
    }
    
    public static List<String> reverseOrder(List<String> original) {
        List<String> result = new List<String>();
        for (Integer i = original.size() - 1; i >= 0; i--) {
            result.add(original[i]);
        }
        return result;
    }
    
    public static void removeFromEnd(List<Integer> numbers, Integer threshold) {
        for (Integer i = numbers.size() - 1; i >= 0; i--) {
            if (numbers[i] < threshold) {
                numbers.remove(i); // Safe to remove when iterating backwards
            }
        }
    }
}

// Usage example (run in Execute Anonymous):
// List<String> words = new List<String>{'apple', 'banana', 'cherry'};
// BackwardIteration.printReverse(words); // Output: cherry, banana, apple
// List<Integer> nums = new List<Integer>{1, 2, 3, 4, 5};
// BackwardIteration.removeFromEnd(nums, 3);
// System.debug(nums); // Output: (3, 4, 5)

```


Backward iteration is crucial when modifying lists during iteration, as it prevents index shifting issues.
Starting from the end ensures that removing elements doesn't affect the indices of unprocessed elements.


# 3. Data Handling

Arrays and Collections

Initializing and populating an array

Arrays in Apex are implemented as Lists, which are dynamic collections that can grow or shrink.
You can initialize lists with predefined values or create empty lists and add elements later.
Lists support various operations like adding, removing, and accessing elements by index.
They're the primary collection type in Apex for ordered data storage.

```apex
public class ArrayInitialization {
    public static void demonstrateInitialization() {
        // Method 1: Initialize with values
        List<Integer> numbers1 = new List<Integer>{1, 2, 3, 4, 5};
        
        // Method 2: Create empty list and populate
        List<String> names = new List<String>();
        names.add('Alice');
        names.add('Bob');
        names.add('Charlie');
        
        // Method 3: Initialize with size
        List<Decimal> prices = new List<Decimal>(3);
        prices[0] = 10.99;
        prices[1] = 20.50;
        prices[2] = 15.75;
        
        // Method 4: Populate using loop
        List<Integer> squares = new List<Integer>();
        for (Integer i = 1; i <= 5; i++) {
            squares.add(i * i);
        }
        
        System.debug('Numbers: ' + numbers1);
        System.debug('Names: ' + names);
        System.debug('Prices: ' + prices);
        System.debug('Squares: ' + squares);
    }
}

// Usage example (run in Execute Anonymous):
// ArrayInitialization.demonstrateInitialization();

```


## Lists in Apex are flexible and support multiple initialization patterns.

Choose the method that best fits your use case and data source.

Finding max/min in an array

Finding maximum and minimum values requires iterating through all elements and comparing them.

## You can use a loop to track the current max/min as you process each element.


## Initialize the max/min with the first element or a sentinel value.

This is a fundamental algorithm for data analysis and validation.

```apex
public class MinMaxFinder {
    public static Integer findMax(List<Integer> numbers) {
        if (numbers == null || numbers.isEmpty()) {
            return null;
        }
        Integer max = numbers[0];
        for (Integer num : numbers) {
            if (num > max) {
                max = num;
            }
        }
        return max;
    }
    
    public static Integer findMin(List<Integer> numbers) {
        if (numbers == null || numbers.isEmpty()) {
            return null;
        }
        Integer min = numbers[0];
        for (Integer num : numbers) {
            if (num < min) {
                min = num;
            }
        }
        return min;
    }
    
    public static Map<String, Integer> findMinMax(List<Integer> numbers) {
        Map<String, Integer> result = new Map<String, Integer>();
        if (numbers != null && !numbers.isEmpty()) {
            result.put('min', findMin(numbers));
            result.put('max', findMax(numbers));
        }
        return result;
    }
}

// Usage example (run in Execute Anonymous):
// List<Integer> nums = new List<Integer>{5, 2, 8, 1, 9, 3};
// System.debug('Max: ' + MinMaxFinder.findMax(nums)); // Output: Max: 9
// System.debug('Min: ' + MinMaxFinder.findMin(nums)); // Output: Min: 1

```


The algorithm compares each element against the current max/min, updating as needed.
This linear scan approach is efficient and straightforward for finding extremes.

Removing duplicates from a List<Integer>


## Removing duplicates ensures each value appears only once in the collection.

You can use a Set to automatically handle uniqueness, then convert back to a List.

## Alternatively, iterate through the list and manually track seen values.

Sets are the most efficient approach for duplicate removal.

```apex
public class DuplicateRemoval {
    public static List<Integer> removeDuplicatesUsingSet(List<Integer> numbers) {
        Set<Integer> uniqueSet = new Set<Integer>(numbers);
        return new List<Integer>(uniqueSet);
    }
    
    public static List<Integer> removeDuplicatesManual(List<Integer> numbers) {
        List<Integer> result = new List<Integer>();
        Set<Integer> seen = new Set<Integer>();
        
        for (Integer num : numbers) {
            if (!seen.contains(num)) {
                seen.add(num);
                result.add(num);
            }
        }
        return result;
    }
    
    public static List<String> removeDuplicateStrings(List<String> items) {
        Set<String> unique = new Set<String>(items);
        return new List<String>(unique);
    }
}

// Usage example (run in Execute Anonymous):
// List<Integer> nums = new List<Integer>{1, 2, 2, 3, 3, 3, 4, 5};
// System.debug(DuplicateRemoval.removeDuplicatesUsingSet(nums)); // Output: (1, 2, 3, 4, 5)

```


## Sets automatically enforce uniqueness, making them ideal for duplicate removal.

Converting a Set back to a List preserves the unique values while restoring list functionality.

Sorting a list of custom objects

Sorting custom objects requires implementing the Comparable interface or using a custom comparator.
The Comparable interface requires a compareTo method that defines the sorting logic.

## Objects can be sorted by any field or combination of fields.

This enables flexible data organization based on business requirements.

```apex
public class Student implements Comparable {
    public String name;
    public Integer age;
    public Decimal grade;
    
    public Student(String name, Integer age, Decimal grade) {
        this.name = name;
        this.age = age;
        this.grade = grade;
    }
    
    public Integer compareTo(Object obj) {
        Student other = (Student)obj;
        // Sort by grade (descending), then by name (ascending)
        if (this.grade != other.grade) {
            return this.grade > other.grade ? -1 : 1;
        }
        return this.name.compareTo(other.name);
    }
}

public class StudentSorter {
    public static List<Student> sortStudents(List<Student> students) {
        students.sort();
        return students;
    }
}

// Usage example (run in Execute Anonymous):
// List<Student> students = new List<Student>{
//     new Student('Alice', 20, 85.5),
//     new Student('Bob', 19, 90.0),
//     new Student('Charlie', 21, 85.5)
// };
// StudentSorter.sortStudents(students);
// for (Student s : students) {
//     System.debug(s.name + ': ' + s.grade);
// }

```


## The compareTo method returns -1, 0, or 1 to indicate ordering.

Implementing Comparable allows using the built-in sort() method on collections.

Using Map for key-value lookups (e.g., employeeId to Employee)

Maps provide efficient key-value storage and retrieval, ideal for lookups by unique identifiers.

## They enable O(1) average-case access time for finding values by key.

Maps are perfect for scenarios where you need to quickly find objects by ID or other unique attributes.
This pattern is fundamental for efficient data access in Apex.

```apex
public class Employee {
    public String employeeId;
    public String name;
    public String department;
    
    public Employee(String employeeId, String name, String department) {
        this.employeeId = employeeId;
        this.name = name;
        this.department = department;
    }
}

public class EmployeeLookup {
    public static Map<String, Employee> buildEmployeeMap(List<Employee> employees) {
        Map<String, Employee> employeeMap = new Map<String, Employee>();
        for (Employee emp : employees) {
            employeeMap.put(emp.employeeId, emp);
        }
        return employeeMap;
    }
    
    public static Employee findEmployee(Map<String, Employee> employeeMap, String employeeId) {
        return employeeMap.get(employeeId);
    }
}

// Usage example (run in Execute Anonymous):
// List<Employee> employees = new List<Employee>{
//     new Employee('E001', 'Alice Smith', 'Engineering'),
//     new Employee('E002', 'Bob Jones', 'Sales'),
//     new Employee('E003', 'Charlie Brown', 'Engineering')
// };
// Map<String, Employee> empMap = EmployeeLookup.buildEmployeeMap(employees);
// Employee found = EmployeeLookup.findEmployee(empMap, 'E002');
// System.debug(found.name); // Output: Bob Jones

```


## Maps provide fast lookup by key, making them ideal for ID-based searches.

They eliminate the need for linear searches through lists when looking up by identifier.

Using Set to ensure unique elements (e.g., collecting unique emails)

Sets automatically enforce uniqueness, preventing duplicate values from being stored.
They're ideal for collecting unique identifiers, emails, or any distinct values.

## Sets provide fast membership testing with contains() method.

Converting between Sets and Lists is straightforward in Apex.

```apex
public class UniqueEmailCollector {
    public static Set<String> collectUniqueEmails(List<String> emailList) {
        Set<String> uniqueEmails = new Set<String>();
        for (String email : emailList) {
            if (email != null && email.contains('@')) {
                uniqueEmails.add(email.toLowerCase()); // Normalize to lowercase
            }
        }
        return uniqueEmails;
    }
    
    public static Set<Integer> getUniqueIds(List<Account> accounts) {
        Set<Id> idSet = new Set<Id>();
        for (Account acc : accounts) {
            idSet.add(acc.Id);
        }
        return new Set<Integer>(); // Placeholder - would need conversion logic
    }
    
    public static Boolean hasDuplicates(List<String> items) {
        Set<String> unique = new Set<String>(items);
        return unique.size() < items.size();
    }
}

// Usage example (run in Execute Anonymous):
// List<String> emails = new List<String>{
//     'user@example.com',
//     'admin@example.com',
//     'user@example.com', // Duplicate
//     'test@example.com'
// };
// Set<String> unique = UniqueEmailCollector.collectUniqueEmails(emails);
// System.debug('Unique emails: ' + unique.size()); // Output: 3 (duplicate removed)

```


Sets automatically handle uniqueness, making them perfect for collecting distinct values.
They're more efficient than manually checking for duplicates in a list.

Working with List<Set<String>> for groupings

Nested collections like List<Set<String>> allow you to organize data into multiple groups.

## Each Set in the List represents a distinct group with unique elements.

This structure is useful for categorizing data or creating multiple distinct collections.
It enables complex data organization patterns.

```apex
public class GroupingExamples {
    public static List<Set<String>> groupByCategory(Map<String, String> itemCategoryMap) {
        Map<String, Set<String>> categoryGroups = new Map<String, Set<String>>();
        
        for (String item : itemCategoryMap.keySet()) {
            String category = itemCategoryMap.get(item);
            if (!categoryGroups.containsKey(category)) {
                categoryGroups.put(category, new Set<String>());
            }
            categoryGroups.get(category).add(item);
        }
        
        return new List<Set<String>>(categoryGroups.values());
    }
    
    public static List<Set<String>> createGroups() {
        List<Set<String>> groups = new List<Set<String>>();
        
        Set<String> group1 = new Set<String>{'apple', 'banana', 'orange'};
        Set<String> group2 = new Set<String>{'car', 'truck', 'bus'};
        Set<String> group3 = new Set<String>{'red', 'blue', 'green'};
        
        groups.add(group1);
        groups.add(group2);
        groups.add(group3);
        
        return groups;
    }
    
    public static void processGroups(List<Set<String>> groups) {
        for (Integer i = 0; i < groups.size(); i++) {
            System.debug('Group ' + (i + 1) + ': ' + groups[i]);
        }
    }
}

// Usage example (run in Execute Anonymous):
// List<Set<String>> groups = GroupingExamples.createGroups();
// GroupingExamples.processGroups(groups);

```


## Nested collections enable sophisticated data organization and grouping.

Each Set maintains uniqueness within its group while the List maintains the group structure.

Mapping product names to prices, updating values

Maps are ideal for associating names with prices, allowing easy lookup and updates.
You can update map values directly by key, making price changes straightforward.
Maps provide a natural structure for key-value relationships like product catalogs.
This pattern is common in e-commerce and inventory management systems.

```apex
public class ProductPriceManager {
    public static Map<String, Decimal> initializePrices() {
        Map<String, Decimal> prices = new Map<String, Decimal>();
        prices.put('Laptop', 999.99);
        prices.put('Mouse', 29.99);
        prices.put('Keyboard', 79.99);
        return prices;
    }
    
    public static void updatePrice(Map<String, Decimal> prices, String product, Decimal newPrice) {
        if (prices.containsKey(product)) {
            prices.put(product, newPrice);
            System.debug('Updated ' + product + ' price to $' + newPrice);
        } else {
            System.debug('Product not found: ' + product);
        }
    }
    
    public static void applyDiscount(Map<String, Decimal> prices, Decimal discountPercent) {
        for (String product : prices.keySet()) {
            Decimal currentPrice = prices.get(product);
            Decimal discountedPrice = currentPrice * (1 - discountPercent / 100);
            prices.put(product, discountedPrice);
        }
    }
}

// Usage example (run in Execute Anonymous):
// Map<String, Decimal> prices = ProductPriceManager.initializePrices();
// ProductPriceManager.updatePrice(prices, 'Laptop', 899.99);
// ProductPriceManager.applyDiscount(prices, 10); // 10% discount
// System.debug('Laptop price: $' + prices.get('Laptop'));

```


## Maps allow direct updates by key, making price management efficient.

You can update individual prices or apply bulk operations across all products.

Iterating over a map's keys/values


## Maps provide multiple ways to iterate: by keys, values, or key-value pairs.

The keySet() method returns all keys, values() returns all values, and you can access both.
Iteration order in Apex maps is not guaranteed unless using ordered collections.
This flexibility enables various data processing patterns.

```apex
public class MapIteration {
    public static void iterateByKeys(Map<String, Integer> scores) {
        for (String key : scores.keySet()) {
            System.debug(key + ': ' + scores.get(key));
        }
    }
    
    public static void iterateByValues(Map<String, Integer> scores) {
        for (Integer value : scores.values()) {
            System.debug('Score: ' + value);
        }
    }
    
    public static void iterateKeyValuePairs(Map<String, Decimal> prices) {
        for (String product : prices.keySet()) {
            Decimal price = prices.get(product);
            System.debug(product + ' costs $' + price);
        }
    }
    
    public static Integer sumAllValues(Map<String, Integer> data) {
        Integer sum = 0;
        for (Integer value : data.values()) {
            sum += value;
        }
        return sum;
    }
}

// Usage example (run in Execute Anonymous):
// Map<String, Integer> scores = new Map<String, Integer>{
//     'Alice' => 95,
//     'Bob' => 87,
//     'Charlie' => 92
// };
// MapIteration.iterateByKeys(scores);
// System.debug('Total: ' + MapIteration.sumAllValues(scores));

```


Different iteration methods serve different purposes: keys for lookups, values for aggregations.
Choose the iteration method that best fits your processing needs.

Data Cleaning and Transformation

Removing nulls from a list


## Null values can cause errors and should be filtered out before processing.


## You can iterate through a list and collect only non-null values.


## Alternatively, use list methods to remove nulls efficiently.

This is essential for data quality and preventing NullPointerException errors.

```apex
public class NullRemoval {
    public static List<String> removeNulls(List<String> items) {
        List<String> cleaned = new List<String>();
        for (String item : items) {
            if (item != null) {
                cleaned.add(item);
            }
        }
        return cleaned;
    }
    
    public static List<Integer> removeNullIntegers(List<Integer> numbers) {
        List<Integer> result = new List<Integer>();
        for (Integer num : numbers) {
            if (num != null) {
                result.add(num);
            }
        }
        return result;
    }
    
    public static List<Account> removeNullAccounts(List<Account> accounts) {
        List<Account> validAccounts = new List<Account>();
        for (Account acc : accounts) {
            if (acc != null && acc.Name != null) {
                validAccounts.add(acc);
            }
        }
        return validAccounts;
    }
}

// Usage example (run in Execute Anonymous):
// List<String> data = new List<String>{'apple', null, 'banana', null, 'cherry'};
// System.debug(NullRemoval.removeNulls(data)); // Output: (apple, banana, cherry)

```


## Removing nulls prevents errors and ensures data integrity.

Always check for null before processing to avoid runtime exceptions.

Standardizing string case across a list (e.g., making all uppercase)


## Standardizing case ensures consistent data formatting across a collection.


## You can use toUpperCase() or toLowerCase() methods to transform strings.


## This is important for comparisons, searches, and data consistency.

Case standardization is a common data cleaning operation.

```apex
public class CaseStandardization {
    public static List<String> toUpperCase(List<String> items) {
        List<String> upper = new List<String>();
        for (String item : items) {
            if (item != null) {
                upper.add(item.toUpperCase());
            }
        }
        return upper;
    }
    
    public static List<String> toLowerCase(List<String> items) {
        List<String> lower = new List<String>();
        for (String item : items) {
            if (item != null) {
                lower.add(item.toLowerCase());
            }
        }
        return lower;
    }
    
    public static List<String> capitalizeFirst(List<String> items) {
        List<String> capitalized = new List<String>();
        for (String item : items) {
            if (item != null && item.length() > 0) {
                String first = item.substring(0, 1).toUpperCase();
                String rest = item.length() > 1 ? item.substring(1).toLowerCase() : '';
                capitalized.add(first + rest);
            }
        }
        return capitalized;
    }
}

// Usage example (run in Execute Anonymous):
// List<String> names = new List<String>{'alice', 'BOB', 'Charlie'};
// System.debug(CaseStandardization.toUpperCase(names)); // Output: (ALICE, BOB, CHARLIE)
// System.debug(CaseStandardization.capitalizeFirst(names)); // Output: (Alice, Bob, Charlie)

```


## Case standardization ensures consistent formatting for comparisons and display.

Choose the case format that matches your business requirements.

Filtering items based on conditions (e.g., extracting valid emails)


## Filtering extracts elements that meet specific criteria from a collection.


## You iterate through the collection and add items that pass the condition.


## This is fundamental for data validation and extraction.

Filtering enables focused processing of relevant data.

```apex
public class DataFiltering {
    public static List<String> extractValidEmails(List<String> emails) {
        List<String> valid = new List<String>();
        for (String email : emails) {
            if (email != null && email.contains('@') && email.contains('.')) {
                valid.add(email);
            }
        }
        return valid;
    }
    
    public static List<Integer> filterEvenNumbers(List<Integer> numbers) {
        List<Integer> evens = new List<Integer>();
        for (Integer num : numbers) {
            if (num != null && Math.mod(num, 2) == 0) {
                evens.add(num);
            }
        }
        return evens;
    }
    
    public static List<String> filterByLength(List<String> items, Integer minLength) {
        List<String> filtered = new List<String>();
        for (String item : items) {
            if (item != null && item.length() >= minLength) {
                filtered.add(item);
            }
        }
        return filtered;
    }
}

// Usage example (run in Execute Anonymous):
// List<String> emails = new List<String>{
//     'valid@example.com',
//     'invalid-email',
//     'another@test.com'
// };
// System.debug(DataFiltering.extractValidEmails(emails)); // Output: (valid@example.com, another@test.com)

```


## Filtering extracts only elements that meet your criteria.

This reduces data volume and focuses processing on relevant items.

Parsing a comma-separated string into a list


## Parsing splits a delimited string into individual elements stored in a list.


## The split() method divides a string based on a delimiter character.


## This is essential for processing CSV data or user input.

Parsing enables conversion from string format to structured collections.

```apex
public class StringParsing {
    public static List<String> parseCommaSeparated(String csvString) {
        if (csvString == null || csvString.trim().length() == 0) {
            return new List<String>();
        }
        return csvString.split(',');
    }
    
    public static List<String> parseWithTrim(String csvString) {
        List<String> result = new List<String>();
        if (csvString != null) {
            List<String> parts = csvString.split(',');
            for (String part : parts) {
                result.add(part.trim());
            }
        }
        return result;
    }
    
    public static List<Integer> parseIntegers(String numberString) {
        List<Integer> numbers = new List<Integer>();
        if (numberString != null) {
            List<String> parts = numberString.split(',');
            for (String part : parts) {
                try {
                    numbers.add(Integer.valueOf(part.trim()));
                } catch (Exception e) {
                    // Skip invalid numbers
                }
            }
        }
        return numbers;
    }
}

// Usage example (run in Execute Anonymous):
// String csv = 'apple, banana, cherry, date';
// System.debug(StringParsing.parseWithTrim(csv)); // Output: (apple, banana, cherry, date)
// String numbers = '1, 2, 3, 4, 5';
// System.debug(StringParsing.parseIntegers(numbers)); // Output: (1, 2, 3, 4, 5)

```


## The split() method divides strings based on delimiters.

Always handle null strings and trim whitespace for clean parsing.

Joining a list back into a single string


## Joining combines list elements into a single string with a delimiter.

Apex provides the String.join() method for this purpose.

## You can also manually concatenate with custom delimiters.

Joining is the inverse operation of parsing.

```apex
public class StringJoining {
    public static String joinWithComma(List<String> items) {
        return String.join(items, ', ');
    }
    
    public static String joinWithDelimiter(List<String> items, String delimiter) {
        if (items == null || items.isEmpty()) {
            return '';
        }
        String result = items[0];
        for (Integer i = 1; i < items.size(); i++) {
            result += delimiter + items[i];
        }
        return result;
    }
    
    public static String joinNumbers(List<Integer> numbers, String separator) {
        List<String> strings = new List<String>();
        for (Integer num : numbers) {
            strings.add(String.valueOf(num));
        }
        return String.join(strings, separator);
    }
}

// Usage example (run in Execute Anonymous):
// List<String> fruits = new List<String>{'apple', 'banana', 'cherry'};
// System.debug(StringJoining.joinWithComma(fruits)); // Output: apple, banana, cherry
// System.debug(StringJoining.joinNumbers(new List<Integer>{1, 2, 3}, '|')); // Output: 1|2|3

```


String.join() provides efficient concatenation with delimiters.
Manual joining gives more control over formatting and edge cases.

Replacing or updating records in a collection


## Updating records in a collection requires finding the target and modifying it.

You can iterate and update in place, or create a new collection with modifications.

## Maps allow direct updates by key, while lists require iteration.

This enables data transformation and correction operations.

```apex
public class CollectionUpdates {
    public static List<String> replaceInList(List<String> items, String oldValue, String newValue) {
        List<String> updated = new List<String>();
        for (String item : items) {
            if (item == oldValue) {
                updated.add(newValue);
            } else {
                updated.add(item);
            }
        }
        return updated;
    }
    
    public static void updateInPlace(List<String> items, String oldValue, String newValue) {
        for (Integer i = 0; i < items.size(); i++) {
            if (items[i] == oldValue) {
                items[i] = newValue;
            }
        }
    }
    
    public static Map<String, Decimal> updatePrices(Map<String, Decimal> prices, Decimal multiplier) {
        for (String product : prices.keySet()) {
            prices.put(product, prices.get(product) * multiplier);
        }
        return prices;
    }
}

// Usage example (run in Execute Anonymous):
// List<String> items = new List<String>{'apple', 'banana', 'apple'};
// CollectionUpdates.updateInPlace(items, 'apple', 'orange');
// System.debug(items); // Output: (orange, banana, orange)

```


In-place updates modify the original collection, while creating new collections preserves originals.
Choose the approach based on whether you need to preserve the original data.

Converting lists to sets and vice versa

Converting between Lists and Sets changes the collection type and enforces/removes uniqueness.
Lists maintain order and allow duplicates; Sets enforce uniqueness but don't guarantee order.
Conversions are straightforward using constructors that accept the other collection type.
This enables switching between ordered and unique collection behaviors.

```apex
public class CollectionConversion {
    public static Set<String> listToSet(List<String> items) {
        return new Set<String>(items);
    }
    
    public static List<String> setToList(Set<String> items) {
        return new List<String>(items);
    }
    
    public static Set<Integer> listToSetWithDeduplication(List<Integer> numbers) {
        Set<Integer> unique = new Set<Integer>(numbers);
        return unique;
    }
    
    public static List<String> setToListPreservingOrder(Set<String> items) {
        // Note: Sets don't guarantee order, but conversion creates a list
        return new List<String>(items);
    }
}

// Usage example (run in Execute Anonymous):
// List<String> withDups = new List<String>{'a', 'b', 'a', 'c'};
// Set<String> unique = CollectionConversion.listToSet(withDups);
// System.debug(unique); // Output: {a, b, c} (duplicates removed)
// List<String> backToList = CollectionConversion.setToList(unique);
// System.debug(backToList);

```


Conversions automatically handle uniqueness: List to Set removes duplicates, Set to List preserves unique values.
Use conversions when you need to switch between ordered and unique collection behaviors.

Aggregating quantities by category (custom tallying)

Aggregation groups data by category and calculates totals, counts, or other metrics.

## You can use Maps to track totals per category efficiently.


## This pattern is essential for reporting and data analysis.

Aggregation enables summary statistics from detailed data.

```apex
public class Product {
    public String name;
    public String category;
    public Integer quantity;
    
    public Product(String name, String category, Integer quantity) {
        this.name = name;
        this.category = category;
        this.quantity = quantity;
    }
}

public class AggregationExamples {
    public static Map<String, Integer> aggregateByCategory(List<Product> products) {
        Map<String, Integer> categoryTotals = new Map<String, Integer>();
        
        for (Product prod : products) {
            if (categoryTotals.containsKey(prod.category)) {
                categoryTotals.put(prod.category, 
                    categoryTotals.get(prod.category) + prod.quantity);
            } else {
                categoryTotals.put(prod.category, prod.quantity);
            }
        }
        
        return categoryTotals;
    }
    
    public static Map<String, Integer> countByCategory(List<Product> products) {
        Map<String, Integer> categoryCounts = new Map<String, Integer>();
        
        for (Product prod : products) {
            Integer count = categoryCounts.get(prod.category);
            categoryCounts.put(prod.category, count == null ? 1 : count + 1);
        }
        
        return categoryCounts;
    }
}

// Usage example (run in Execute Anonymous):
// List<Product> products = new List<Product>{
//     new Product('Laptop', 'Electronics', 5),
//     new Product('Mouse', 'Electronics', 10),
//     new Product('Desk', 'Furniture', 3)
// };
// Map<String, Integer> totals = AggregationExamples.aggregateByCategory(products);
// System.debug(totals); // Output: {Electronics=15, Furniture=3}

```


## Maps efficiently track aggregations by category using keys.

This pattern scales well for large datasets and multiple categories.

Aligning two lists by value (merge join)


## Merging aligns two lists based on matching values, combining related data.


## You can use nested loops or Maps for efficient merging.


## Maps provide O(1) lookup, making them ideal for large datasets.

This pattern is fundamental for data integration and joins.

```apex
public class MergeJoin {
    public static List<String> mergeByValue(List<String> list1, List<String> list2) {
        List<String> merged = new List<String>();
        Set<String> seen = new Set<String>();
        
        // Add all from first list
        for (String item : list1) {
            if (!seen.contains(item)) {
                merged.add(item);
                seen.add(item);
            }
        }
        
        // Add from second list if not already present
        for (String item : list2) {
            if (!seen.contains(item)) {
                merged.add(item);
                seen.add(item);
            }
        }
        
        return merged;
    }
    
    public static Map<String, String> joinByKey(
        List<String> keys, 
        List<String> values
    ) {
        Map<String, String> result = new Map<String, String>();
        Integer minSize = Math.min(keys.size(), values.size());
        
        for (Integer i = 0; i < minSize; i++) {
            result.put(keys[i], values[i]);
        }
        
        return result;
    }
}

// Usage example (run in Execute Anonymous):
// List<String> list1 = new List<String>{'a', 'b', 'c'};
// List<String> list2 = new List<String>{'b', 'c', 'd'};
// System.debug(MergeJoin.mergeByValue(list1, list2)); // Output: (a, b, c, d)

```


## Merging combines data from multiple sources based on matching criteria.

Use Maps for efficient lookups when aligning large datasets.

Detecting palindrome strings in a list


## Palindromes read the same forwards and backwards, like "radar" or "level".


## You can check by comparing characters from both ends moving toward the center.


## This is a common string manipulation and validation task.

Detecting palindromes demonstrates reverse string comparison techniques.

```apex
public class PalindromeDetection {
    public static Boolean isPalindrome(String str) {
        if (str == null || str.length() == 0) {
            return false;
        }
        
        String normalized = str.toLowerCase().replaceAll(' ', '');
        Integer left = 0;
        Integer right = normalized.length() - 1;
        
        while (left < right) {
            if (normalized.charAt(left) != normalized.charAt(right)) {
                return false;
            }
            left++;
            right--;
        }
        
        return true;
    }
    
    public static List<String> findPalindromes(List<String> words) {
        List<String> palindromes = new List<String>();
        for (String word : words) {
            if (isPalindrome(word)) {
                palindromes.add(word);
            }
        }
        return palindromes;
    }
    
    public static Boolean isPalindromeUsingReverse(String str) {
        if (str == null) {
            return false;
        }
        String normalized = str.toLowerCase().replaceAll(' ', '');
        String reversed = normalized.reverse();
        return normalized == reversed;
    }
}

// Usage example (run in Execute Anonymous):
// List<String> words = new List<String>{'radar', 'hello', 'level', 'world'};
// System.debug(PalindromeDetection.findPalindromes(words)); // Output: (radar, level)

```


## Palindrome detection compares characters from both ends or reverses the string.

Normalize input (lowercase, remove spaces) for accurate detection.


# 4. Object Creation and Record Management

Object Instantiation

Basic SObject creation (e.g., Account a = new Account(Name='Test');)

SObjects represent Salesforce records and are created using the new keyword with field initialization.
You can set fields during creation using the constructor-like syntax with field assignments.
This is the fundamental way to create new records before inserting them into the database.
SObject creation is the first step in the DML operation workflow.

```apex
public class SObjectCreation {
    public static Account createBasicAccount() {
        Account acc = new Account();
        acc.Name = 'Test Account';
        return acc;
    }
    
    public static Account createAccountInline() {
        Account acc = new Account(Name = 'Test Account');
        return acc;
    }
    
    public static Contact createContact() {
        Contact con = new Contact(
            FirstName = 'John',
            LastName = 'Doe',
            Email = 'john.doe@example.com'
        );
        return con;
    }
}

// Usage example (run in Execute Anonymous):
// Account acc = SObjectCreation.createAccountInline();
// System.debug('Account Name: ' + acc.Name);

```


## SObject creation initializes a record in memory before database insertion.

You can set fields during creation or assign them afterward.

Parameterized initialization of multiple fields

Parameterized initialization sets multiple fields during SObject creation in a single statement.

## This approach is cleaner and more concise than setting fields individually.


## It's ideal when you have all field values available at creation time.

This pattern improves code readability and reduces lines of code.

```apex
public class ParameterizedSObjectCreation {
    public static Account createFullAccount(String name, String industry, String phone) {
        Account acc = new Account(
            Name = name,
            Industry = industry,
            Phone = phone,
            BillingCity = 'San Francisco',
            BillingState = 'CA'
        );
        return acc;
    }
    
    public static Opportunity createOpportunity(String name, Decimal amount, Date closeDate) {
        Opportunity opp = new Opportunity(
            Name = name,
            Amount = amount,
            CloseDate = closeDate,
            StageName = 'Prospecting'
        );
        return opp;
    }
}

// Usage example (run in Execute Anonymous):
// Account acc = ParameterizedSObjectCreation.createFullAccount(
//     'Acme Corp', 'Technology', '555-1234'
// );
// System.debug('Created: ' + acc.Name + ' in ' + acc.Industry);

```


## Parameterized initialization sets multiple fields in one statement.

This approach is efficient and makes field assignments clear and organized.

Populating a list with several SObjects

Populating lists with multiple SObjects enables bulk operations and efficient data handling.

## You can create SObjects in a loop or initialize the list with multiple objects.


## Lists of SObjects are required for bulk DML operations.

This pattern is essential for processing multiple records efficiently.

```apex
public class BulkSObjectCreation {
    public static List<Account> createMultipleAccounts() {
        List<Account> accounts = new List<Account>();
        
        accounts.add(new Account(Name = 'Account 1', Industry = 'Tech'));
        accounts.add(new Account(Name = 'Account 2', Industry = 'Finance'));
        accounts.add(new Account(Name = 'Account 3', Industry = 'Healthcare'));
        
        return accounts;
    }
    
    public static List<Contact> createContactsFromData(List<String> names) {
        List<Contact> contacts = new List<Contact>();
        
        for (String fullName : names) {
            List<String> nameParts = fullName.split(' ');
            Contact con = new Contact(
                FirstName = nameParts.size() > 0 ? nameParts[0] : '',
                LastName = nameParts.size() > 1 ? nameParts[1] : ''
            );
            contacts.add(con);
        }
        
        return contacts;
    }
    
    public static List<Account> createAccountsInLoop(Integer count) {
        List<Account> accounts = new List<Account>();
        
        for (Integer i = 1; i <= count; i++) {
            accounts.add(new Account(Name = 'Account ' + i));
        }
        
        return accounts;
    }
}

// Usage example (run in Execute Anonymous):
// List<Account> accounts = BulkSObjectCreation.createMultipleAccounts();
// System.debug('Created ' + accounts.size() + ' accounts');

```


## Lists enable bulk creation and processing of multiple SObjects.

This pattern is essential for efficient bulk DML operations in Apex.

Cloning/copying records programmatically

Cloning creates copies of existing SObjects, useful for duplicating records or creating templates.

## Apex provides the clone() method for SObjects, which creates a shallow copy.

You can clone with or without IDs, depending on whether you want to create new records.
Cloning is efficient for creating similar records with modifications.

```apex
public class SObjectCloning {
    public static Account cloneAccount(Account original) {
        // Clone without ID to create a new record
        Account cloned = original.clone(false, true, false, false);
        cloned.Name = original.Name + ' - Copy';
        return cloned;
    }
    
    public static List<Contact> cloneContacts(List<Contact> originals) {
        List<Contact> clones = new List<Contact>();
        
        for (Contact original : originals) {
            Contact cloned = original.clone(false, true, false, false);
            cloned.Email = null; // Clear email for new contact
            clones.add(cloned);
        }
        
        return clones;
    }
    
    public static Opportunity cloneOpportunityWithChanges(Opportunity original, Decimal newAmount) {
        Opportunity cloned = original.clone(false, true, false, false);
        cloned.Amount = newAmount;
        cloned.CloseDate = Date.today().addDays(30);
        cloned.StageName = 'Prospecting';
        return cloned;
    }
}

// Usage example (run in Execute Anonymous):
// Account original = new Account(Name = 'Original Account');
// Account copy = SObjectCloning.cloneAccount(original);
// System.debug('Cloned: ' + copy.Name);

```


The clone() method parameters control what gets copied: preserveId, isDeepClone, preserveReadonlyTimestamps, preserveAutonumber.
Use cloning to efficiently create similar records with modifications.

Bulk creation using for loop


## Bulk creation uses loops to generate multiple SObjects efficiently.

This pattern is essential when creating records based on data sources or calculations.

## Loops enable dynamic record creation based on runtime conditions.

Bulk creation is the foundation of efficient data processing in Apex.

```apex
public class BulkCreationWithLoop {
    public static List<Account> createAccountsFromNames(List<String> accountNames) {
        List<Account> accounts = new List<Account>();
        
        for (String name : accountNames) {
            Account acc = new Account(Name = name);
            accounts.add(acc);
        }
        
        return accounts;
    }
    
    public static List<Opportunity> createOpportunitiesForAccount(Id accountId, Integer count) {
        List<Opportunity> opportunities = new List<Opportunity>();
        Date baseDate = Date.today();
        
        for (Integer i = 1; i <= count; i++) {
            Opportunity opp = new Opportunity(
                Name = 'Opportunity ' + i,
                AccountId = accountId,
                Amount = 1000 * i,
                CloseDate = baseDate.addDays(30 * i),
                StageName = 'Prospecting'
            );
            opportunities.add(opp);
        }
        
        return opportunities;
    }
    
    public static List<Contact> createContactsBulk(Integer numberOfContacts) {
        List<Contact> contacts = new List<Contact>();
        
        for (Integer i = 1; i <= numberOfContacts; i++) {
            Contact con = new Contact(
                FirstName = 'Contact',
                LastName = 'Number ' + i,
                Email = 'contact' + i + '@example.com'
            );
            contacts.add(con);
        }
        
        return contacts;
    }
}

// Usage example (run in Execute Anonymous):
// List<String> names = new List<String>{'Acme', 'Beta', 'Gamma'};
// List<Account> accounts = BulkCreationWithLoop.createAccountsFromNames(names);
// System.debug('Created ' + accounts.size() + ' accounts');

```


## Loops enable efficient bulk creation from various data sources.

This pattern scales well for creating large numbers of records.

SOQL Queries

Query with WHERE clause for single-criteria filtering


## WHERE clauses filter SOQL query results based on specified conditions.


## Single-criteria filtering uses one condition to narrow results.


## This is the most common query pattern for finding specific records.

WHERE clauses make queries efficient by limiting the result set.

```apex
public class SOQLFiltering {
    public static List<Account> getAccountsByIndustry(String industry) {
        return [SELECT Id, Name, Industry FROM Account WHERE Industry = :industry];
    }
    
    public static List<Contact> getContactsByEmail(String email) {
        return [SELECT Id, FirstName, LastName, Email FROM Contact WHERE Email = :email];
    }
    
    public static List<Opportunity> getOpportunitiesByStage(String stage) {
        return [SELECT Id, Name, StageName, Amount FROM Opportunity WHERE StageName = :stage];
    }
    
    public static Account getAccountByName(String accountName) {
        List<Account> accounts = [SELECT Id, Name FROM Account WHERE Name = :accountName LIMIT 1];
        return accounts.isEmpty() ? null : accounts[0];
    }
}

// Usage example (run in Execute Anonymous):
// List<Account> techAccounts = SOQLFiltering.getAccountsByIndustry('Technology');
// System.debug('Found ' + techAccounts.size() + ' technology accounts');

```


## WHERE clauses use bind variables (:variable) for safe parameterized queries.

Always use bind variables to prevent SOQL injection and improve performance.

ORDER BY ascending/descending on a field

ORDER BY sorts query results in ascending or descending order based on specified fields.

## ASC sorts from lowest to highest, DESC from highest to lowest.


## You can sort by multiple fields for complex ordering requirements.

Sorting is essential for presenting data in meaningful sequences.

```apex
public class SOQLSorting {
    public static List<Account> getAccountsSortedByName() {
        return [SELECT Id, Name, Industry FROM Account ORDER BY Name ASC];
    }
    
    public static List<Opportunity> getOpportunitiesByAmountDesc() {
        return [SELECT Id, Name, Amount, CloseDate FROM Opportunity 
                ORDER BY Amount DESC];
    }
    
    public static List<Contact> getContactsSortedByLastNameThenFirstName() {
        return [SELECT Id, FirstName, LastName FROM Contact 
                ORDER BY LastName ASC, FirstName ASC];
    }
    
    public static List<Account> getAccountsByCreatedDate() {
        return [SELECT Id, Name, CreatedDate FROM Account 
                ORDER BY CreatedDate DESC];
    }
}

// Usage example (run in Execute Anonymous):
// List<Account> sorted = SOQLSorting.getAccountsSortedByName();
// for (Account acc : sorted) {
//     System.debug(acc.Name);
// }

```


## ORDER BY enables predictable result ordering for display and processing.

Multiple fields in ORDER BY create hierarchical sorting (primary, secondary, etc.).

Limiting results with LIMIT


## LIMIT restricts the number of records returned by a SOQL query.


## This is essential for performance and preventing governor limit issues.


## LIMIT is particularly important for queries that might return many records.

Always use LIMIT when you only need a subset of results.

```apex
public class SOQLLimiting {
    public static List<Account> getTopAccounts(Integer limitCount) {
        return [SELECT Id, Name, AnnualRevenue FROM Account 
                WHERE AnnualRevenue != null 
                ORDER BY AnnualRevenue DESC 
                LIMIT :limitCount];
    }
    
    public static Account getLatestAccount() {
        List<Account> accounts = [SELECT Id, Name, CreatedDate FROM Account 
                                   ORDER BY CreatedDate DESC LIMIT 1];
        return accounts.isEmpty() ? null : accounts[0];
    }
    
    public static List<Contact> getRecentContacts(Integer days) {
        Date cutoffDate = Date.today().addDays(-days);
        return [SELECT Id, FirstName, LastName, CreatedDate FROM Contact 
                WHERE CreatedDate >= :cutoffDate 
                ORDER BY CreatedDate DESC LIMIT 100];
    }
}

// Usage example (run in Execute Anonymous):
// List<Account> top5 = SOQLLimiting.getTopAccounts(5);
// System.debug('Top 5 accounts: ' + top5.size());

```


## LIMIT prevents excessive data retrieval and improves query performance.

Combine LIMIT with ORDER BY to get the most relevant records.

Combining multiple criteria in WHERE


## Multiple WHERE criteria use AND/OR operators to create complex filters.


## AND requires all conditions to be true; OR requires at least one to be true.


## Parentheses group conditions for complex logic.

This enables sophisticated data filtering for business requirements.

```apex
public class ComplexSOQLFilters {
    public static List<Account> getAccountsByIndustryAndRevenue(String industry, Decimal minRevenue) {
        return [SELECT Id, Name, Industry, AnnualRevenue FROM Account 
                WHERE Industry = :industry AND AnnualRevenue >= :minRevenue];
    }
    
    public static List<Opportunity> getOpportunitiesByStageOrAmount(String stage, Decimal minAmount) {
        return [SELECT Id, Name, StageName, Amount FROM Opportunity 
                WHERE StageName = :stage OR Amount >= :minAmount];
    }
    
    public static List<Contact> getContactsByMultipleCriteria(String lastName, String city) {
        return [SELECT Id, FirstName, LastName, MailingCity FROM Contact 
                WHERE LastName = :lastName AND MailingCity = :city];
    }
    
    public static List<Account> getAccountsComplexFilter(String industry, Decimal minRevenue, String state) {
        return [SELECT Id, Name, Industry, AnnualRevenue, BillingState FROM Account 
                WHERE (Industry = :industry OR AnnualRevenue >= :minRevenue) 
                AND BillingState = :state];
    }
}

// Usage example (run in Execute Anonymous):
// List<Account> filtered = ComplexSOQLFilters.getAccountsByIndustryAndRevenue('Technology', 1000000);
// System.debug('Found ' + filtered.size() + ' matching accounts');

```


## Complex WHERE clauses enable precise data filtering.

Use parentheses to control operator precedence and create clear logic.

Aggregate SOQL: COUNT(), SUM(), etc.

Aggregate functions perform calculations across multiple records in SOQL queries.

## Common functions include COUNT(), SUM(), AVG(), MAX(), MIN().


## Aggregate queries return AggregateResult objects instead of SObjects.

This enables efficient data analysis without processing individual records.

```apex
public class AggregateSOQL {
    public static Integer getAccountCount() {
        AggregateResult result = [SELECT COUNT() total FROM Account];
        return (Integer)result.get('total');
    }
    
    public static Decimal getTotalOpportunityAmount() {
        AggregateResult result = [SELECT SUM(Amount) total FROM Opportunity WHERE Amount != null];
        return (Decimal)result.get('total');
    }
    
    public static Map<String, Integer> getAccountCountByIndustry() {
        Map<String, Integer> industryCounts = new Map<String, Integer>();
        List<AggregateResult> results = [
            SELECT Industry, COUNT(Id) total 
            FROM Account 
            WHERE Industry != null 
            GROUP BY Industry
        ];
        
        for (AggregateResult ar : results) {
            industryCounts.put((String)ar.get('Industry'), (Integer)ar.get('total'));
        }
        
        return industryCounts;
    }
    
    public static Decimal getAverageOpportunityAmount() {
        AggregateResult result = [SELECT AVG(Amount) avgAmount FROM Opportunity WHERE Amount != null];
        return (Decimal)result.get('avgAmount');
    }
}

// Usage example (run in Execute Anonymous):
// System.debug('Total accounts: ' + AggregateSOQL.getAccountCount());
// Map<String, Integer> counts = AggregateSOQL.getAccountCountByIndustry();
// System.debug('Accounts by industry: ' + counts);

```


## Aggregate queries return AggregateResult objects accessed via get() method.

GROUP BY enables aggregation by categories, providing summary statistics.

Using IN clause for batch queries


## IN clauses allow filtering by multiple values in a single query.


## This is more efficient than multiple queries or complex OR conditions.


## IN works with lists, sets, or subqueries.

This pattern is essential for batch processing and bulk operations.

```apex
public class INClauseQueries {
    public static List<Account> getAccountsByIds(List<Id> accountIds) {
        return [SELECT Id, Name FROM Account WHERE Id IN :accountIds];
    }
    
    public static List<Contact> getContactsByAccountNames(List<String> accountNames) {
        return [SELECT Id, FirstName, LastName, Account.Name FROM Contact 
                WHERE Account.Name IN :accountNames];
    }
    
    public static List<Opportunity> getOpportunitiesByStages(Set<String> stages) {
        return [SELECT Id, Name, StageName FROM Opportunity WHERE StageName IN :stages];
    }
    
    public static List<Contact> getContactsForAccounts() {
        // Subquery in IN clause
        return [SELECT Id, FirstName, LastName FROM Contact 
                WHERE AccountId IN (SELECT Id FROM Account WHERE Industry = 'Technology')];
    }
}

// Usage example (run in Execute Anonymous):
// List<Id> ids = new List<Id>{'001xx000003DGbQAAW', '001xx000003DGbRAAW'};
// List<Account> accounts = INClauseQueries.getAccountsByIds(ids);
// System.debug('Found ' + accounts.size() + ' accounts');

```


## IN clauses efficiently filter by multiple values in a single query.

They're ideal for batch operations and reduce the number of queries needed.

Subquery for related data (parent-child)

Subqueries retrieve related records in a single query, accessing child or parent relationships.

## Parent-child relationships use relationship names in SOQL syntax.


## This eliminates the need for multiple queries and improves performance.

Subqueries enable efficient access to related data hierarchies.

```apex
public class SubqueryExamples {
    public static List<Account> getAccountsWithContacts() {
        return [SELECT Id, Name, 
                (SELECT Id, FirstName, LastName FROM Contacts) 
                FROM Account];
    }
    
    public static List<Account> getAccountsWithOpportunities() {
        return [SELECT Id, Name, 
                (SELECT Id, Name, Amount, StageName FROM Opportunities) 
                FROM Account];
    }
    
    public static List<Contact> getContactsWithAccountInfo() {
        return [SELECT Id, FirstName, LastName, 
                Account.Id, Account.Name, Account.Industry 
                FROM Contact 
                WHERE AccountId != null];
    }
    
    public static List<Opportunity> getOpportunitiesWithAccountDetails() {
        return [SELECT Id, Name, Amount, 
                Account.Id, Account.Name, Account.Industry 
                FROM Opportunity];
    }
}

// Usage example (run in Execute Anonymous):
// List<Account> accounts = SubqueryExamples.getAccountsWithContacts();
// for (Account acc : accounts) {
//     System.debug(acc.Name + ' has ' + acc.Contacts.size() + ' contacts');
// }

```


Subqueries access related records using relationship names (Contacts, Opportunities).
Parent fields are accessed via dot notation (Account.Name).
This enables efficient retrieval of hierarchical data in one query.

Dynamic SOQL: constructing queries programmatically


## Dynamic SOQL builds queries at runtime using string concatenation.


## This enables flexible query construction based on runtime conditions.


## Use bind variables with dynamic SOQL for security and performance.

Dynamic SOQL is powerful but requires careful construction to avoid errors.

```apex
public class DynamicSOQL {
    public static List<Account> buildDynamicQuery(String industry, Decimal minRevenue) {
        String query = 'SELECT Id, Name, Industry, AnnualRevenue FROM Account WHERE 1=1';
        
        if (industry != null) {
            query += ' AND Industry = :industry';
        }
        
        if (minRevenue != null) {
            query += ' AND AnnualRevenue >= :minRevenue';
        }
        
        return Database.query(query);
    }
    
    public static List<SObject> dynamicQueryWithFields(String objectType, List<String> fields, String whereClause) {
        String fieldList = String.join(fields, ', ');
        String query = 'SELECT ' + fieldList + ' FROM ' + objectType;
        
        if (whereClause != null && whereClause.length() > 0) {
            query += ' WHERE ' + whereClause;
        }
        
        return Database.query(query);
    }
    
    public static List<Account> searchAccounts(String searchTerm) {
        String query = 'SELECT Id, Name FROM Account WHERE Name LIKE \'%' + 
                      String.escapeSingleQuotes(searchTerm) + '%\'';
        return Database.query(query);
    }
}

// Usage example (run in Execute Anonymous):
// List<Account> results = DynamicSOQL.buildDynamicQuery('Technology', 1000000);
// System.debug('Found ' + results.size() + ' accounts');

```


Dynamic SOQL uses Database.query() to execute string-based queries.
Always escape user input with String.escapeSingleQuotes() to prevent SOQL injection.
Use bind variables where possible for better security and performance.

Querying based on relative dates (e.g., LAST_N_DAYS:30)

Relative date literals provide convenient date filtering without calculating exact dates.

## Common literals include TODAY, YESTERDAY, LAST_N_DAYS, NEXT_N_DAYS, etc.


## These simplify date-based queries and make them more readable.

Relative dates automatically adjust, making queries time-aware.

```apex
public class RelativeDateQueries {
    public static List<Account> getAccountsCreatedLast30Days() {
        return [SELECT Id, Name, CreatedDate FROM Account 
                WHERE CreatedDate = LAST_N_DAYS:30];
    }
    
    public static List<Opportunity> getOpportunitiesClosingThisWeek() {
        return [SELECT Id, Name, CloseDate, StageName FROM Opportunity 
                WHERE CloseDate = THIS_WEEK];
    }
    
    public static List<Contact> getContactsCreatedToday() {
        return [SELECT Id, FirstName, LastName, CreatedDate FROM Contact 
                WHERE CreatedDate = TODAY];
    }
    
    public static List<Opportunity> getOpportunitiesClosingNextMonth() {
        return [SELECT Id, Name, CloseDate FROM Opportunity 
                WHERE CloseDate = NEXT_MONTH];
    }
    
    public static List<Account> getAccountsModifiedLastWeek() {
        return [SELECT Id, Name, LastModifiedDate FROM Account 
                WHERE LastModifiedDate = LAST_WEEK];
    }
}

// Usage example (run in Execute Anonymous):
// List<Account> recent = RelativeDateQueries.getAccountsCreatedLast30Days();
// System.debug('Accounts created in last 30 days: ' + recent.size());

```


Relative date literals simplify date-based filtering without manual date calculations.
They make queries more readable and automatically adjust based on the current date.

Querying and processing picklist fields


## Picklist fields contain predefined values that can be queried and processed.


## You can filter by picklist values and iterate through available values.


## Picklist values are case-sensitive in queries.

Processing picklists requires understanding their structure and valid values.

```apex
public class PicklistQueries {
    public static List<Account> getAccountsByIndustry(String industry) {
        return [SELECT Id, Name, Industry FROM Account WHERE Industry = :industry];
    }
    
    public static List<Opportunity> getOpportunitiesByStage(String stage) {
        return [SELECT Id, Name, StageName FROM Opportunity WHERE StageName = :stage];
    }
    
    public static Map<String, Integer> countByIndustry() {
        Map<String, Integer> counts = new Map<String, Integer>();
        List<AggregateResult> results = [
            SELECT Industry, COUNT(Id) total 
            FROM Account 
            WHERE Industry != null 
            GROUP BY Industry
        ];
        
        for (AggregateResult ar : results) {
            counts.put((String)ar.get('Industry'), (Integer)ar.get('total'));
        }
        
        return counts;
    }
    
    public static List<Account> getAccountsByMultipleIndustries(List<String> industries) {
        return [SELECT Id, Name, Industry FROM Account WHERE Industry IN :industries];
    }
}

// Usage example (run in Execute Anonymous):
// List<Account> techAccounts = PicklistQueries.getAccountsByIndustry('Technology');
// Map<String, Integer> industryCounts = PicklistQueries.countByIndustry();
// System.debug('Industry distribution: ' + industryCounts);

```


## Picklist values must match exactly (case-sensitive) in WHERE clauses.


## Use IN clauses to filter by multiple picklist values efficiently.

Aggregate queries enable analysis of picklist value distributions.

DML and CRUD Operations

INSERT single and multiple records


## INSERT operations add new records to the Salesforce database.


## You can insert single records or lists of records for bulk operations.


## Bulk inserts are more efficient and help avoid governor limits.

INSERT is the first step in creating new data in Salesforce.

```apex
public class DMLInsert {
    public static Id insertSingleAccount() {
        Account acc = new Account(Name = 'New Account', Industry = 'Technology');
        insert acc;
        return acc.Id;
    }
    
    public static List<Id> insertMultipleAccounts(List<String> accountNames) {
        List<Account> accounts = new List<Account>();
        
        for (String name : accountNames) {
            accounts.add(new Account(Name = name));
        }
        
        insert accounts;
        
        List<Id> accountIds = new List<Id>();
        for (Account acc : accounts) {
            accountIds.add(acc.Id);
        }
        
        return accountIds;
    }
    
    public static void insertAccountWithContact(String accountName, String contactName) {
        Account acc = new Account(Name = accountName);
        insert acc;
        
        Contact con = new Contact(
            LastName = contactName,
            AccountId = acc.Id
        );
        insert con;
    }
}

// Usage example (run in Execute Anonymous):
// Id accountId = DMLInsert.insertSingleAccount();
// System.debug('Created account with ID: ' + accountId);

```


## INSERT operations automatically populate Id fields after successful insertion.


## Bulk inserts (lists) are more efficient than individual inserts.

Always check for errors after DML operations.

UPDATE records based on criteria


## UPDATE modifies existing records in the database.


## You can update single records or lists of records.


## Updates require records to have their Id field populated.

This is essential for maintaining and modifying existing data.

```apex
public class DMLUpdate {
    public static void updateAccountName(Id accountId, String newName) {
        Account acc = [SELECT Id, Name FROM Account WHERE Id = :accountId];
        acc.Name = newName;
        update acc;
    }
    
    public static void updateMultipleAccounts(List<Id> accountIds, String newIndustry) {
        List<Account> accounts = [SELECT Id, Industry FROM Account WHERE Id IN :accountIds];
        
        for (Account acc : accounts) {
            acc.Industry = newIndustry;
        }
        
        update accounts;
    }
    
    public static void updateOpportunityAmounts(Decimal multiplier) {
        List<Opportunity> opps = [SELECT Id, Amount FROM Opportunity WHERE Amount != null];
        
        for (Opportunity opp : opps) {
            opp.Amount = opp.Amount * multiplier;
        }
        
        update opps;
    }
}

// Usage example (run in Execute Anonymous):
// DMLUpdate.updateAccountName('001xx000003DGbQAAW', 'Updated Name');

```


## UPDATE requires records to have Id values set.


## Query records first, modify fields, then update.

Bulk updates are more efficient than individual updates.

DELETE records conditionally


## DELETE removes records from the database permanently.


## You can delete single records or lists of records.


## Deleted records go to the Recycle Bin and can be restored.

DELETE is a destructive operation that should be used carefully.

```apex
public class DMLDelete {
    public static void deleteAccount(Id accountId) {
        Account acc = [SELECT Id FROM Account WHERE Id = :accountId];
        delete acc;
    }
    
    public static void deleteAccountsByIndustry(String industry) {
        List<Account> accounts = [SELECT Id FROM Account WHERE Industry = :industry];
        delete accounts;
    }
    
    public static void deleteOldOpportunities(Date cutoffDate) {
        List<Opportunity> opps = [
            SELECT Id FROM Opportunity 
            WHERE CloseDate < :cutoffDate AND StageName = 'Closed Lost'
        ];
        delete opps;
    }
    
    public static void deleteContactsWithoutEmail() {
        List<Contact> contacts = [SELECT Id FROM Contact WHERE Email = null];
        delete contacts;
    }
}

// Usage example (run in Execute Anonymous):
// DMLDelete.deleteAccountsByIndustry('Obsolete');
// System.debug('Deleted accounts in Obsolete industry');

```


## DELETE operations move records to the Recycle Bin where they can be restored.

Always query records before deleting to ensure you're deleting the correct records.
Use WHERE clauses to conditionally delete based on criteria.

UPSERT with external IDs

UPSERT inserts new records or updates existing ones based on external ID fields.

## External IDs are custom fields marked as unique and external identifiers.


## UPSERT eliminates the need to check if records exist before inserting/updating.

This is ideal for data integration and synchronization scenarios.

```apex
public class DMLUpsert {
    // Assuming Account has an external ID field called External_ID__c
    public static void upsertAccountByExternalId(String externalId, String name) {
        Account acc = new Account(
            External_ID__c = externalId,
            Name = name
        );
        upsert acc External_ID__c;
    }
    
    public static void upsertMultipleAccounts(List<Account> accounts) {
        upsert accounts External_ID__c;
    }
    
    public static void upsertByRecordId(List<Account> accounts) {
        // Upsert by Id field
        upsert accounts;
    }
}

// Usage example (run in Execute Anonymous):
// DMLUpsert.upsertAccountByExternalId('EXT-001', 'Upserted Account');

```


## UPSERT uses external ID fields to determine if a record exists.

If a record with the external ID exists, it's updated; otherwise, it's inserted.
This simplifies data synchronization and integration processes.

DML exception handling via try/catch


## DML operations can fail, so exception handling is essential for robust code.


## Try-catch blocks capture DmlException and other exceptions.

Proper error handling prevents code failures and enables graceful error recovery.
Always handle DML exceptions to provide meaningful error messages.

```apex
public class DMLExceptionHandling {
    public static void insertAccountWithErrorHandling(String accountName) {
        try {
            Account acc = new Account(Name = accountName);
            insert acc;
            System.debug('Account created successfully: ' + acc.Id);
        } catch (DmlException e) {
            System.debug('DML Error: ' + e.getMessage());
            System.debug('Error Code: ' + e.getDmlType(0));
            for (Integer i = 0; i < e.getNumDml(); i++) {
                System.debug('Field: ' + e.getDmlFields(i));
                System.debug('Message: ' + e.getDmlMessage(i));
            }
        } catch (Exception e) {
            System.debug('General Error: ' + e.getMessage());
        }
    }
    
    public static void bulkInsertWithErrorHandling(List<Account> accounts) {
        try {
            insert accounts;
            System.debug('Successfully inserted ' + accounts.size() + ' accounts');
        } catch (DmlException e) {
            System.debug('Bulk insert failed. Errors: ' + e.getNumDml());
            for (Integer i = 0; i < e.getNumDml(); i++) {
                System.debug('Record ' + i + ': ' + e.getDmlMessage(i));
            }
        }
    }
}

// Usage example (run in Execute Anonymous):
// DMLExceptionHandling.insertAccountWithErrorHandling('Test Account');

```


## DmlException provides detailed error information including field-level errors.


## Use getNumDml() and getDmlMessage() to handle bulk operation errors.

Always implement error handling for production code.

Rollback transaction after a simulated failure


## Rollback undoes all DML operations in the current transaction.


## Use Savepoint to mark a point before operations, then rollback to that point.


## Rollback is useful for testing error scenarios and transaction management.

This ensures data consistency when operations fail.

```apex
public class TransactionRollback {
    public static void demonstrateRollback() {
        Savepoint sp = Database.setSavepoint();
        
        try {
            Account acc1 = new Account(Name = 'Account 1');
            insert acc1;
            
            Account acc2 = new Account(); // Missing required field - will fail
            insert acc2;
            
        } catch (DmlException e) {
            System.debug('Error occurred, rolling back transaction');
            Database.rollback(sp);
            System.debug('Transaction rolled back - no accounts created');
        }
    }
    
    public static void conditionalRollback(Boolean shouldRollback) {
        Savepoint sp = Database.setSavepoint();
        
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        if (shouldRollback) {
            Database.rollback(sp);
            System.debug('Transaction rolled back');
        } else {
            System.debug('Transaction committed - Account ID: ' + acc.Id);
        }
    }
}

// Usage example (run in Execute Anonymous):
// TransactionRollback.demonstrateRollback();

```


## Savepoints mark transaction state; rollback returns to that state.


## All DML operations after the savepoint are undone on rollback.

Use rollback for error recovery and transaction management.

Partial success/failure handling in bulk DML


## Bulk DML operations can partially succeed when some records fail.

Database methods (Database.insert, etc.) allow partial success with allOrNone=false.
You can inspect individual results to identify which records succeeded or failed.
This enables robust bulk processing with error recovery.

```apex
public class PartialSuccessHandling {
    public static void insertWithPartialSuccess(List<Account> accounts) {
        Database.SaveResult[] results = Database.insert(accounts, false);
        
        List<Account> successful = new List<Account>();
        List<Account> failed = new List<Account>();
        
        for (Integer i = 0; i < results.size(); i++) {
            if (results[i].isSuccess()) {
                successful.add(accounts[i]);
                System.debug('Success: ' + accounts[i].Name + ' - ID: ' + results[i].getId());
            } else {
                failed.add(accounts[i]);
                System.debug('Failed: ' + accounts[i].Name);
                for (Database.Error error : results[i].getErrors()) {
                    System.debug('Error: ' + error.getMessage());
                }
            }
        }
        
        System.debug('Successful: ' + successful.size() + ', Failed: ' + failed.size());
    }
    
    public static void updateWithPartialSuccess(List<Account> accounts) {
        Database.SaveResult[] results = Database.update(accounts, false);
        
        for (Integer i = 0; i < results.size(); i++) {
            if (!results[i].isSuccess()) {
                System.debug('Update failed for: ' + accounts[i].Name);
                for (Database.Error error : results[i].getErrors()) {
                    System.debug('Field: ' + error.getFields() + ', Message: ' + error.getMessage());
                }
            }
        }
    }
}

// Usage example (run in Execute Anonymous):
// List<Account> accounts = new List<Account>{
//     new Account(Name = 'Valid Account'),
//     new Account() // Invalid - missing name
// };
// PartialSuccessHandling.insertWithPartialSuccess(accounts);

```


## Database methods with allOrNone=false allow partial success.


## SaveResult objects provide detailed information about each record's outcome.

This enables processing valid records while identifying and handling failures.

Retrieving and editing records fetched from SOQL


## Records retrieved from SOQL queries can be modified and updated.


## Query records, modify their fields, then perform DML operations.


## This pattern enables data transformation and batch updates.

Always query only the fields you need for better performance.

```apex
public class QueryAndUpdate {
    public static void updateAccountIndustry(Id accountId, String newIndustry) {
        Account acc = [SELECT Id, Industry FROM Account WHERE Id = :accountId];
        acc.Industry = newIndustry;
        update acc;
    }
    
    public static void bulkUpdateAccounts(String oldIndustry, String newIndustry) {
        List<Account> accounts = [
            SELECT Id, Industry FROM Account WHERE Industry = :oldIndustry
        ];
        
        for (Account acc : accounts) {
            acc.Industry = newIndustry;
        }
        
        update accounts;
    }
    
    public static void updateOpportunityAmounts() {
        List<Opportunity> opps = [
            SELECT Id, Amount FROM Opportunity 
            WHERE StageName = 'Prospecting' AND Amount != null
        ];
        
        for (Opportunity opp : opps) {
            opp.Amount = opp.Amount * 1.1; // 10% increase
        }
        
        update opps;
    }
}

// Usage example (run in Execute Anonymous):
// QueryAndUpdate.bulkUpdateAccounts('Old Industry', 'New Industry');

```


## Query records, modify fields in memory, then update.


## This pattern enables efficient batch processing of record modifications.

Only query fields you need to modify for better performance.

Soft deleting using undelete


## Undelete restores records from the Recycle Bin, effectively "soft deleting."

Deleted records remain in the Recycle Bin for 15 days (or 45 days in some orgs).

## Undelete is useful for recovering accidentally deleted records.

This provides a safety net for data recovery.

```apex
public class SoftDeleteOperations {
    public static void deleteAndUndeleteAccount(Id accountId) {
        Account acc = [SELECT Id, Name FROM Account WHERE Id = :accountId];
        delete acc;
        System.debug('Account deleted');
        
        // Undelete the account
        undelete acc;
        System.debug('Account restored: ' + acc.Name);
    }
    
    public static void restoreDeletedAccounts(List<Id> accountIds) {
        List<Account> deletedAccounts = [
            SELECT Id, Name FROM Account WHERE Id IN :accountIds ALL ROWS
        ];
        
        if (!deletedAccounts.isEmpty()) {
            undelete deletedAccounts;
            System.debug('Restored ' + deletedAccounts.size() + ' accounts');
        }
    }
    
    public static List<Account> getDeletedAccounts() {
        return [SELECT Id, Name FROM Account WHERE IsDeleted = true ALL ROWS];
    }
}

// Usage example (run in Execute Anonymous):
// SoftDeleteOperations.deleteAndUndeleteAccount('001xx000003DGbQAAW');

```


## Use ALL ROWS in SOQL to query deleted records from the Recycle Bin.


## Undelete restores records and their relationships.

Records are permanently deleted after the Recycle Bin retention period.

Field updates across objects (e.g., updating all Contacts for an Account)

Updating related records requires querying the relationship and modifying child records.

## You can update multiple related records in a single DML operation.

This pattern is common for maintaining data consistency across object relationships.
Efficient relationship queries enable bulk updates of related records.

```apex
public class CrossObjectUpdates {
    public static void updateAllContactsForAccount(Id accountId, String newPhone) {
        List<Contact> contacts = [
            SELECT Id, Phone FROM Contact WHERE AccountId = :accountId
        ];
        
        for (Contact con : contacts) {
            con.Phone = newPhone;
        }
        
        update contacts;
    }
    
    public static void updateOpportunitiesForAccount(Id accountId, String newStage) {
        List<Opportunity> opps = [
            SELECT Id, StageName FROM Opportunity WHERE AccountId = :accountId
        ];
        
        for (Opportunity opp : opps) {
            opp.StageName = newStage;
        }
        
        update opps;
    }
    
    public static void syncAccountPhoneToContacts(Id accountId) {
        Account acc = [SELECT Id, Phone FROM Account WHERE Id = :accountId];
        
        List<Contact> contacts = [
            SELECT Id, Phone FROM Contact WHERE AccountId = :accountId
        ];
        
        for (Contact con : contacts) {
            con.Phone = acc.Phone;
        }
        
        update contacts;
    }
}

// Usage example (run in Execute Anonymous):
// CrossObjectUpdates.updateAllContactsForAccount('001xx000003DGbQAAW', '555-1234');

```


Query related records using relationship fields (AccountId, etc.).

## Update multiple related records in a single DML operation for efficiency.

This maintains data consistency across object relationships.


# 5. Database Methodology

Apex Database Class

Database.insert vs. standard insert (error handling and partial success)

Database.insert provides more control than standard insert, especially for error handling.
The allOrNone parameter controls whether all records must succeed or partial success is allowed.

## Database methods return SaveResult arrays for detailed error inspection.

This enables sophisticated error handling and partial success scenarios.

```apex
public class DatabaseMethodExamples {
    public static void databaseInsertWithPartialSuccess(List<Account> accounts) {
        Database.SaveResult[] results = Database.insert(accounts, false);
        
        for (Integer i = 0; i < results.size(); i++) {
            if (results[i].isSuccess()) {
                System.debug('Success: ' + accounts[i].Name + ' - ID: ' + results[i].getId());
            } else {
                System.debug('Failed: ' + accounts[i].Name);
                for (Database.Error error : results[i].getErrors()) {
                    System.debug('Error: ' + error.getMessage());
                }
            }
        }
    }
    
    public static void standardInsertComparison(List<Account> accounts) {
        try {
            insert accounts; // All or nothing - throws exception on any failure
            System.debug('All accounts inserted successfully');
        } catch (DmlException e) {
            System.debug('Insert failed: ' + e.getMessage());
        }
    }
}

// Usage example (run in Execute Anonymous):
// List<Account> accounts = new List<Account>{
//     new Account(Name = 'Valid'),
//     new Account() // Invalid
// };
// DatabaseMethodExamples.databaseInsertWithPartialSuccess(accounts);

```


Database.insert with allOrNone=false allows partial success and detailed error inspection.
Standard insert throws exceptions on any failure but is simpler for all-or-nothing scenarios.
Choose based on your error handling requirements.

Database.update with allOrNone set to false

Database.update with allOrNone=false enables partial success in bulk updates.

## Failed records don't prevent successful updates of other records.


## SaveResult arrays provide detailed information about each record's outcome.

This is essential for robust bulk data processing.

```apex
public class DatabaseUpdateExamples {
    public static void updateWithPartialSuccess(List<Account> accounts) {
        Database.SaveResult[] results = Database.update(accounts, false);
        
        Integer successCount = 0;
        Integer failureCount = 0;
        
        for (Integer i = 0; i < results.size(); i++) {
            if (results[i].isSuccess()) {
                successCount++;
                System.debug('Updated: ' + accounts[i].Name);
            } else {
                failureCount++;
                System.debug('Failed: ' + accounts[i].Name);
                for (Database.Error error : results[i].getErrors()) {
                    System.debug('Field: ' + error.getFields() + ', Message: ' + error.getMessage());
                }
            }
        }
        
        System.debug('Success: ' + successCount + ', Failed: ' + failureCount);
    }
}

// Usage example (run in Execute Anonymous):
// List<Account> accounts = [SELECT Id, Name FROM Account LIMIT 5];
// for (Account acc : accounts) {
//     acc.Industry = 'Technology';
// }
// DatabaseUpdateExamples.updateWithPartialSuccess(accounts);

```


allOrNone=false allows processing to continue despite individual record failures.
This is crucial for bulk operations where some records may have validation errors.
Inspect SaveResult arrays to identify and handle failures appropriately.

Database.delete with partial failure capture

Database.delete with allOrNone=false allows partial success in bulk deletions.

## You can identify which records were deleted and which failed.


## This enables graceful handling of deletion errors.

Partial success is useful when some records may have dependencies preventing deletion.

```apex
public class DatabaseDeleteExamples {
    public static void deleteWithPartialSuccess(List<Account> accounts) {
        Database.DeleteResult[] results = Database.delete(accounts, false);
        
        Integer successCount = 0;
        Integer failureCount = 0;
        
        for (Integer i = 0; i < results.size(); i++) {
            if (results[i].isSuccess()) {
                successCount++;
                System.debug('Deleted account ID: ' + results[i].getId());
            } else {
                failureCount++;
                System.debug('Failed to delete: ' + accounts[i].Name);
                for (Database.Error error : results[i].getErrors()) {
                    System.debug('Error: ' + error.getMessage());
                }
            }
        }
        
        System.debug('Deleted: ' + successCount + ', Failed: ' + failureCount);
    }
}

// Usage example (run in Execute Anonymous):
// List<Account> accounts = [SELECT Id, Name FROM Account LIMIT 5];
// DatabaseDeleteExamples.deleteWithPartialSuccess(accounts);

```


Database.delete with allOrNone=false enables partial success in bulk deletions.

## DeleteResult arrays provide detailed information about each deletion attempt.

This allows processing to continue even when some records cannot be deleted.

Using Database.saveResult for granular error logging

SaveResult objects provide detailed information about individual DML operation outcomes.

## You can inspect success status, record IDs, and specific error messages.


## This enables granular error logging and detailed failure analysis.

SaveResult is essential for understanding bulk operation results.

```apex
public class SaveResultLogging {
    public static void detailedErrorLogging(List<Account> accounts) {
        Database.SaveResult[] results = Database.insert(accounts, false);
        
        for (Integer i = 0; i < results.size(); i++) {
            Database.SaveResult sr = results[i];
            
            if (sr.isSuccess()) {
                System.debug('Record ' + i + ' - SUCCESS');
                System.debug('  ID: ' + sr.getId());
            } else {
                System.debug('Record ' + i + ' - FAILURE');
                System.debug('  Account Name: ' + accounts[i].Name);
                
                for (Database.Error error : sr.getErrors()) {
                    System.debug('  Status Code: ' + error.getStatusCode());
                    System.debug('  Message: ' + error.getMessage());
                    System.debug('  Fields: ' + error.getFields());
                }
            }
        }
    }
    
    public static Map<Id, List<String>> collectErrors(List<Account> accounts) {
        Map<Id, List<String>> errorMap = new Map<Id, List<String>>();
        Database.SaveResult[] results = Database.insert(accounts, false);
        
        for (Integer i = 0; i < results.size(); i++) {
            if (!results[i].isSuccess()) {
                List<String> errors = new List<String>();
                for (Database.Error error : results[i].getErrors()) {
                    errors.add(error.getMessage());
                }
                errorMap.put(accounts[i].Id, errors);
            }
        }
        
        return errorMap;
    }
}

// Usage example (run in Execute Anonymous):
// List<Account> accounts = new List<Account>{
//     new Account(Name = 'Valid Account'),
//     new Account() // Invalid
// };
// SaveResultLogging.detailedErrorLogging(accounts);

```


SaveResult provides isSuccess(), getId(), and getErrors() for detailed inspection.

## Error objects contain status codes, messages, and field information.

Use this for comprehensive error logging and debugging.

Conditional upsert using Database methods

Database.upsert provides more control than standard upsert for conditional operations.

## You can specify external ID fields and handle partial success.


## This enables sophisticated data synchronization scenarios.

Database.upsert is ideal for integration and data loading operations.

```apex
public class DatabaseUpsertExamples {
    // Assuming External_ID__c is an external ID field
    public static void conditionalUpsert(List<Account> accounts) {
        Schema.SObjectField externalIdField = Account.External_ID__c;
        Database.UpsertResult[] results = Database.upsert(accounts, externalIdField, false);
        
        Integer inserted = 0;
        Integer updated = 0;
        Integer failed = 0;
        
        for (Integer i = 0; i < results.size(); i++) {
            if (results[i].isSuccess()) {
                if (results[i].isCreated()) {
                    inserted++;
                } else {
                    updated++;
                }
            } else {
                failed++;
                for (Database.Error error : results[i].getErrors()) {
                    System.debug('Error: ' + error.getMessage());
                }
            }
        }
        
        System.debug('Inserted: ' + inserted + ', Updated: ' + updated + ', Failed: ' + failed);
    }
}

// Usage example (run in Execute Anonymous):
// List<Account> accounts = new List<Account>{
//     new Account(External_ID__c = 'EXT-001', Name = 'Upsert Test')
// };
// DatabaseUpsertExamples.conditionalUpsert(accounts);

```


Database.upsert with external ID fields enables conditional insert/update logic.
UpsertResult provides isCreated() to distinguish inserts from updates.

```apex
Use allOrNone=false for partial success handling in bulk operations.

Performing merge of records using Database.merge

Database.merge combines duplicate records, preserving the master record and merging related data.
Merge operations transfer related records (contacts, opportunities) to the master.
You specify the master record and the records to merge into it.
Merge is essential for data quality and duplicate management.

public class DatabaseMergeExamples {
    public static void mergeAccounts(Id masterId, List<Id> duplicateIds) {
        Account master = [SELECT Id, Name FROM Account WHERE Id = :masterId];
        List<Account> duplicates = [SELECT Id, Name FROM Account WHERE Id IN :duplicateIds];
        
        Database.MergeResult[] results = Database.merge(master, duplicates, false);
        
        for (Database.MergeResult mr : results) {
            if (mr.isSuccess()) {
                System.debug('Merged successfully');
                System.debug('Merged record IDs: ' + mr.getMergedRecordIds());
            } else {
                System.debug('Merge failed');
                for (Database.Error error : mr.getErrors()) {
                    System.debug('Error: ' + error.getMessage());
                }
            }
        }
    }
    
    public static void mergeSingleDuplicate(Id masterId, Id duplicateId) {
        Account master = [SELECT Id FROM Account WHERE Id = :masterId];
        Account duplicate = [SELECT Id FROM Account WHERE Id = :duplicateId];
        
        merge master duplicate;
    }
}

// Usage example (run in Execute Anonymous):
// DatabaseMergeExamples.mergeAccounts('001xx000003DGbQAAW', 
//     new List<Id>{'001xx000003DGbRAAW'});

```


## Merge transfers related records to the master and deletes duplicates.

Use Database.merge for bulk merges with error handling.
Standard merge syntax is simpler for single merges.

Database.emptyRecycleBin to fully remove records


## emptyRecycleBin permanently deletes records from the Recycle Bin.


## This is useful for data cleanup and compliance scenarios.


## Records must be in the Recycle Bin (already deleted) to be emptied.

This operation cannot be undone.

```apex
public class RecycleBinOperations {
    public static void emptyRecycleBinForAccounts() {
        List<Account> deletedAccounts = [
            SELECT Id FROM Account WHERE IsDeleted = true ALL ROWS
        ];
        
        if (!deletedAccounts.isEmpty()) {
            Database.EmptyRecycleBinResult[] results = Database.emptyRecycleBin(deletedAccounts);
            
            for (Database.EmptyRecycleBinResult result : results) {
                if (result.isSuccess()) {
                    System.debug('Permanently deleted: ' + result.getId());
                } else {
                    System.debug('Failed to delete: ' + result.getId());
                    for (Database.Error error : result.getErrors()) {
                        System.debug('Error: ' + error.getMessage());
                    }
                }
            }
        }
    }
    
    public static void emptySpecificAccounts(List<Id> accountIds) {
        List<Account> accounts = [
            SELECT Id FROM Account WHERE Id IN :accountIds ALL ROWS
        ];
        Database.emptyRecycleBin(accounts);
    }
}

// Usage example (run in Execute Anonymous):
// RecycleBinOperations.emptyRecycleBinForAccounts();

```


## emptyRecycleBin permanently removes records - this cannot be undone.


## Use ALL ROWS in SOQL to query deleted records from the Recycle Bin.

This is useful for data retention and compliance requirements.

Using Database.rollback for transaction management

Database.rollback undoes all DML operations since the last savepoint.

## This is essential for transaction management and error recovery.


## Rollback ensures data consistency when operations fail.

Use savepoints to mark transaction state before risky operations.

```apex
public class DatabaseRollbackExamples {
    public static void rollbackOnError() {
        Savepoint sp = Database.setSavepoint();
        
        try {
            Account acc1 = new Account(Name = 'Account 1');
            insert acc1;
            
            Account acc2 = new Account(); // Will fail - missing required field
            insert acc2;
            
        } catch (DmlException e) {
            System.debug('Error occurred, rolling back');
            Database.rollback(sp);
            System.debug('All changes rolled back');
        }
    }
    
    public static void conditionalRollback(Boolean condition) {
        Savepoint sp = Database.setSavepoint();
        
        Account acc = new Account(Name = 'Test');
        insert acc;
        
        if (condition) {
            Database.rollback(sp);
            System.debug('Rolled back due to condition');
        }
    }
}

// Usage example (run in Execute Anonymous):
// DatabaseRollbackExamples.rollbackOnError();

```


## Savepoints mark transaction state; rollback returns to that state.


## All DML operations after the savepoint are undone on rollback.

Use this for atomic transactions and error recovery.

Chained record operations with savepoints


## Savepoints enable creating multiple checkpoints in a transaction.


## You can rollback to any savepoint, not just the most recent one.


## This enables complex transaction management with multiple rollback points.

Chained operations with savepoints provide fine-grained transaction control.

```apex
public class ChainedSavepointOperations {
    public static void chainedOperationsWithSavepoints() {
        Savepoint sp1 = Database.setSavepoint();
        
        Account acc1 = new Account(Name = 'Account 1');
        insert acc1;
        
        Savepoint sp2 = Database.setSavepoint();
        
        Contact con1 = new Contact(LastName = 'Contact 1', AccountId = acc1.Id);
        insert con1;
        
        Savepoint sp3 = Database.setSavepoint();
        
        Opportunity opp1 = new Opportunity(
            Name = 'Opp 1',
            AccountId = acc1.Id,
            CloseDate = Date.today(),
            StageName = 'Prospecting'
        );
        
        try {
            insert opp1;
        } catch (Exception e) {
            // Rollback to sp2, keeping acc1 and con1
            Database.rollback(sp2);
            System.debug('Rolled back to savepoint 2');
        }
    }
}

// Usage example (run in Execute Anonymous):
// ChainedSavepointOperations.chainedOperationsWithSavepoints();
```


## Multiple savepoints enable fine-grained transaction control.

You can rollback to any previous savepoint, preserving operations before that point.
This enables complex error recovery scenarios.

Simulating bulk operations with errors and recoveries


## Simulating bulk operations helps test error handling and recovery logic.


## You can intentionally create scenarios with partial failures.


## This validates that your error handling works correctly.

Testing error scenarios is essential for robust production code.

```apex
public class BulkOperationSimulation {
    public static void simulateBulkInsertWithErrors() {
        List<Account> accounts = new List<Account>();
        
        // Valid accounts
        accounts.add(new Account(Name = 'Valid Account 1'));
        accounts.add(new Account(Name = 'Valid Account 2'));
        
        // Invalid account (missing required field)
        accounts.add(new Account());
        
        // More valid accounts
        accounts.add(new Account(Name = 'Valid Account 3'));
        
        Database.SaveResult[] results = Database.insert(accounts, false);
        
        List<Account> successful = new List<Account>();
        List<Account> failed = new List<Account>();
        
        for (Integer i = 0; i < results.size(); i++) {
            if (results[i].isSuccess()) {
                successful.add(accounts[i]);
            } else {
                failed.add(accounts[i]);
                // Log error and potentially fix
                System.debug('Failed: ' + accounts[i].Name);
                for (Database.Error error : results[i].getErrors()) {
                    System.debug('Error: ' + error.getMessage());
                }
            }
        }
        
        // Retry failed records after fixing
        if (!failed.isEmpty()) {
            for (Account acc : failed) {
                if (acc.Name == null) {
                    acc.Name = 'Default Name';
                }
            }
            Database.insert(failed, false);
        }
        
        System.debug('Successfully processed: ' + successful.size());
    }
    
    public static void simulateBulkUpdateWithPartialFailure() {
        List<Account> accounts = [SELECT Id, Name, Industry FROM Account LIMIT 10];
        
        // Intentionally create invalid data for some records
        for (Integer i = 0; i < accounts.size(); i++) {
            if (Math.mod(i, 3) == 0) {
                accounts[i].Name = null; // Will cause failure
            } else {
                accounts[i].Industry = 'Technology';
            }
        }
        
        Database.SaveResult[] results = Database.update(accounts, false);
        
        Integer successCount = 0;
        for (Database.SaveResult sr : results) {
            if (sr.isSuccess()) {
                successCount++;
            }
        }
        
        System.debug('Updated ' + successCount + ' out of ' + accounts.size() + ' accounts');
    }
}

// Usage example (run in Execute Anonymous):
// BulkOperationSimulation.simulateBulkInsertWithErrors();
```


## Simulating errors validates error handling and recovery logic.


## Use Database methods with allOrNone=false to test partial success scenarios.


