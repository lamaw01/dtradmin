import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/employee_provider.dart';
import '../widget/delegate.dart';
import '../widget/row_widget.dart';

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
      var dp = Provider.of<EmployeeProvider>(context, listen: false);

      await dp.getEmployee();
    });
  }

  @override
  Widget build(BuildContext context) {
    const idw = 100.0;
    const empIdw = 150.0;
    const dIdw = 300.0;
    const wsIdw = 200.0;

    return Consumer<EmployeeProvider>(
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
                  return Card(
                    child: SizedBox(
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
                            s: provider.fullName(provider.employeeList[index]),
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
                  );
                },
                childCount: provider.employeeList.length,
              ),
            ),
          ],
        );
      }),
    );
  }
}
