import 'package:dtradmin/model/branch_model.dart';
import 'package:dtradmin/model/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/branch_employee_provider.dart';
import '../provider/branch_provider.dart';
import '../provider/employee_provider.dart';
import '../widget/delegate.dart';
import '../widget/row_widget.dart';
import '../widget/snackbar_widget.dart';

class BranchView extends StatefulWidget {
  const BranchView({super.key});

  @override
  State<BranchView> createState() => _BranchViewState();
}

class _BranchViewState extends State<BranchView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var b = Provider.of<BranchProvider>(context, listen: false);
      // var be = Provider.of<BranchEmployeeProvider>(context, listen: false);

      await b.getBranch();
      // await be.getEmployeeBranch();
    });
  }

  @override
  Widget build(BuildContext context) {
    void addBranch() async {
      var b = Provider.of<BranchProvider>(context, listen: false);

      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final branchName = TextEditingController();
          final branchId = TextEditingController();

          return AlertDialog(
            title: const Text('Add Branch'),
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
                          controller: branchName,
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
                          controller: branchId,
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
                  bool branchExist = b.checkBranchId(branchId.text.trim());
                  if (branchName.text.isEmpty || branchId.text.isEmpty) {
                    snackBarError('Invalid Branch', context);
                  } else if (branchExist) {
                    snackBarError('Branch Already Exist', context);
                  } else {
                    await b.addBranch(
                      branchId: branchId.text.trim(),
                      branchName: branchName.text.trim(),
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

    // ignore: unused_element
    void addEmployeeBranch() async {
      var be = Provider.of<BranchEmployeeProvider>(context, listen: false);
      var ep = Provider.of<EmployeeProvider>(context, listen: false);
      var bp = Provider.of<BranchProvider>(context, listen: false);
      await ep.getEmployee();
      if (mounted) {
        await showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            var branchList = <BranchModel>[
              BranchModel(id: 0, branchId: '000', branchName: '--Select--')
            ];
            branchList.addAll(bp.branchList);
            var ddBranchValue = branchList.first;

            var employeeList = <EmployeeModel>[
              EmployeeModel(
                id: 0,
                employeeId: '00000',
                firstName: '',
                lastName: '--Select--',
                middleName: '',
                weekSchedId: '',
                active: 1,
              )
            ];
            employeeList.addAll(ep.employeeList);
            var ddEmployeeValue = employeeList.first;

            return AlertDialog(
              title: const Text('Add Employee Branch'),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Branch:'),
                            const SizedBox(width: 5.0),
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
                                child: DropdownButton<BranchModel>(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  borderRadius: BorderRadius.circular(5),
                                  value: ddBranchValue,
                                  onChanged: (BranchModel? value) async {
                                    if (value != null) {
                                      setState(() {
                                        ddBranchValue = value;
                                      });
                                    }
                                  },
                                  items: branchList
                                      .map<DropdownMenuItem<BranchModel>>(
                                          (BranchModel value) {
                                    return DropdownMenuItem<BranchModel>(
                                      value: value,
                                      child: Text(value.branchName),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Employee:'),
                            const SizedBox(width: 5.0),
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
                                child: DropdownButton<EmployeeModel>(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  borderRadius: BorderRadius.circular(5),
                                  value: ddEmployeeValue,
                                  onChanged: (EmployeeModel? value) async {
                                    if (value != null) {
                                      setState(() {
                                        ddEmployeeValue = value;
                                      });
                                    }
                                  },
                                  items: employeeList
                                      .map<DropdownMenuItem<EmployeeModel>>(
                                          (EmployeeModel value) {
                                    return DropdownMenuItem<EmployeeModel>(
                                      value: value,
                                      child: Text(ep.fullName(value)),
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
                    bool employeebranchExist = be.checkEmployeeBranchId(
                      employeeId: ddEmployeeValue.employeeId,
                      branchId: ddBranchValue.branchId,
                    );
                    if (ddEmployeeValue.employeeId == '00000' ||
                        ddBranchValue.branchId == '000') {
                      snackBarError('Invalid Employee or Branch', context);
                    } else if (employeebranchExist) {
                      snackBarError('Employee Already Branch', context);
                    } else {
                      await be.addEmployeeBranch(
                        employeeId: ddEmployeeValue.employeeId,
                        branchId: ddBranchValue.branchId,
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
                  Tab(text: 'Branch'),
                  Tab(text: 'Employees Branch'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  BranchPage(),
                  BranchEmployeePage(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (tabController.index == 0) {
            addBranch();
          } else {
            // addEmployeeBranch();
          }
        },
        child: const Text('Add'),
      ),
    );
  }
}

class BranchPage extends StatefulWidget {
  const BranchPage({super.key});

  @override
  State<BranchPage> createState() => _BranchPageState();
}

class _BranchPageState extends State<BranchPage>
    with AutomaticKeepAliveClientMixin<BranchPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    const idw = 100.0;
    const bIdw = 200.0;
    const bw = 350.0;

    void updateBranch(BranchModel branchModel) async {
      var b = Provider.of<BranchProvider>(context, listen: false);

      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final branchName =
              TextEditingController(text: branchModel.branchName);
          final branchId = TextEditingController(text: branchModel.branchId);

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
                          controller: branchName,
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
                          controller: branchId,
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
                  bool branchExist = b.checkBranchId(branchId.text.trim());
                  if (branchName.text.isEmpty || branchId.text.isEmpty) {
                    snackBarError('Invalid Branch', context);
                  } else if (branchExist &&
                      branchModel.branchId.trim() != branchId.text) {
                    snackBarError('Branch Already Exist', context);
                  } else {
                    await b.updateBranch(
                      branchId: branchId.text.trim(),
                      branchName: branchName.text.trim(),
                      id: branchModel.id,
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

    void confirmDeleteBranch(BranchModel branchModel) async {
      var b = Provider.of<BranchProvider>(context, listen: false);
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Remove Device'),
            content: Text('Delete ${branchModel.branchName}?'),
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
                  await b.deleteBranch(id: branchModel.id);
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

    return Consumer<BranchProvider>(
      builder: ((context, provider, child) {
        return RefreshIndicator(
          onRefresh: () async {
            await provider.getBranch();
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
                            s: 'ID',
                            w: idw,
                            c: Colors.red,
                            f: 1,
                          ),
                          RowWidget(
                            s: 'Branch Name',
                            w: bIdw,
                            c: Colors.green,
                            f: 3,
                          ),
                          RowWidget(
                            s: 'Branch ID',
                            w: bw,
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
                        onTap: () async {
                          updateBranch(provider.branchList[index]);
                        },
                        onLongPress: () {
                          confirmDeleteBranch(provider.branchList[index]);
                        },
                        child: Ink(
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RowWidget(
                                s: provider.branchList[index].id.toString(),
                                w: idw,
                                c: Colors.red,
                                f: 1,
                              ),
                              RowWidget(
                                s: provider.branchList[index].branchName,
                                w: bIdw,
                                c: Colors.green,
                                f: 3,
                              ),
                              RowWidget(
                                s: provider.branchList[index].branchId,
                                w: bw,
                                c: Colors.blue,
                                f: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: provider.branchList.length,
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

class BranchEmployeePage extends StatefulWidget {
  const BranchEmployeePage({super.key});

  @override
  State<BranchEmployeePage> createState() => _BranchEmployeePageState();
}

class _BranchEmployeePageState extends State<BranchEmployeePage>
    with AutomaticKeepAliveClientMixin<BranchEmployeePage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    // const idw = 100.0;
    // const nw = 400.0;
    // const bw = 200.0;

    // void updateEmployeeBranch(BranchEmployeeModel branchEmployeeModel) async {
    //   var be = Provider.of<BranchEmployeeProvider>(context, listen: false);
    //   var ep = Provider.of<EmployeeProvider>(context, listen: false);
    //   var bp = Provider.of<BranchProvider>(context, listen: false);
    //   await ep.getEmployee();
    //   BranchModel branchSolo = bp.branchList
    //       .singleWhere((e) => e.branchId == branchEmployeeModel.branchId);
    //   EmployeeModel employeeSolo = ep.employeeList
    //       .singleWhere((e) => e.employeeId == branchEmployeeModel.employeeId);
    //   if (mounted) {
    //     await showDialog<void>(
    //       context: context,
    //       barrierDismissible: false,
    //       builder: (BuildContext context) {
    //         var branchList = <BranchModel>[];
    //         branchList.addAll(bp.branchList);
    //         var ddBranchValue = branchSolo;

    //         var employeeList = <EmployeeModel>[];
    //         employeeList.addAll(ep.employeeList);
    //         var ddEmployeeValue = employeeSolo;

    //         return AlertDialog(
    //           title: const Text('Add Employee Branch'),
    //           content: SizedBox(
    //             // height: 200.0,
    //             width: 400.0,
    //             child: StatefulBuilder(
    //               builder: (context, setState) {
    //                 return Column(
    //                   mainAxisSize: MainAxisSize.min,
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         const Text('Branch:'),
    //                         const SizedBox(width: 5.0),
    //                         Container(
    //                           height: 40.0,
    //                           width: 300.0,
    //                           decoration: BoxDecoration(
    //                             borderRadius: BorderRadius.circular(5),
    //                             border: Border.all(
    //                               color: Colors.grey,
    //                               style: BorderStyle.solid,
    //                               width: 1.0,
    //                             ),
    //                           ),
    //                           child: DropdownButtonHideUnderline(
    //                             child: DropdownButton<BranchModel>(
    //                               padding: const EdgeInsets.symmetric(
    //                                   horizontal: 10.0),
    //                               borderRadius: BorderRadius.circular(5),
    //                               value: ddBranchValue,
    //                               onChanged: (BranchModel? value) async {
    //                                 if (value != null) {
    //                                   setState(() {
    //                                     ddBranchValue = value;
    //                                   });
    //                                 }
    //                               },
    //                               items: branchList
    //                                   .map<DropdownMenuItem<BranchModel>>(
    //                                       (BranchModel value) {
    //                                 return DropdownMenuItem<BranchModel>(
    //                                   value: value,
    //                                   child: Text(value.branchName),
    //                                 );
    //                               }).toList(),
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                     const SizedBox(height: 10.0),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         const Text('Employee:'),
    //                         const SizedBox(width: 5.0),
    //                         Container(
    //                           height: 40.0,
    //                           width: 300.0,
    //                           decoration: BoxDecoration(
    //                             borderRadius: BorderRadius.circular(5),
    //                             border: Border.all(
    //                               color: Colors.grey,
    //                               style: BorderStyle.solid,
    //                               width: 1.0,
    //                             ),
    //                           ),
    //                           child: DropdownButtonHideUnderline(
    //                             child: DropdownButton<EmployeeModel>(
    //                               padding: const EdgeInsets.symmetric(
    //                                   horizontal: 10.0),
    //                               borderRadius: BorderRadius.circular(5),
    //                               value: ddEmployeeValue,
    //                               onChanged: (EmployeeModel? value) async {
    //                                 if (value != null) {
    //                                   setState(() {
    //                                     ddEmployeeValue = value;
    //                                   });
    //                                 }
    //                               },
    //                               items: employeeList
    //                                   .map<DropdownMenuItem<EmployeeModel>>(
    //                                       (EmployeeModel value) {
    //                                 return DropdownMenuItem<EmployeeModel>(
    //                                   value: value,
    //                                   child: Text(ep.fullName(value)),
    //                                 );
    //                               }).toList(),
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 );
    //               },
    //             ),
    //           ),
    //           actions: <Widget>[
    //             TextButton(
    //               child: const Text(
    //                 'Cancel',
    //                 style: TextStyle(fontSize: 16.0),
    //               ),
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //               },
    //             ),
    //             TextButton(
    //               child: const Text(
    //                 'Ok',
    //                 style: TextStyle(fontSize: 16.0),
    //               ),
    //               onPressed: () async {
    //                 bool employeebranchExist = be.checkEmployeeBranchId(
    //                   employeeId: ddEmployeeValue.employeeId,
    //                   branchId: ddBranchValue.branchId,
    //                 );
    //                 if (ddEmployeeValue.employeeId == '00000' ||
    //                     ddBranchValue.branchId == '000') {
    //                   snackBarError('Invalid Employee or Branch', context);
    //                 } else if (employeebranchExist &&
    //                     ddEmployeeValue.employeeId !=
    //                         branchEmployeeModel.employeeId) {
    //                   snackBarError('Employee Already Branch', context);
    //                 } else {
    //                   await be.updateEmployeeBranch(
    //                     employeeId: ddEmployeeValue.employeeId,
    //                     branchId: ddBranchValue.branchId,
    //                     id: branchEmployeeModel.id,
    //                   );
    //                 }
    //                 if (mounted) {
    //                   Navigator.of(context).pop();
    //                 }
    //               },
    //             ),
    //           ],
    //         );
    //       },
    //     );
    //   }
    // }

    // void confirmDeleteEmployeeBranch(BranchEmployeeModel employeeModel) async {
    //   var d = Provider.of<BranchEmployeeProvider>(context, listen: false);
    //   await showDialog<void>(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: const Text('Remove Employee in Branch'),
    //         content: Text(
    //             'Delete ${d.fullName(employeeModel)} in ${employeeModel.branchName}?'),
    //         actions: <Widget>[
    //           TextButton(
    //             child: const Text(
    //               'Cancel',
    //               style: TextStyle(fontSize: 16.0),
    //             ),
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //           ),
    //           TextButton(
    //             child: const Text(
    //               'Ok',
    //               style: TextStyle(fontSize: 16.0),
    //             ),
    //             onPressed: () async {
    //               await d.deleteEmployeeBranch(employeeModel.id);
    //               if (mounted) {
    //                 Navigator.of(context).pop();
    //               }
    //             },
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }

    // return Consumer<BranchEmployeeProvider>(
    //   builder: ((context, provider, child) {
    //     return RefreshIndicator(
    //       onRefresh: () async {
    //         await provider.getEmployeeBranch();
    //       },
    //       child: CustomScrollView(
    //         slivers: [
    //           SliverPersistentHeader(
    //             pinned: true,
    //             delegate: SliverAppBarDelegate(
    //               minHeight: 60.0,
    //               maxHeight: 60.0,
    //               child: Container(
    //                 color: Theme.of(context).scaffoldBackgroundColor,
    //                 child: Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: 5.0),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: [
    //                       Flexible(
    //                         flex: 1,
    //                         child: InkWell(
    //                           onTap: () {
    //                             provider.sortBranchListId();
    //                           },
    //                           child: Ink(
    //                             width: idw,
    //                             child: const Center(
    //                               child: Text(
    //                                 'ID',
    //                                 maxLines: 3,
    //                                 overflow: TextOverflow.ellipsis,
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       Flexible(
    //                         flex: 4,
    //                         child: InkWell(
    //                           onTap: () {
    //                             provider.sortBranchListLastName();
    //                           },
    //                           child: Ink(
    //                             width: nw,
    //                             child: const Center(
    //                               child: Text(
    //                                 'Name',
    //                                 maxLines: 3,
    //                                 overflow: TextOverflow.ellipsis,
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       const RowWidget(
    //                         s: 'Branch',
    //                         w: bw,
    //                         c: Colors.blue,
    //                         f: 2,
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //           SliverList(
    //             delegate: SliverChildBuilderDelegate(
    //               (BuildContext context, int index) {
    //                 return Card(
    //                   child: InkWell(
    //                     onTap: () {
    //                       updateEmployeeBranch(
    //                           provider.branchEmployeeList[index]);
    //                     },
    //                     onLongPress: () {
    //                       confirmDeleteEmployeeBranch(
    //                           provider.branchEmployeeList[index]);
    //                     },
    //                     child: Ink(
    //                       height: 50.0,
    //                       child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                         crossAxisAlignment: CrossAxisAlignment.center,
    //                         children: [
    //                           RowWidget(
    //                             s: provider.branchEmployeeList[index].id
    //                                 .toString(),
    //                             w: idw,
    //                             c: Colors.red,
    //                             f: 1,
    //                           ),
    //                           RowWidget(
    //                             s: provider.fullName(
    //                                 provider.branchEmployeeList[index]),
    //                             w: nw,
    //                             c: Colors.green,
    //                             f: 4,
    //                           ),
    //                           RowWidget(
    //                             s: provider
    //                                 .branchEmployeeList[index].branchName,
    //                             w: bw,
    //                             c: Colors.blue,
    //                             f: 2,
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                 );
    //               },
    //               childCount: provider.branchEmployeeList.length,
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   }),
    // );

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Consumer<BranchProvider>(
            builder: (context, provider, child) {
              return Container(
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
                  child: DropdownButton<BranchModel>(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    borderRadius: BorderRadius.circular(5),
                    value: provider.selectedBranch,
                    onChanged: (BranchModel? value) async {
                      if (value != null) {
                        provider.changeSelectedBranch(value);
                        var bep = Provider.of<BranchEmployeeProvider>(context,
                            listen: false);
                        await bep.getEmployeeUnassignedBranch(
                            branchId: value.branchId);
                        await bep.getEmployeeAssignedBranch(
                            branchId: value.branchId);
                        bep.removeAssignedDuplicate();
                      }
                    },
                    items: provider.branchList
                        .map<DropdownMenuItem<BranchModel>>(
                            (BranchModel value) {
                      return DropdownMenuItem<BranchModel>(
                        value: value,
                        child: Text(value.branchName),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
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
                Consumer<BranchEmployeeProvider>(
                    builder: (context, provider, child) {
                  return Flexible(
                    flex: 1,
                    child: SizedBox(
                      // color: Colors.pink,
                      // height: 700.0,
                      width: 500.0,
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            const Divider(height: 0.0),
                        itemCount: provider.employeeUnassignedBranch.length,
                        itemBuilder: ((context, index) {
                          // return InkWell(
                          //   onTap: () async {
                          //     // var bep = Provider.of<BranchEmployeeProvider>(
                          //     //     context,
                          //     //     listen: false);
                          //     // await bep.getEmployeeOfBranch(
                          //     //     branchId:
                          //     //         provider.branchList[index].branchId);
                          //   },
                          //   child: Ink(
                          //     height: 40.0,
                          //     width: 500.0,
                          //     child: Center(
                          //       child: Text(provider.fullNameEmpOfBranch(
                          //           provider.employeeUnassignedBranch[index])),
                          //     ),
                          //   ),
                          // );
                          return CheckboxListTile(
                            title: Text(provider.fullNameEmpOfBranch(
                                provider.employeeUnassignedBranch[index])),
                            value: provider
                                .employeeUnassignedBranch[index].isSelected,
                            onChanged: (bool? value) {
                              if (value != null) {
                                setState(() {
                                  provider.employeeUnassignedBranch[index]
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
                        var bep = Provider.of<BranchEmployeeProvider>(context,
                            listen: false);
                        var bp =
                            Provider.of<BranchProvider>(context, listen: false);
                        final listOfEmployeeId = bep.assignedListToAdd();
                        await bep.addEmployeeBranchMulti(
                            branchId: bp.selectedBranch.branchId,
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
                      onTap: () {},
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
                Consumer<BranchEmployeeProvider>(
                    builder: (context, provider, child) {
                  return Flexible(
                    flex: 1,
                    child: SizedBox(
                      // color: Colors.amber,
                      // height: 700.0,
                      width: 500.0,
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            const Divider(height: 0.0),
                        itemCount: provider.employeeAssignedBranch.length,
                        itemBuilder: ((context, index) {
                          // return InkWell(
                          //   onTap: () {},
                          //   child: Ink(
                          //     height: 40.0,
                          //     width: 500.0,
                          //     child: Center(
                          //       child: Text(provider.fullNameEmpOfBranch(
                          //           provider.employeeAssignedBranch[index])),
                          //     ),
                          //   ),
                          // );
                          return CheckboxListTile(
                            title: Text(provider.fullNameEmpOfBranch(
                                provider.employeeAssignedBranch[index])),
                            value: provider
                                .employeeAssignedBranch[index].isSelected,
                            onChanged: (bool? value) {
                              if (value != null) {
                                setState(() {
                                  provider.employeeAssignedBranch[index]
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
