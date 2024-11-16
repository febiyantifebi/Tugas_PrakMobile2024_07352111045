class Animal {
  // Attributes
  String name;
  int age;

  // Constructor with positional arguments
  Animal(this.name, this.age);

  // Method
  void eat() {
    print('$name is eating.');
  }

  // Getter
  String get info => 'Name: $name, Age: $age';

  // Setter
  set updateName(String newName) => name = newName;
}

// Inheritance - Dog class inherits from Animal
class Dog extends Animal {
  // Constructor using named arguments
  Dog({required String name, required int age}) : super(name, age);

  // Overriding method
  @override
  void eat() {
    print('$name is munching on dog food.');
  }

  // Additional method
  void bark() {
    print('$name is barking.');
  }
}

// Abstract Class
abstract class Flyer {
  void fly(); // Abstract method
}

// Mixin
mixin Swimmer {
  void swim() {
    print('Swimming in water.');
  }
}

// Class that uses Mixin and implements an abstract class
class Duck extends Animal with Swimmer implements Flyer {
  Duck(String name, int age) : super(name, age);

  @override
  void fly() {
    print('$name is flying.');
  }

  @override
  void eat() {
    print('$name is eating duck food.');
  }
}

// Enum for animal types
enum AnimalType { mammal, bird, fish, reptile }

void main() {
  // Creating an instance of Animal
  Animal animal = Animal('Lion', 5);
  print(animal.info);
  animal.eat();
  animal.updateName = 'Tiger';
  print(animal.info);

  // Creating an instance of Dog
  Dog dog = Dog(name: 'Buddy', age: 3);
  print(dog.info);
  dog.eat();
  dog.bark();

  // Creating an instance of Duck
  Duck duck = Duck('Daffy', 2);
  print(duck.info);
  duck.eat();
  duck.fly();
  duck.swim();

  // Using Enum
  AnimalType type = AnimalType.bird;
  print('Animal type is: $type');
}
