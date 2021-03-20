class Employee {
  int id;
  String name;
  double salary;

  Employee(this.id, this.name, this.salary);

  set setId(id) {
    this.id = id;
  }

  set setName(name) {
    this.name = name;
  }

  set setSalary(salary) {
    this.salary = salary;
  }

  get getId => this.id;
  get getName => this.name;
  get getSalary => this.salary;
}
