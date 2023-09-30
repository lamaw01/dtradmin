import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/log_provider.dart';
import '../widget/delegate.dart';
import '../widget/row_widget.dart';

class LogView extends StatefulWidget {
  const LogView({super.key});

  @override
  State<LogView> createState() => _LogViewState();
}

class _LogViewState extends State<LogView>
    with AutomaticKeepAliveClientMixin<LogView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var a = Provider.of<LogProvider>(context, listen: false);

      await a.getLog();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final dateFormat = DateFormat().add_yMEd().add_Hms();

    return Consumer<LogProvider>(
      builder: (context, provider, child) {
        return RefreshIndicator(
          onRefresh: () async {
            await provider.getLog();
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RowWidget(s: 'ID', w: 100.0, c: Colors.red, f: 1),
                          RowWidget(
                              s: 'Employee ID', w: 100.0, c: Colors.red, f: 1),
                          RowWidget(
                              s: 'Log type', w: 100.0, c: Colors.red, f: 1),
                          RowWidget(
                              s: 'Device ID', w: 350.0, c: Colors.red, f: 3),
                          RowWidget(
                              s: 'Address', w: 220.0, c: Colors.red, f: 3),
                          RowWidget(
                              s: 'Timestamp', w: 180.0, c: Colors.red, f: 2),
                          RowWidget(s: 'Team', w: 180.0, c: Colors.red, f: 2),
                          RowWidget(s: 'App', w: 100.0, c: Colors.red, f: 1),
                          RowWidget(
                              s: 'Version', w: 100.0, c: Colors.red, f: 1),
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
                      child: Ink(
                        height: 50.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RowWidget(
                              s: provider.logList[index].id.toString(),
                              w: 100.0,
                              c: Colors.red,
                              f: 1,
                            ),
                            RowWidget(
                              s: provider.logList[index].employeeId,
                              w: 100.0,
                              c: Colors.blue,
                              f: 1,
                            ),
                            RowWidget(
                              s: provider.logList[index].logType,
                              w: 100.0,
                              c: Colors.green,
                              f: 1,
                            ),
                            RowWidget(
                              s: provider.logList[index].deviceId,
                              w: 350.0,
                              c: Colors.yellow,
                              f: 3,
                            ),
                            RowWidget(
                              s: provider.logList[index].address,
                              w: 220.0,
                              c: Colors.purple,
                              f: 3,
                            ),
                            RowWidget(
                              s: dateFormat
                                  .format(provider.logList[index].timeStamp),
                              w: 180.0,
                              c: Colors.pink,
                              f: 2,
                            ),
                            RowWidget(
                              s: provider.logList[index].team,
                              w: 180.0,
                              c: Colors.pink,
                              f: 2,
                            ),
                            RowWidget(
                              s: provider.logList[index].app,
                              w: 100.0,
                              c: Colors.teal,
                              f: 1,
                            ),
                            RowWidget(
                              s: provider.logList[index].version,
                              w: 100.0,
                              c: Colors.brown,
                              f: 1,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: provider.logList.length,
                ),
              ),
              if (provider.logList.isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 50.0,
                    width: 180.0,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green[300],
                      ),
                      onPressed: () async {
                        await provider.addLog(id: provider.logList.last.id);
                      },
                      child: const Text(
                        'Load more..',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
