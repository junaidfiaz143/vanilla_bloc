import 'dart:async';

import 'employee.dart';

class EmployeeBloC {
  List<Employee> employeeList = [];

  final streamController = StreamController<List<Employee>>();
  StreamSink<List<Employee>> get employeeSink => streamController.sink;

  Stream<List<Employee>> get employeeStream => streamController.stream;

  final incrementController = StreamController<Employee>();
  StreamSink<Employee?> get incrementSink => incrementController.sink;

  final decrementController = StreamController<Employee>();
  StreamSink<Employee?> get decrementSink => decrementController.sink;

  final addController = StreamController<Employee>();
  StreamSink<Employee> get addEmployeeSink => addController.sink;

  EmployeeBloC() {
    streamController.add(employeeList);

    incrementController.stream.listen(incrementSalaryEvent);
    decrementController.stream.listen(decrementSalaryEvent);
    addController.stream.listen(addEmployee);
  }

  addEmployee(Employee employee) {
    employeeList.add(employee);
    employeeSink.add(employeeList);
  }

  incrementSalaryEvent(Employee employee) {
    double salary = employee.getSalary;

    double incrementedSalary = salary * 20 / 100;
    salary = salary + incrementedSalary;

    employeeList[employee.getId - 1].setSalary = salary;

    employeeSink.add(employeeList);
  }

  decrementSalaryEvent(Employee employee) {
    double salary = employee.getSalary;

    double incrementedSalary = salary * 20 / 100;
    salary = salary - incrementedSalary;

    employeeList[employee.getId - 1].setSalary = salary;

    employeeSink.add(employeeList);
  }

  void dispose() {
    incrementController.close();
    decrementController.close();
    addController.close();
    streamController.close();
  }
}
