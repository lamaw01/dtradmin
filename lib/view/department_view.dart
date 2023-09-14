import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/department_employee_provider.dart';
import '../provider/departmet_provider.dart';
import '../widget/delegate.dart';
import '../widget/row_widget.dart';

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
    const idw = 100.0;
    const dnw = 350.0;
    const dIdw = 200.0;

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
                    child: SizedBox(
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
