import 'package:dtradmin/model/branch_model.dart';
import 'package:dtradmin/model/department_model.dart';
import 'package:dtradmin/model/employee_model.dart';
import 'package:dtradmin/provider/branch_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/week_schedule_model.dart';
import '../provider/department_provider.dart';
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
  final idController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var e = Provider.of<EmployeeProvider>(context, listen: false);

      await e.getEmployee();
    });
  }

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
              width: 400.0,
              child: StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40.0,
                        width: 400.0,
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
                        width: 400.0,
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
                        width: 400.0,
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
                        width: 400.0,
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
                            // width: 400.0,
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
                                      '${value.weekSchedId} | ${value.description}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 14.0),
                                    ),
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
    await e.getBranchOfEmployee(employeeId: employeeModel.employeeId);
    WeekScheduleModel weekSchedSolo = wsp.weekScheduleProviderList
        .singleWhere((e) => e.weekSchedId == employeeModel.weekSchedId);
    if (mounted) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final employeeId =
              TextEditingController(text: employeeModel.employeeId);
          final firtName = TextEditingController(text: employeeModel.firstName);
          final lastName = TextEditingController(text: employeeModel.lastName);
          final middleName =
              TextEditingController(text: employeeModel.middleName);

          var weekSchedList = <WeekScheduleModel>[];
          weekSchedList.addAll(wsp.weekScheduleProviderList);
          var ddweekSchedValue = weekSchedSolo;

          bool isActive = employeeModel.active == 1 ? true : false;
          var selectedBranch = <String>[];
          var unselectedBranch = <String>[];
          var selectedDepartment = <String>[];
          var unselectedDepartment = <String>[];

          return AlertDialog(
            title: const Text('Update Employee'),
            content: SizedBox(
              // height: 200.0,
              width: 400.0,
              child: StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40.0,
                        width: 400.0,
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
                        width: 400.0,
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
                        width: 400.0,
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
                        width: 400.0,
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
                            // width: 400.0,
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
                                      '${value.weekSchedId} | ${value.description}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 14.0),
                                    ),
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
                      const SizedBox(height: 10.0),
                      InkWell(
                        onTap: () async {
                          await showSelectBranch(employeeModel).then((value) {
                            selectedBranch = value.addedBranch;
                            unselectedBranch = value.unselectedBranch;
                          });
                        },
                        child: Ink(
                          height: 30.0,
                          width: 120.0,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: const Center(
                            child: Text('Change Branch',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      InkWell(
                        onTap: () async {
                          await showSelectDepartment(employeeModel)
                              .then((value) {
                            selectedDepartment = value.addedDepartment;
                            unselectedDepartment = value.unselectedDepartment;
                          });
                        },
                        child: Ink(
                          height: 30.0,
                          width: 150.0,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: const Center(
                            child: Text('Change Department',
                                style: TextStyle(color: Colors.white)),
                          ),
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

                    if (selectedBranch.isNotEmpty) {
                      await e.addEmployeeMultiBranch(
                        employeeId: employeeModel.employeeId,
                        branchId: selectedBranch,
                      );
                    }

                    if (unselectedBranch.isNotEmpty) {
                      await e.deleteEmployeeMultiBranch(
                          employeeId: employeeModel.employeeId,
                          branchId: unselectedBranch);
                    }

                    if (selectedDepartment.isNotEmpty) {
                      await e.addEmployeeMultiDepartment(
                        employeeId: employeeModel.employeeId,
                        departmentId: selectedDepartment,
                      );
                    }

                    if (unselectedDepartment.isNotEmpty) {
                      await e.deleteEmployeeMultiDepartment(
                          employeeId: employeeModel.employeeId,
                          departmentId: unselectedDepartment);
                    }
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
          title: const Text('Delete Employee?'),
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
                await d.deleteEmployee(
                    id: employeeModel.id, employeeId: employeeModel.employeeId);
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

  Future<EmlpoyeeMultiBranch> showSelectBranch(
      EmployeeModel employeeModel) async {
    var b = Provider.of<BranchProvider>(context, listen: false);
    var e = Provider.of<EmployeeProvider>(context, listen: false);
    await e.getBranchOfEmployee(employeeId: employeeModel.employeeId);
    await b.getBranchSelect();
    var selectedBranchList = <BranchModel>[...b.branchListSelect];
    var selectedBranchString = <String>[];
    var unselectedBranch = <String>[];
    // log(selectedBranchList.length.toString());
    for (int i = 0; i < selectedBranchList.length; i++) {
      for (int j = 0; j < e.branchOfEmployeeList.length; j++) {
        if (selectedBranchList[i].branchId ==
            e.branchOfEmployeeList[j].branchId) {
          selectedBranchList[i].selected = true;
        }
      }
    }
    if (mounted) {
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                contentPadding: const EdgeInsetsDirectional.all(10.0),
                content: SizedBox(
                  height: 500.0,
                  width: 400.0,
                  child: ListView.builder(
                    itemCount: selectedBranchList.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        value: selectedBranchList[index].selected,
                        title: Text(selectedBranchList[index].branchName),
                        onChanged: (bool? value) {
                          setState(() {
                            selectedBranchList[index].selected = value!;
                          });
                        },
                      );
                    },
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok', style: TextStyle(fontSize: 16.0)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child:
                        const Text('Cancel', style: TextStyle(fontSize: 16.0)),
                  ),
                ],
              );
            },
          );
        },
      );
    }

    for (final branch in selectedBranchList) {
      if (branch.selected) {
        selectedBranchString.add(branch.branchId);
      }
    }

    for (final branchOfEmployee in e.branchOfEmployeeList) {
      bool exist = selectedBranchString.contains(branchOfEmployee.branchId);
      if (exist) {
        selectedBranchString.remove(branchOfEmployee.branchId);
      }
    }

    for (final branch in selectedBranchList) {
      for (final branchOfEmployee in e.branchOfEmployeeList) {
        if (!branch.selected && branchOfEmployee.branchId == branch.branchId) {
          unselectedBranch.add(branch.branchId);
        }
      }
    }

    return EmlpoyeeMultiBranch(
      addedBranch: selectedBranchString,
      unselectedBranch: unselectedBranch,
    );
  }

  Future<EmlpoyeeMultiDepartment> showSelectDepartment(
      EmployeeModel employeeModel) async {
    var b = Provider.of<DepartmentProvider>(context, listen: false);
    var e = Provider.of<EmployeeProvider>(context, listen: false);
    await e.getDepartmentOfEmployee(employeeId: employeeModel.employeeId);
    await b.getDepartmentSelect();
    var selectedDepartmentList = <DepartmentModel>[...b.departmentListSelect];
    var selectedDepartmentString = <String>[];
    var unselectedDepartment = <String>[];
    // log(selectedBranchList.length.toString());
    for (int i = 0; i < selectedDepartmentList.length; i++) {
      for (int j = 0; j < e.departmentOfEmployeeList.length; j++) {
        if (selectedDepartmentList[i].departmentId ==
            e.departmentOfEmployeeList[j].departmentId) {
          selectedDepartmentList[i].selected = true;
        }
      }
    }
    if (mounted) {
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                contentPadding: const EdgeInsetsDirectional.all(10.0),
                content: SizedBox(
                  height: 500.0,
                  width: 400.0,
                  child: ListView.builder(
                    itemCount: selectedDepartmentList.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        value: selectedDepartmentList[index].selected,
                        title:
                            Text(selectedDepartmentList[index].departmentName),
                        onChanged: (bool? value) {
                          setState(() {
                            selectedDepartmentList[index].selected = value!;
                          });
                        },
                      );
                    },
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok', style: TextStyle(fontSize: 16.0)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child:
                        const Text('Cancel', style: TextStyle(fontSize: 16.0)),
                  ),
                ],
              );
            },
          );
        },
      );
    }

    for (final department in selectedDepartmentList) {
      if (department.selected) {
        selectedDepartmentString.add(department.departmentId);
      }
    }

    for (final departmentOfEmployee in e.departmentOfEmployeeList) {
      bool exist =
          selectedDepartmentString.contains(departmentOfEmployee.departmentId);
      if (exist) {
        selectedDepartmentString.remove(departmentOfEmployee.departmentId);
      }
    }

    for (final department in selectedDepartmentList) {
      for (final departmentOfEmployee in e.departmentOfEmployeeList) {
        if (!department.selected &&
            departmentOfEmployee.departmentId == department.departmentId) {
          unselectedDepartment.add(department.departmentId);
        }
      }
    }

    return EmlpoyeeMultiDepartment(
      addedDepartment: selectedDepartmentString,
      unselectedDepartment: unselectedDepartment,
    );
  }

  @override
  Widget build(BuildContext context) {
    const idw = 100.0;
    const empIdw = 150.0;
    const dIdw = 300.0;
    const wsIdw = 200.0;

    return Scaffold(
      body: Consumer<EmployeeProvider>(
        builder: ((context, provider, child) {
          return RefreshIndicator(
            onRefresh: () async {
              await provider.getEmployee();
            },
            child: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverAppBarDelegate(
                    minHeight: 100.0,
                    maxHeight: 100.0,
                    child: Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 500.0,
                              child: TextField(
                                style: const TextStyle(fontSize: 20.0),
                                decoration: const InputDecoration(
                                  label: Text('Search name/id..'),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.fromLTRB(
                                      12.0, 12.0, 12.0, 12.0),
                                  isDense: true,
                                ),
                                controller: idController,
                                onChanged: (String value) async {
                                  if (idController.text.isEmpty) {
                                    provider.changeStateSearching(false);
                                  } else {
                                    provider.changeStateSearching(true);
                                    await provider.searchEmployee(
                                      employeeId: value.trim(),
                                    );
                                  }
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {
                                      provider.sortEmployeeListId();
                                    },
                                    child: Ink(
                                      width: idw,
                                      child: const Center(
                                        child: Text(
                                          'ID',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: InkWell(
                                    onTap: () {
                                      provider.sortEmployeeListEmpId();
                                    },
                                    child: Ink(
                                      width: empIdw,
                                      child: const Center(
                                        child: Text(
                                          'Emp ID',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  child: InkWell(
                                    onTap: () {
                                      provider.sortEmployeeListName();
                                    },
                                    child: Ink(
                                      width: dIdw,
                                      child: const Center(
                                        child: Text(
                                          'Name',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const RowWidget(
                                    s: 'Week Schedule',
                                    w: wsIdw,
                                    c: Colors.yellow,
                                    f: 2,
                                    bold: true),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // SliverToBoxAdapter(
                //   child: SizedBox(
                //     width: 500.0,
                //     child: TextField(
                //       enabled: true,
                //       style: const TextStyle(fontSize: 20.0),
                //       decoration: const InputDecoration(
                //         label: Text('Search name/id..'),
                //         border: OutlineInputBorder(
                //           borderSide: BorderSide(
                //             color: Colors.grey,
                //             width: 1.0,
                //           ),
                //         ),
                //         contentPadding:
                //             EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                //       ),
                //       controller: idController,
                //       onChanged: (String value) async {
                //         if (idController.text.isEmpty) {
                //           provider.changeStateSearching(false);
                //         } else {
                //           provider.changeStateSearching(true);
                //           await provider.searchEmployee(
                //             employeeId: value.trim(),
                //           );
                //         }
                //       },
                //     ),
                //   ),
                // ),
                if (provider.isSearching) ...[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        bool isActive =
                            provider.searchEmployeeList[index].active == 1
                                ? true
                                : false;
                        return Card(
                          child: InkWell(
                            onTap: () {
                              updateEmployee(
                                  provider.searchEmployeeList[index]);
                            },
                            onLongPress: () {
                              confirmDeleteEmployeeBranch(
                                  provider.searchEmployeeList[index]);
                            },
                            child: Ink(
                              color: isActive ? null : Colors.red[200],
                              height: 50.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RowWidget(
                                    s: provider.searchEmployeeList[index].id
                                        .toString(),
                                    w: idw,
                                    c: Colors.red,
                                    f: 1,
                                  ),
                                  RowWidget(
                                    s: provider
                                        .searchEmployeeList[index].employeeId,
                                    w: empIdw,
                                    c: Colors.green,
                                    f: 2,
                                  ),
                                  RowWidget(
                                    s: provider.fullName(
                                        provider.searchEmployeeList[index]),
                                    w: dIdw,
                                    c: Colors.blue,
                                    f: 3,
                                  ),
                                  RowWidget(
                                    s: provider
                                        .searchEmployeeList[index].weekSchedId,
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
                      childCount: provider.searchEmployeeList.length,
                    ),
                  ),
                ] else ...[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        bool isActive = provider.employeeList[index].active == 1
                            ? true
                            : false;
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
                              color: isActive ? null : Colors.red[200],
                              height: 50.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RowWidget(
                                    s: provider.employeeList[index].id
                                        .toString(),
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
              ],
            ),
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

class EmlpoyeeMultiBranch {
  List<String> addedBranch;
  List<String> unselectedBranch;

  EmlpoyeeMultiBranch({
    required this.addedBranch,
    required this.unselectedBranch,
  });
}

class EmlpoyeeMultiDepartment {
  List<String> addedDepartment;
  List<String> unselectedDepartment;

  EmlpoyeeMultiDepartment({
    required this.addedDepartment,
    required this.unselectedDepartment,
  });
}
