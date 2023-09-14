import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/schedule_provider.dart';
import '../provider/week_scheduke_provider.dart';
import '../widget/delegate.dart';
import '../widget/row_widget.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var ws = Provider.of<WeekScheduleProvider>(context, listen: false);
      var s = Provider.of<ScheduleProvider>(context, listen: false);

      await ws.getWeekSchedule();
      await s.getSchedule();
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
                Tab(text: 'Week Schedule'),
                Tab(text: 'Day Schedule'),
              ],
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [
                WeekSchedulePage(),
                SchedulePage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WeekSchedulePage extends StatefulWidget {
  const WeekSchedulePage({super.key});

  @override
  State<WeekSchedulePage> createState() => _WeekSchedulePageState();
}

class _WeekSchedulePageState extends State<WeekSchedulePage>
    with AutomaticKeepAliveClientMixin<WeekSchedulePage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    const idw = 100.0;
    const cw = 100.0;
    const descw = 250.0;

    return Consumer<WeekScheduleProvider>(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RowWidget(s: 'ID', w: idw, c: Colors.red, f: 1),
                        RowWidget(
                            s: 'Week Sched ID', w: cw, c: Colors.green, f: 1),
                        RowWidget(s: 'Monday', w: cw, c: Colors.blue, f: 1),
                        RowWidget(s: 'Tuesday', w: cw, c: Colors.blue, f: 1),
                        RowWidget(s: 'Wednesday', w: cw, c: Colors.blue, f: 1),
                        RowWidget(s: 'Thursday', w: cw, c: Colors.blue, f: 1),
                        RowWidget(s: 'Friday', w: cw, c: Colors.blue, f: 1),
                        RowWidget(s: 'Saturday', w: cw, c: Colors.blue, f: 1),
                        RowWidget(s: 'Sunday', w: cw, c: Colors.blue, f: 1),
                        RowWidget(
                            s: 'Description', w: descw, c: Colors.blue, f: 3),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RowWidget(
                              s: provider.weekScheduleProviderList[index].id
                                  .toString(),
                              w: idw,
                              c: Colors.red,
                              f: 1),
                          RowWidget(
                              s: provider
                                  .weekScheduleProviderList[index].weekSchedId,
                              w: cw,
                              c: Colors.green,
                              f: 1),
                          RowWidget(
                              s: provider
                                  .weekScheduleProviderList[index].monday,
                              w: cw,
                              c: Colors.blue,
                              f: 1),
                          RowWidget(
                              s: provider
                                  .weekScheduleProviderList[index].tuesday,
                              w: cw,
                              c: Colors.blue,
                              f: 1),
                          RowWidget(
                              s: provider
                                  .weekScheduleProviderList[index].wednesday,
                              w: cw,
                              c: Colors.blue,
                              f: 1),
                          RowWidget(
                              s: provider
                                  .weekScheduleProviderList[index].thursday,
                              w: cw,
                              c: Colors.blue,
                              f: 1),
                          RowWidget(
                              s: provider
                                  .weekScheduleProviderList[index].friday,
                              w: cw,
                              c: Colors.blue,
                              f: 1),
                          RowWidget(
                              s: provider
                                  .weekScheduleProviderList[index].saturday,
                              w: cw,
                              c: Colors.blue,
                              f: 1),
                          RowWidget(
                              s: provider
                                  .weekScheduleProviderList[index].sunday,
                              w: cw,
                              c: Colors.blue,
                              f: 1),
                          RowWidget(
                              s: provider
                                  .weekScheduleProviderList[index].description,
                              w: descw,
                              c: Colors.blue,
                              f: 3),
                        ],
                      ),
                    ),
                  );
                },
                childCount: provider.weekScheduleProviderList.length,
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

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage>
    with AutomaticKeepAliveClientMixin<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    const idw = 100.0;
    const cw = 100.0;
    const descw = 250.0;

    return Consumer<ScheduleProvider>(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RowWidget(s: 'ID', w: idw, c: Colors.red, f: 1),
                        RowWidget(s: 'Sched ID', w: cw, c: Colors.green, f: 1),
                        RowWidget(s: 'Sched type', w: cw, c: Colors.blue, f: 1),
                        RowWidget(s: 'In', w: cw, c: Colors.blue, f: 1),
                        RowWidget(s: 'Out Break', w: cw, c: Colors.blue, f: 1),
                        RowWidget(s: 'In Break', w: cw, c: Colors.blue, f: 1),
                        RowWidget(s: 'Out', w: cw, c: Colors.blue, f: 1),
                        RowWidget(
                            s: 'Description', w: descw, c: Colors.blue, f: 3),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RowWidget(
                              s: provider.scheduleProviderList[index].id
                                  .toString(),
                              w: idw,
                              c: Colors.red,
                              f: 1),
                          RowWidget(
                              s: provider.scheduleProviderList[index].schedId,
                              w: cw,
                              c: Colors.green,
                              f: 1),
                          RowWidget(
                              s: provider.scheduleProviderList[index].schedType,
                              w: cw,
                              c: Colors.blue,
                              f: 1),
                          RowWidget(
                              s: provider.scheduleProviderList[index].schedId,
                              w: cw,
                              c: Colors.blue,
                              f: 1),
                          RowWidget(
                              s: provider
                                  .scheduleProviderList[index].breakStart,
                              w: cw,
                              c: Colors.blue,
                              f: 1),
                          RowWidget(
                              s: provider.scheduleProviderList[index].breakEnd,
                              w: cw,
                              c: Colors.blue,
                              f: 1),
                          RowWidget(
                              s: provider.scheduleProviderList[index].schedOut,
                              w: cw,
                              c: Colors.blue,
                              f: 1),
                          RowWidget(
                              s: provider
                                  .scheduleProviderList[index].description,
                              w: descw,
                              c: Colors.blue,
                              f: 3),
                        ],
                      ),
                    ),
                  );
                },
                childCount: provider.scheduleProviderList.length,
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
