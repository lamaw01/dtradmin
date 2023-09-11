import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/branch_employee_provider.dart';
import '../provider/branch_provider.dart';

class BranchView extends StatefulWidget {
  const BranchView({super.key});

  @override
  State<BranchView> createState() => _BranchViewState();
}

class _BranchViewState extends State<BranchView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var b = Provider.of<BranchProvider>(context, listen: false);
      var be = Provider.of<BranchEmployeeProvider>(context, listen: false);

      await b.getBranch();
      await be.getBranchEmployee();
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
                Tab(text: 'Branch'),
                Tab(text: 'Employees Branch'),
              ],
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [
                BranchPage(),
                BranchEmployeePage(),
              ],
            ),
          ),
        ],
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
    return Consumer<BranchProvider>(
      builder: ((context, provider, child) {
        return ListView.builder(
          itemCount: provider.branchList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Text('ID: ${provider.branchList[index].id}'),
                title: Text(provider.branchList[index].branchName),
                subtitle:
                    Text('Branch ID: ${provider.branchList[index].branchId}'),
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
    return Consumer<BranchEmployeeProvider>(
      builder: ((context, provider, child) {
        return ListView.builder(
          itemCount: provider.branchEmployeeList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Text('ID: ${provider.branchEmployeeList[index].id}'),
                title:
                    Text(provider.fullName(provider.branchEmployeeList[index])),
                subtitle: Text(
                    'Branch: ${provider.branchEmployeeList[index].branchName}'),
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
