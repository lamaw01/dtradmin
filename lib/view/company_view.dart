import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/company_model.dart';
import '../provider/company_employee_provider.dart';
import '../provider/company_provider.dart';
import '../widget/delegate.dart';
import '../widget/row_widget.dart';
import '../widget/snackbar_widget.dart';

class CompanyView extends StatefulWidget {
  const CompanyView({super.key});

  @override
  State<CompanyView> createState() => _CompanyViewState();
}

class _CompanyViewState extends State<CompanyView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  ValueNotifier<bool> hideFloating = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var c = Provider.of<CompanyProvider>(context, listen: false);

      await c.getCompany();
      await c.getCompanyForEmployee();

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
    void addCompany() async {
      var b = Provider.of<CompanyProvider>(context, listen: false);

      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final companyName = TextEditingController();
          final companyId = TextEditingController();

          return AlertDialog(
            title: const Text('Add Company'),
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
                          controller: companyName,
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
                          controller: companyId,
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
                  bool companyExist = b.checkCompanyId(companyId.text.trim());
                  if (companyName.text.isEmpty || companyId.text.isEmpty) {
                    snackBarError('Invalid Company', context);
                  } else if (companyExist) {
                    snackBarError('Company Already Exist', context);
                  } else {
                    await b.addCompany(
                      companyId: companyId.text.trim(),
                      companyName: companyName.text.trim(),
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
                  Tab(text: 'Company'),
                  Tab(text: 'Employees Company'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  CompanyPage(),
                  CompanyEmployeePage(),
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
                  addCompany();
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

class CompanyPage extends StatefulWidget {
  const CompanyPage({super.key});

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage>
    with AutomaticKeepAliveClientMixin<CompanyPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    const idw = 100.0;
    const bIdw = 200.0;
    const bw = 350.0;

    void updateCompany(CompanyModel companyModel) async {
      var b = Provider.of<CompanyProvider>(context, listen: false);

      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final companyName =
              TextEditingController(text: companyModel.companyName);
          final companyId = TextEditingController(text: companyModel.companyId);

          return AlertDialog(
            title: const Text('Update Company'),
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
                          controller: companyName,
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
                          controller: companyId,
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
                  bool companyExist = b.checkCompanyId(companyId.text.trim());
                  if (companyName.text.isEmpty || companyId.text.isEmpty) {
                    snackBarError('Invalid Company', context);
                  } else if (companyExist &&
                      companyModel.companyId.trim() != companyId.text) {
                    snackBarError('Company Already Exist', context);
                  } else {
                    await b.updateCompany(
                      companyId: companyId.text.trim(),
                      companyName: companyName.text.trim(),
                      id: companyModel.id,
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

    void confirmDeleteCompany(CompanyModel companyModel) async {
      var b = Provider.of<CompanyProvider>(context, listen: false);
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Remove Company'),
            content: Text('Delete ${companyModel.companyName}?'),
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
                  await b.deleteCompany(id: companyModel.id);
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

    return Consumer<CompanyProvider>(
      builder: ((context, provider, child) {
        return RefreshIndicator(
          onRefresh: () async {},
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
                              s: 'Company Name',
                              w: bIdw,
                              c: Colors.green,
                              f: 3,
                              bold: true),
                          RowWidget(
                              s: 'Company ID',
                              w: bw,
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
                        onTap: () async {
                          updateCompany(provider.companyList[index]);
                        },
                        onLongPress: () {
                          confirmDeleteCompany(provider.companyList[index]);
                        },
                        child: Ink(
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RowWidget(
                                s: provider.companyList[index].id.toString(),
                                w: idw,
                                c: Colors.red,
                                f: 1,
                              ),
                              RowWidget(
                                s: provider.companyList[index].companyName,
                                w: bIdw,
                                c: Colors.green,
                                f: 3,
                              ),
                              RowWidget(
                                s: provider.companyList[index].companyId,
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
                  childCount: provider.companyList.length,
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

class CompanyEmployeePage extends StatefulWidget {
  const CompanyEmployeePage({super.key});

  @override
  State<CompanyEmployeePage> createState() => _CompanyEmployeePageState();
}

class _CompanyEmployeePageState extends State<CompanyEmployeePage>
    with AutomaticKeepAliveClientMixin<CompanyEmployeePage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    // return const Center(
    //   child: Text('Company Employee Page'),
    // );
    return Consumer<CompanyProvider>(
      builder: (context, provider, child) {
        return RefreshIndicator(
          onRefresh: () async {
            await provider.getCompanyForEmployee();
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
                        child: DropdownButton<CompanyModel>(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          borderRadius: BorderRadius.circular(5),
                          value: provider.selectedCompany,
                          onChanged: (CompanyModel? value) async {
                            if (value != null) {
                              provider.changeSelectedCompany(value);
                              var dep = Provider.of<CompanyEmployeeProvider>(
                                  context,
                                  listen: false);

                              await dep.getEmployeeCompanyUnassigned();
                              await dep.getEmployeeAssignedCompany(
                                  companyId: value.companyId);
                              dep.removeEmployeeAssignedDuplicate();
                            }
                          },
                          items: provider.companyListForEmployee
                              .map<DropdownMenuItem<CompanyModel>>(
                                  (CompanyModel value) {
                            return DropdownMenuItem<CompanyModel>(
                              value: value,
                              child: Text(value.companyName),
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
                          Consumer<CompanyEmployeeProvider>(
                              builder: (context, provider, child) {
                            return Flexible(
                              flex: 1,
                              child: SizedBox(
                                width: 500.0,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const Divider(height: 0.0),
                                  itemCount: provider
                                      .employeeUnassigendCompanyList.length,
                                  itemBuilder: ((context, index) {
                                    return CheckboxListTile(
                                      title: Text(provider.fullNameEmp(provider
                                              .employeeUnassigendCompanyList[
                                          index])),
                                      value: provider
                                          .employeeUnassigendCompanyList[index]
                                          .isSelected,
                                      onChanged: (bool? value) {
                                        if (value != null) {
                                          setState(() {
                                            provider
                                                .employeeUnassigendCompanyList[
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
                                      Provider.of<CompanyEmployeeProvider>(
                                          context,
                                          listen: false);
                                  var bp = Provider.of<CompanyProvider>(context,
                                      listen: false);
                                  final listOfEmployeeId =
                                      bep.assignedListToAdd();
                                  await bep.addEmployeeCompanyMulti(
                                      companyId: bp.selectedCompany.companyId,
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
                                      Provider.of<CompanyEmployeeProvider>(
                                          context,
                                          listen: false);
                                  var bp = Provider.of<CompanyProvider>(context,
                                      listen: false);
                                  final listOfEmployeeId =
                                      bep.unAssignedListToAdd();
                                  await bep.deleteEmployeeCompanyMulti(
                                      companyId: bp.selectedCompany.companyId,
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
                          Consumer<CompanyEmployeeProvider>(
                              builder: (context, provider, child) {
                            return Flexible(
                              flex: 1,
                              child: SizedBox(
                                width: 500.0,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const Divider(height: 0.0),
                                  itemCount:
                                      provider.employeeAssignedCompany.length,
                                  itemBuilder: ((context, index) {
                                    return CheckboxListTile(
                                      title: Text(provider.fullNameEmpOfCompany(
                                          provider
                                              .employeeAssignedCompany[index])),
                                      value: provider
                                          .employeeAssignedCompany[index]
                                          .isSelected,
                                      onChanged: (bool? value) {
                                        if (value != null) {
                                          setState(() {
                                            provider
                                                .employeeAssignedCompany[index]
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
