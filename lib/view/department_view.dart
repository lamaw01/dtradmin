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

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var dp = Provider.of<DepartmentProvider>(context, listen: false);
      var dpe = Provider.of<DepartmentEmployeeProvider>(context, listen: false);

      await dp.getDepartment();
      await dpe.getDepartmentEmployee();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (tabController.index == 0) {
            addDepartment();
          } else {
            // addEmployeeBranch();
          }
        },
        child: const Text('Add'),
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
                          s: 'Department Name',
                          w: dnw,
                          c: Colors.green,
                          f: 3,
                        ),
                        RowWidget(
                          s: 'Department ID',
                          w: dIdw,
                          c: Colors.blue,
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
                              s: provider.departmentList[index].departmentName,
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
    const idw = 100.0;
    const dnw = 350.0;
    const dIdw = 200.0;

    return Consumer<DepartmentEmployeeProvider>(
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
                          s: 'Department Name',
                          w: dnw,
                          c: Colors.green,
                          f: 3,
                        ),
                        RowWidget(
                          s: 'Department ID',
                          w: dIdw,
                          c: Colors.blue,
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
                  return Card(
                    child: SizedBox(
                      height: 50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RowWidget(
                            s: provider.departmentEmployeeList[index].id
                                .toString(),
                            w: idw,
                            c: Colors.red,
                            f: 1,
                          ),
                          RowWidget(
                            s: provider.fullName(
                                provider.departmentEmployeeList[index]),
                            w: dnw,
                            c: Colors.green,
                            f: 3,
                          ),
                          RowWidget(
                            s: provider
                                .departmentEmployeeList[index].departmentName,
                            w: dIdw,
                            c: Colors.blue,
                            f: 2,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: provider.departmentEmployeeList.length,
              ),
            ),
          ],
        );
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
