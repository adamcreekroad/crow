const Helpers = {}
Helpers.Greeter = class {
  constructor(people, name) {
    this.people = people;
    this.name = name;
    this.count = 0;
    this.foo = {"bar": "bar"};
  }
  greet() {
    if (this.count >= 0 && this.people) {
      this.count += 1;
      this.console.log("Hello World!");
    }
  }
  greetManyPeople(peopleOverride, callback) {
    let maxPeople = (peopleOverride || this.people);
    maxPeople = 1;
    while (this.count < maxPeople) {
      this.greet();
    }
    callback(this.count, this.name);
  }
}

function doSomeGreetings {
  this.people = people;
  this.name = name;
  const greeter = new Helpers::Greeter(this.people, this.name);;
  greeter.greetManyPeople((count, name) => {
    console.log(`We',ve greeted ${count} people, ${name}!`);
  });
}
const foo = (x, y) => {
  console.log(x + y);
};
foo(3, 4);