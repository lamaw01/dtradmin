import 'package:dtradmin/model/department_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/department_employee_provider.dart';
import '../provider/department_provider.dart';
import '../widget/delegate.dart';
import '../widget/row_widget.dart';
import '../widget/snackbar_widget.dart';

class DepartmentView extends StatefulWidget {
  const DepartmentView({super.key});

  @override
  State<DepartmentView> createState() => _DepartmentViewState();
}

class _DepartmentViewState extends State<DepartmentView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  ValueNotifier<bool> hideFloating = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var dp = Provider.of<DepartmentProvider>(context, listen: false);

      await dp.getDepartment();
      await dp.getDepartmentForEmployee();

      tabController.addListener(() {
        if (tabController.index == 1) {
          hideFloating.value = true;
        } else {
          hideFloating.value = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    void addDepartment() async {
      var b = Provider.of<DepartmentProvider>(context, listen: false);

      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final departmentName = TextEditingController();
          final departmentId = TextEditingController();

          return AlertDialog(
            title: const Text('Add Department'),
            content: SizedBox(
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
                          controller: departmentName,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            label: Text('Name'),
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
                          controller: departmentId,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            label: Text('ID'),
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
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
                  bool branchExist =
                      b.checkDepartmentId(departmentId.text.trim());
                  if (departmentName.text.isEmpty ||
                      departmentId.text.isEmpty) {
                    snackBarError('Invalid Department', context);
                  } else if (branchExist) {
                    snackBarError('Department Already Exist', context);
                  } else {
                    await b.addDepartment(
                      departmentId: departmentId.text.trim(),
                      departmentName: departmentName.text.trim(),
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

    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              color: Colors.grey[400],
              child: TabBar(
                controller: tabController,
                indicatorColor: Colors.blue,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 4.0,
                tabs: const [
                  Tab(text: 'Deparment'),
                  Tab(text: 'Employees Department'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  DepartmentPage(),
                  DepartmentEmployeePage(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: hideFloating,
        builder: (context, value, child) {
          if (!value) {
            return FloatingActionButton(
              onPressed: () async {
                if (tabController.index == 0) {
                  addDepartment();
                }
              },
              child: const Text('Add'),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class DepartmentPage extends StatefulWidget {
  const DepartmentPage({super.key});

  @override
  State<DepartmentPage> createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage>
    with AutomaticKeepAliveClientMixin<DepartmentPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    const idw = 100.0;
    const dnw = 350.0;
    const dIdw = 200.0;

    void updateDepartment(DepartmentModel departmentModel) async {
      var b = Provider.of<DepartmentProvider>(context, listen: false);

      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final departmentName =
              TextEditingController(text: departmentModel.departmentName);
          final departmentId =
              TextEditingController(text: departmentModel.departmentId);

          return AlertDialog(
            title: const Text('Update Branch'),
            content: SizedBox(
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
                          controller: departmentName,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            label: Text('Name'),
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
                          controller: departmentId,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            label: Text('ID'),
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
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
                  bool branchExist =
                      b.checkDepartmentId(departmentId.text.trim());
                  if (departmentName.text.isEmpty ||
                      departmentId.text.isEmpty) {
                    snackBarError('Invalid Branch', context);
                  } else if (branchExist &&
                      departmentModel.departmentId.toString() !=
                          departmentId.text) {
                    snackBarError('Department Already Exist', context);
                  } else {
                    await b.updateDepartment(
                      departmentId: departmentId.text.trim(),
                      departmentName: departmentName.text.trim(),
                      id: departmentModel.id,
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

    void confirmDeleteBranch(DepartmentModel departmentModel) async {
      var b = Provider.of<DepartmentProvider>(context, listen: false);
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Remove Department'),
            content: Text('Delete ${departmentModel.departmentName}?'),
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
                  await b.deleteDepartment(id: departmentModel.id);
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

    return Consumer<DepartmentProvider>(
      builder: ((context, provider, child) {
        return RefreshIndicator(
          onRefresh: () async {
            await provider.getDepartment();
          },
          child: CustomScrollView(
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
                              s: 'ID', w: idw, c: Colors.red, f: 1, bold: true),
                          RowWidget(
                              s: 'Department Name',
                              w: dnw,
                              c: Colors.green,
                              f: 3,
                              bold: true),
                          RowWidget(
                              s: 'Department ID',
                              w: dIdw,
                              c: Colors.blue,
                              f: 2,
                              bold: true),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Card(
                      child: InkWell(
                        onTap: () {
                          updateDepartment(provider.departmentList[index]);
                        },
                        onLongPress: () {
                          confirmDeleteBranch(provider.departmentList[index]);
                        },
                        child: Ink(
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RowWidget(
                                s: provider.departmentList[index].id.toString(),
                                w: idw,
                                c: Colors.red,
                                f: 1,
                              ),
                              RowWidget(
                                s: provider
                                    .departmentList[index].departmentName,
                                w: dnw,
                                c: Colors.green,
                                f: 3,
                              ),
                              RowWidget(
                                s: provider.departmentList[index].departmentId,
                                w: dIdw,
                                c: Colors.blue,
                                f: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: provider.departmentList.length,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class DepartmentEmployeePage extends StatefulWidget {
  const DepartmentEmployeePage({super.key});

  @override
  State<DepartmentEmployeePage> createState() => _DepartmentEmployeePageState();
}

class _DepartmentEmployeePageState extends State<DepartmentEmployeePage>
    with AutomaticKeepAliveClientMixin<DepartmentEmployeePage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Consumer<DepartmentProvider>(
      builder: (context, provider, child) {
        return RefreshIndicator(
          onRefresh: () async {
            await provider.getDepartmentForEmployee();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 800.0,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: 40.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey,
                          style: BorderStyle.solid,
                          width: 1.0,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<DepartmentModel>(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          borderRadius: BorderRadius.circular(5),
                          value: provider.selectedDepartment,
                          onChanged: (DepartmentModel? value) async {
                            if (value != null) {
                              provider.changeSelectedDepartment(value);
                              var dep = Provider.of<DepartmentEmployeeProvider>(
                                  context,
                                  listen: false);

                              await dep.getEmployeeDepartmentUnassigned();
                              await dep.getEmployeeAssignedDepartment(
                                  departmentId: value.departmentId);
                              dep.removeEmployeeAssignedDuplicate();
                            }
                          },
                          items: provider.departmentListForEmployee
                              .map<DropdownMenuItem<DepartmentModel>>(
                                  (DepartmentModel value) {
                            return DropdownMenuItem<DepartmentModel>(
                              value: value,
                              child: Text(value.departmentName),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          flex: 1,
                          child: SizedBox(
                              width: 500.0,
                              height: 50.0,
                              child: Center(
                                  child: Text(
                                'Unassigned',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ))),
                        ),
                        Flexible(
                          flex: 1,
                          child: SizedBox(
                              width: 500.0,
                              height: 50.0,
                              child: Center(
                                  child: Text(
                                'Assigned',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ))),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Consumer<DepartmentEmployeeProvider>(
                              builder: (context, provider, child) {
                            return Flexible(
                              flex: 1,
                              child: SizedBox(
                                width: 500.0,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const Divider(height: 0.0),
                                  itemCount: provider
                                      .employeeUnassigendDepartmentList.length,
                                  itemBuilder: ((context, index) {
                                    return CheckboxListTile(
                                      title: Text(provider.fullNameEmp(provider
                                              .employeeUnassigendDepartmentList[
                                          index])),
                                      value: provider
                                          .employeeUnassigendDepartmentList[
                                              index]
                                          .isSelected,
                                      onChanged: (bool? value) {
                                        if (value != null) {
                                          setState(() {
                                            provider
                                                .employeeUnassigendDepartmentList[
                                                    index]
                                                .isSelected = value;
                                          });
                                        }
                                      },
                                      dense: true,
                                    );
                                  }),
                                ),
                              ),
                            );
                          }),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () async {
                                  var bep =
                                      Provider.of<DepartmentEmployeeProvider>(
                                          context,
                                          listen: false);
                                  var bp = Provider.of<DepartmentProvider>(
                                      context,
                                      listen: false);
                                  final listOfEmployeeId =
                                      bep.assignedListToAdd();
                                  await bep.addEmployeeDepartmentMulti(
                                      departmentId:
                                          bp.selectedDepartment.departmentId,
                                      employeeId: listOfEmployeeId);
                                },
                                child: Ink(
                                  color: Colors.green[400],
                                  width: 80.0,
                                  height: 35.0,
                                  child: const Center(
                                    child: Text(
                                      'Add>>',
                                      style: TextStyle(),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              InkWell(
                                onTap: () async {
                                  var bep =
                                      Provider.of<DepartmentEmployeeProvider>(
                                          context,
                                          listen: false);
                                  var bp = Provider.of<DepartmentProvider>(
                                      context,
                                      listen: false);
                                  final listOfEmployeeId =
                                      bep.unAssignedListToAdd();
                                  await bep.deleteEmployeeDepartmentMulti(
                                      departmentId:
                                          bp.selectedDepartment.departmentId,
                                      employeeId: listOfEmployeeId);
                                },
                                child: Ink(
                                  color: Colors.red[400],
                                  width: 80.0,
                                  height: 35.0,
                                  child: const Center(
                                    child: Text(
                                      '<<Remove',
                                      style: TextStyle(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Consumer<DepartmentEmployeeProvider>(
                              builder: (context, provider, child) {
                            return Flexible(
                              flex: 1,
                              child: SizedBox(
                                width: 500.0,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const Divider(height: 0.0),
                                  itemCount: provider
                                      .employeeAssignedDepartment.length,
                                  itemBuilder: ((context, index) {
                                    return CheckboxListTile(
                                      title: Text(provider
                                          .fullNameEmpOfDepartment(provider
                                                  .employeeAssignedDepartment[
                                              index])),
                                      value: provider
                                          .employeeAssignedDepartment[index]
                                          .isSelected,
                                      onChanged: (bool? value) {
                                        if (value != null) {
                                          setState(() {
                                            provider
                                                .employeeAssignedDepartment[
                                                    index]
                                                .isSelected = value;
                                          });
                                        }
                                      },
                                      dense: true,
                                    );
                                  }),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
