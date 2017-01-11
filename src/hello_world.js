const Services = {};
Services.Employee = class {
  constructor(name) {
    this.name = name;
  }
}
Services.Helpers = {};
Services.Helpers.Admin = {};
Services.Helpers.Admin.Foo = class {}
Services.Helpers.Greeter = class extends Services.Employee {
  constructor(people, name) {
    super(name);
    this.people = people;
    this.name = name;
    this.count = 0;
    this.foo = {"bar": "bar"};
  }
  greet() {
    if (this.count >= 0 && this.people) {
      this.count += 1;
      console.log("Hello World!");
    }
  }
  greetManyPeople(peopleOverride, callback) {
    const maxPeople = (peopleOverride || this.people);
    while (this.count < maxPeople) {
      this.greet();
    }
    if (callback) {
      callback(this.count, this.name);
    }
    this.count = 0;
  }
}
Services.Helpers.Server = class extends Services.Employee {
  serve() {}
}
Services.Workers = {};
Services.Helpers.Cashier = class extends Services.Employee {
  cashOut() {}
}
