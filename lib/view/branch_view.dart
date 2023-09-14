import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/branch_employee_provider.dart';
import '../provider/branch_provider.dart';
import '../widget/delegate.dart';
import '../widget/row_widget.dart';

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
    const idw = 100.0;
    const bIdw = 200.0;
    const bw = 350.0;

    return Consumer<BranchProvider>(
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
                    child: SizedBox(
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
                  );
                },
                childCount: provider.branchList.length,
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
    const idw = 100.0;
    const nw = 400.0;
    const bw = 200.0;

    return Consumer<BranchEmployeeProvider>(
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
                          s: 'Employee Name',
                          w: nw,
                          c: Colors.green,
                          f: 4,
                        ),
                        RowWidget(
                          s: 'Branch Name',
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
                    child: SizedBox(
                      height: 50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RowWidget(
                            s: provider.branchEmployeeList[index].id.toString(),
                            w: idw,
                            c: Colors.red,
                            f: 1,
                          ),
                          RowWidget(
                            s: provider
                                .fullName(provider.branchEmployeeList[index]),
                            w: nw,
                            c: Colors.green,
                            f: 4,
                          ),
                          RowWidget(
                            s: provider.branchEmployeeList[index].branchName,
                            w: bw,
                            c: Colors.blue,
                            f: 2,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: provider.branchEmployeeList.length,
              ),
            ),
          ],
        );
      }),
    );
    // return Consumer<BranchEmployeeProvider>(
    //   builder: ((context, provider, child) {
    //     return ListView.builder(
    //       itemCount: provider.branchEmployeeList.length,
    //       itemBuilder: (context, index) {
    //         return Card(
    //           child: ListTile(
    //             leading: Text('ID: ${provider.branchEmployeeList[index].id}'),
    //             title:
    //                 Text(provider.fullName(provider.branchEmployeeList[index])),
    //             subtitle: Text(
    //                 'Branch: ${provider.branchEmployeeList[index].branchName}'),
    //             onTap: () {},
    //             visualDensity: VisualDensity.compact,
    //           ),
    //         );
    //       },
    //     );
    //   }),
    // );
  }

  @override
  bool get wantKeepAlive => true;
}
