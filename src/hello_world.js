
Array.prototype.reject = function(condition) {
  let rejectedItems = [];

  for (let item of this) {
    let reject = condition(item);

    if (reject) {
      rejectedItems.push(item);
    }
  }

  for (let item of rejectedItems) {
    this.splice(this.indexOf(item), 1);
  }

  return this;
}

Array.prototype.each = function(block) {
  for (let item of this) {
    block(item);
  }
  return this;
}

Array.prototype.eachWithIndex = function(block) {
  for (let item of this) {
    index = this.indexOf(item);
    block(item, index);
  }
  return this;
}

const Services = {};
Services.Employee = class {
  constructor(name) {
    this.name = name;
  }
}
Services.Helpers = {};
Services.Helpers.Admin = {};
Services.Helpers.Admin.Foo = class {}
Services.Helpers.Greeter = class extends Employee {
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
    return if (this.count >= 0 && this.people) {
      this.count += 1;
      console.log('Hello World!');
    };
  }
  greetManyPeople(peopleOverride, callback) {
    maxPeople = (peopleOverride || this.people);
    while (this.count < maxPeople) {
      greet();
    }
    if block {
      callback(this.count, this.name);
    }
    return this.count = 0;;
  }
}
Services.Helpers.Server = class extends Employee {
  serve() {}
}
Services.Workers = {};
Services.Helpers.Cashier = class extends Employee {
  cashOut() {}
}