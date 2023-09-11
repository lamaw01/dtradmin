import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/department_employee_provider.dart';
import '../provider/departmet_provider.dart';

class DepartmentView extends StatefulWidget {
  const DepartmentView({super.key});

  @override
  State<DepartmentView> createState() => _DepartmentViewState();
}

class _DepartmentViewState extends State<DepartmentView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var dp = Provider.of<DepartmentProvider>(context, listen: false);
      var dpe = Provider.of<DepartmentEmployeeProvider>(context, listen: false);

      await dp.getDepartment();
      await dpe.getDepartmentEmployee();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            color: Colors.grey[400],
            child: const TabBar(
              indicatorColor: Colors.blue,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 4.0,
              tabs: [
                Tab(text: 'Deparment'),
                Tab(text: 'Employees Department'),
              ],
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [
                DepartmentPage(),
                DepartmentEmployeePage(),
              ],
            ),
          ),
        ],
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
    return Consumer<DepartmentProvider>(
      builder: ((context, provider, child) {
        return ListView.builder(
          itemCount: provider.departmentList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Text('ID: ${provider.departmentList[index].id}'),
                title: Text(provider.departmentList[index].departmentName),
                subtitle: Text(
                    'Department ID: ${provider.departmentList[index].departmentId}'),
                onTap: () {},
                visualDensity: VisualDensity.compact,
              ),
            );
          },
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
    return Consumer<DepartmentEmployeeProvider>(
      builder: ((context, provider, child) {
        return ListView.builder(
          itemCount: provider.departmentEmployeeList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading:
                    Text('ID: ${provider.departmentEmployeeList[index].id}'),
                title: Text(
                    provider.fullName(provider.departmentEmployeeList[index])),
                subtitle: Text(
                    'Department: ${provider.departmentEmployeeList[index].departmentName}'),
                onTap: () {},
                visualDensity: VisualDensity.compact,
              ),
            );
          },
        );
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
