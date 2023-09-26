import 'package:dtradmin/model/employee_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/week_schedule_model.dart';
import '../provider/employee_provider.dart';
import '../provider/week_scheduke_provider.dart';
import '../widget/delegate.dart';
import '../widget/row_widget.dart';
import '../widget/snackbar_widget.dart';

class EmployeeView extends StatefulWidget {
  const EmployeeView({super.key});

  @override
  State<EmployeeView> createState() => _EmployeeViewState();
}

class _EmployeeViewState extends State<EmployeeView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var e = Provider.of<EmployeeProvider>(context, listen: false);

      await e.getEmployee();
    });
  }

  @override
  Widget build(BuildContext context) {
    const idw = 100.0;
    const empIdw = 150.0;
    const dIdw = 300.0;
    const wsIdw = 200.0;

    void addEmployee() async {
      var e = Provider.of<EmployeeProvider>(context, listen: false);
      var wsp = Provider.of<WeekScheduleProvider>(context, listen: false);
      await wsp.getWeekSchedule();

      if (mounted) {
        await showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            final employeeId = TextEditingController();
            final firtName = TextEditingController();
            final lastName = TextEditingController();
            final middleName = TextEditingController();

            var weekSchedList = <WeekScheduleModel>[
              WeekScheduleModel(
                id: 0,
                weekSchedId: '--Select--',
                monday: '',
                tuesday: '',
                wednesday: '',
                thursday: '',
                friday: '',
                saturday: '',
                sunday: '',
                description: '',
              ),
            ];
            weekSchedList.addAll(wsp.weekScheduleProviderList);
            var ddweekSchedValue = weekSchedList.first;

            return AlertDialog(
              title: const Text('Add Employee'),
              content: SizedBox(
                // height: 200.0,
                width: 500.0,
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40.0,
                          width: 500.0,
                          child: TextField(
                            controller: employeeId,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              label: Text('Employee ID'),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          height: 40.0,
                          width: 500.0,
                          child: TextField(
                            controller: lastName,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              label: Text('Lastname'),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          height: 40.0,
                          width: 500.0,
                          child: TextField(
                            controller: firtName,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              label: Text('Firstname'),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          height: 40.0,
                          width: 500.0,
                          child: TextField(
                            controller: middleName,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              label: Text('Middlename'),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Schedule:'),
                            const SizedBox(width: 5.0),
                            Container(
                              height: 40.0,
                              width: 400.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colors.grey,
                                  style: BorderStyle.solid,
                                  width: 1.0,
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<WeekScheduleModel>(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  borderRadius: BorderRadius.circular(5),
                                  value: ddweekSchedValue,
                                  onChanged: (WeekScheduleModel? value) async {
                                    if (value != null) {
                                      setState(() {
                                        ddweekSchedValue = value;
                                      });
                                    }
                                  },
                                  items: weekSchedList
                                      .map<DropdownMenuItem<WeekScheduleModel>>(
                                          (WeekScheduleModel value) {
                                    return DropdownMenuItem<WeekScheduleModel>(
                                      value: value,
                                      child: Text(
                                          '${value.weekSchedId} | ${value.description}'),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text(
                    'Ok',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  onPressed: () async {
                    bool employeeExist =
                        e.checkEmployeeId(employeeId.text.trim());
                    if (employeeId.text.isEmpty ||
                        firtName.text.isEmpty ||
                        lastName.text.isEmpty ||
                        middleName.text.isEmpty ||
                        ddweekSchedValue.id == 0) {
                      snackBarError(
                          'Invalid Employee/Missing Parameters', context);
                    } else if (employeeExist) {
                      snackBarError('Employee Already Exist', context);
                    } else {
                      await e.addEmployee(
                        employeeId: employeeId.text.trim(),
                        firstName: firtName.text.trim(),
                        lastName: lastName.text.trim(),
                        middleName: middleName.text.trim(),
                        weekSchedId: ddweekSchedValue.weekSchedId,
                        active: 1,
                      );
                    }
                    if (mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          },
        );
      }
    }

    void updateEmployee(EmployeeModel employeeModel) async {
      var e = Provider.of<EmployeeProvider>(context, listen: false);
      var wsp = Provider.of<WeekScheduleProvider>(context, listen: false);
      await wsp.getWeekSchedule();
      WeekScheduleModel weekSchedSolo = wsp.weekScheduleProviderList
          .singleWhere((e) => e.weekSchedId == employeeModel.weekSchedId);
      if (mounted) {
        await showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            final employeeId =
                TextEditingController(text: employeeModel.employeeId);
            final firtName =
                TextEditingController(text: employeeModel.firstName);
            final lastName =
                TextEditingController(text: employeeModel.lastName);
            final middleName =
                TextEditingController(text: employeeModel.middleName);

            var weekSchedList = <WeekScheduleModel>[];
            weekSchedList.addAll(wsp.weekScheduleProviderList);
            var ddweekSchedValue = weekSchedSolo;

            bool isActive = employeeModel.active == 1 ? true : false;

            return AlertDialog(
              title: const Text('Add Employee'),
              content: SizedBox(
                // height: 200.0,
                width: 500.0,
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40.0,
                          width: 500.0,
                          child: TextField(
                            controller: employeeId,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              label: Text('Employee ID'),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          height: 40.0,
                          width: 500.0,
                          child: TextField(
                            controller: lastName,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              label: Text('Lastname'),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          height: 40.0,
                          width: 500.0,
                          child: TextField(
                            controller: firtName,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              label: Text('Firstname'),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          height: 40.0,
                          width: 500.0,
                          child: TextField(
                            controller: middleName,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              label: Text('Middlename'),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Schedule:'),
                            const SizedBox(width: 5.0),
                            Container(
                              height: 40.0,
                              width: 400.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colors.grey,
                                  style: BorderStyle.solid,
                                  width: 1.0,
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<WeekScheduleModel>(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  borderRadius: BorderRadius.circular(5),
                                  value: ddweekSchedValue,
                                  onChanged: (WeekScheduleModel? value) async {
                                    if (value != null) {
                                      setState(() {
                                        ddweekSchedValue = value;
                                      });
                                    }
                                  },
                                  items: weekSchedList
                                      .map<DropdownMenuItem<WeekScheduleModel>>(
                                          (WeekScheduleModel value) {
                                    return DropdownMenuItem<WeekScheduleModel>(
                                      value: value,
                                      child: Text(
                                          '${value.weekSchedId} | ${value.description}'),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          height: 40.0,
                          // width: 400.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('Active:'),
                              const SizedBox(width: 5.0),
                              CupertinoSwitch(
                                value: isActive,
                                activeColor: Colors.red,
                                onChanged: (bool value) {
                                  setState(() {
                                    isActive = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text(
                    'Ok',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  onPressed: () async {
                    bool employeeExist =
                        e.checkEmployeeId(employeeId.text.trim());
                    if (employeeId.text.isEmpty ||
                        firtName.text.isEmpty ||
                        lastName.text.isEmpty ||
                        middleName.text.isEmpty ||
                        ddweekSchedValue.id == 0) {
                      snackBarError(
                          'Invalid Employee/Missing Parameters', context);
                    } else if (employeeExist &&
                        employeeModel.employeeId != employeeId.text.trim()) {
                      snackBarError('Employee Already Exist', context);
                    } else {
                      await e.updateEmployee(
                        employeeId: employeeId.text.trim(),
                        firstName: firtName.text.trim(),
                        lastName: lastName.text.trim(),
                        middleName: middleName.text.trim(),
                        weekSchedId: ddweekSchedValue.weekSchedId,
                        active: isActive ? 1 : 0,
                        id: employeeModel.id,
                      );
                    }
                    if (mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          },
        );
      }
    }

    void confirmDeleteEmployeeBranch(EmployeeModel employeeModel) async {
      var d = Provider.of<EmployeeProvider>(context, listen: false);
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Remove Employee in Branch'),
            content: Text('Delete ${d.fullName(employeeModel)}?'),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 16.0),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  'Ok',
                  style: TextStyle(fontSize: 16.0),
                ),
                onPressed: () async {
                  await d.deleteEmployee(id: employeeModel.id);
                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      body: Consumer<EmployeeProvider>(
        builder: ((context, provider, child) {
          return CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppBarDelegate(
                  minHeight: 60.0,
                  maxHeight: 60.0,
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RowWidget(
                            s: 'ID',
                            w: idw,
                            c: Colors.red,
                            f: 1,
                          ),
                          RowWidget(
                            s: 'Emp ID',
                            w: empIdw,
                            c: Colors.green,
                            f: 2,
                          ),
                          RowWidget(
                            s: 'Name',
                            w: dIdw,
                            c: Colors.blue,
                            f: 3,
                          ),
                          RowWidget(
                            s: 'Week Schedule',
                            w: wsIdw,
                            c: Colors.yellow,
                            f: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    bool isActive =
                        provider.employeeList[index].active == 1 ? true : false;
                    return Card(
                      child: InkWell(
                        onTap: () {
                          updateEmployee(provider.employeeList[index]);
                        },
                        onLongPress: () {
                          confirmDeleteEmployeeBranch(
                              provider.employeeList[index]);
                        },
                        child: Ink(
                          color: isActive ? null : Colors.red[300],
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RowWidget(
                                s: provider.employeeList[index].id.toString(),
                                w: idw,
                                c: Colors.red,
                                f: 1,
                              ),
                              RowWidget(
                                s: provider.employeeList[index].employeeId,
                                w: empIdw,
                                c: Colors.green,
                                f: 2,
                              ),
                              RowWidget(
                                s: provider
                                    .fullName(provider.employeeList[index]),
                                w: dIdw,
                                c: Colors.blue,
                                f: 3,
                              ),
                              RowWidget(
                                s: provider.employeeList[index].weekSchedId,
                                w: wsIdw,
                                c: Colors.yellow,
                                f: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: provider.employeeList.length,
                ),
              ),
            ],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          addEmployee();
        },
        child: const Text('Add'),
      ),
    );
  }
}
