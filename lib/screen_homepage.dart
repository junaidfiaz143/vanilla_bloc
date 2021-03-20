import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vanilla_bloc/employee.dart';
import 'package:vanilla_bloc/employee_bloc.dart';

class EmployeeList extends StatefulWidget {
  EmployeeListState createState() => EmployeeListState();
}

class EmployeeListState extends State<EmployeeList> {
  final employeeBloC = EmployeeBloC();

  @override
  void dispose() {
    super.dispose();
    employeeBloC.dispose();
  }

  List<Employee> employeeList = [
    Employee(1, "Employee 1", 10000),
    Employee(2, "Employee 2", 20000),
    Employee(3, "Employee 3", 30000),
    Employee(4, "Employee 4", 40000),
    Employee(5, "Employee 5", 50000),
    Employee(6, "Employee 6", 10000),
    Employee(7, "Employee 7", 20000),
    Employee(8, "Employee 8", 30000),
    Employee(9, "Employee 9", 40000),
    Employee(10, "Employee 10", 50000)
  ];

  @override
  Widget build(BuildContext context) {
    print("screen_homepage.dart ui build method");

    // employeeBloC.employeeSink.add(employeeList);

    return Container(
        child: StreamBuilder<List<Employee>>(
            stream: employeeBloC.employeeStream,
            builder:
                (BuildContext context, AsyncSnapshot<List<Employee>> snapshot) {
              if (!snapshot.hasData)
                return Text("No Data Found!");
              else
                return Column(children: <Widget>[
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Card(
                          elevation: 5.0,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text("${snapshot.data?[index].id}"),
                                Text("${snapshot.data?[index].name}"),
                                Text("${snapshot.data?[index].salary}"),
                                IconButton(
                                    icon: Icon(Icons.thumb_up),
                                    color: Colors.green,
                                    onPressed: () {
                                      employeeBloC.incrementSink
                                          .add(snapshot.data?[index]);
                                    }),
                                IconButton(
                                    icon: Icon(Icons.thumb_down),
                                    color: Colors.red,
                                    onPressed: () {
                                      employeeBloC.decrementSink
                                          .add(snapshot.data?[index]);
                                    })
                              ]));
                    },
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      employeeBloC.addEmployeeSink.add(Employee(
                          (snapshot.data?.length ?? 1) + 1,
                          "New Employee",
                          76));
                    },
                    child: Icon(Icons.add),
                    tooltip: "Add Employee",
                  )
                ]);
            }));
  }
}
