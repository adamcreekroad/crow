class Foo {
  class Bar {}
  hello() {
    return puts('hello');;
  }
}
const Services = {};
Services.Employee = class {
  constructor(name) {
    this.name = name;
    console.log(`name is ${this.name}`);
  }
}
Services.Helpers = {};
Services.Helpers.Admin = {};
Services.Helpers.Admin.Foo = class {}
Services.Helpers.Greeter = class extends Services.Employee {
  constructor(people, name) {
    this.people = people;
    this.name = name;
    this.count = 0;
    this.foo = ['foo1', 'foo2'];
    this.bar = ['bar1', 'bar2'];
    this.foo.eachWithIndex((n, i) => {
      console.log(`We are on ${n}, it is the ${i + 1} item in the array`);
    });
  }
  greet() {
    return if ((this.count >= 0 && this.people)) {
      this.count += 1;
      console.log('Hello World!');
    };
  }
  greetManyPeople(peopleOverride, callback) {
    maxPeople = (peopleOverride || this.people);
    while (this.count < maxPeople) {
      greet();
    }
    callback(this.count, this.name);
    return this.count = 0;;
  }
}
Services.Helpers.Server = class extends Services.Employee {
  serve() {}
}
Services.Workers = {};
Services.Workers.Cashier = class extends Services.Employee {
  cashOut() {}
}
const foo = new Services.Helpers.Greeter(8, 'AG');;
foo.greetManyPeople(4, (count, name) => {
  console.log(`we greeted ${count} people, ${name}!`);
});
const one = new Foo();;
one.hello();
const two = new Foo.Bar();;
two.hello();