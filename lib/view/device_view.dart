import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/device_log_provider.dart';
import '../provider/device_provider.dart';
import '../widget/delegate.dart';
import '../widget/row_widget.dart';

class DeviceView extends StatefulWidget {
  const DeviceView({super.key});

  @override
  State<DeviceView> createState() => _DeviceViewState();
}

class _DeviceViewState extends State<DeviceView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var dp = Provider.of<DeviceProvider>(context, listen: false);
      var dlp = Provider.of<DeviceLogProvider>(context, listen: false);

      await dp.getDevice();
      await dlp.getDeviceLog();
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
                Tab(text: 'Device'),
                Tab(text: 'Device Logs'),
              ],
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [
                DevicesPage(),
                DeviceLogsPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage>
    with AutomaticKeepAliveClientMixin<DevicesPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    const idw = 100.0;
    const dIdw = 350.0;
    const bw = 200.0;
    const dw = 180.0;

    return Consumer<DeviceProvider>(
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
                        RowWidget(
                          s: 'ID',
                          w: idw,
                          c: Colors.red,
                          f: 1,
                        ),
                        RowWidget(
                          s: 'Device ID',
                          w: dIdw,
                          c: Colors.blue,
                          f: 3,
                        ),
                        RowWidget(
                          s: 'Branch Name',
                          w: bw,
                          c: Colors.green,
                          f: 2,
                        ),
                        RowWidget(
                          s: 'Description',
                          w: dw,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RowWidget(
                            s: provider.deviceList[index].id.toString(),
                            w: idw,
                            c: Colors.red,
                            f: 1,
                          ),
                          RowWidget(
                            s: provider.deviceList[index].deviceId,
                            w: dIdw,
                            c: Colors.blue,
                            f: 3,
                          ),
                          RowWidget(
                            s: provider.deviceList[index].branchName,
                            w: bw,
                            c: Colors.green,
                            f: 2,
                          ),
                          RowWidget(
                            s: provider.deviceList[index].description,
                            w: dw,
                            c: Colors.yellow,
                            f: 2,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: provider.deviceList.length,
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

class DeviceLogsPage extends StatefulWidget {
  const DeviceLogsPage({super.key});

  @override
  State<DeviceLogsPage> createState() => _DeviceLogsPageState();
}

class _DeviceLogsPageState extends State<DeviceLogsPage>
    with AutomaticKeepAliveClientMixin<DeviceLogsPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final dateFormat = DateFormat().add_yMEd().add_Hms();
    const idw = 100.0;
    const dIdw = 350.0;
    const addw = 220.0;
    const ltw = 180.0;
    const appnw = 100.0;
    const appvw = 120.0;
    const logtw = 180.0;

    return Consumer<DeviceLogProvider>(
      builder: ((context, provider, child) {
        return CustomScrollView(
          slivers: <Widget>[
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
                        RowWidget(
                          s: 'ID',
                          w: idw,
                          c: Colors.red,
                          f: 1,
                        ),
                        RowWidget(
                          s: 'Device ID',
                          w: dIdw,
                          c: Colors.blue,
                          f: 3,
                        ),
                        RowWidget(
                          s: 'Address',
                          w: addw,
                          c: Colors.green,
                          f: 3,
                        ),
                        RowWidget(
                          s: 'LatLng',
                          w: ltw,
                          c: Colors.yellow,
                          f: 2,
                        ),
                        RowWidget(
                          s: 'App name',
                          w: appnw,
                          c: Colors.pink,
                          f: 1,
                        ),
                        RowWidget(
                          s: 'App Version',
                          w: appvw,
                          c: Colors.purple,
                          f: 1,
                        ),
                        RowWidget(
                          s: 'Log Time',
                          w: logtw,
                          c: Colors.orange,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RowWidget(
                            s: 'ID: ${provider.deviceLogList[index].id}',
                            w: idw,
                            c: Colors.red,
                            f: 1,
                          ),
                          RowWidget(
                            s: provider.deviceLogList[index].deviceId,
                            w: dIdw,
                            c: Colors.blue,
                            f: 3,
                          ),
                          RowWidget(
                            s: provider.deviceLogList[index].address,
                            w: addw,
                            c: Colors.green,
                            f: 3,
                          ),
                          RowWidget(
                            s: provider.deviceLogList[index].latlng,
                            w: ltw,
                            c: Colors.yellow,
                            f: 2,
                          ),
                          RowWidget(
                            s: provider.deviceLogList[index].appName,
                            w: appnw,
                            c: Colors.pink,
                            f: 1,
                          ),
                          RowWidget(
                            s: provider.deviceLogList[index].version,
                            w: appvw,
                            c: Colors.purple,
                            f: 1,
                          ),
                          RowWidget(
                            s: dateFormat
                                .format(provider.deviceLogList[index].logTime),
                            w: logtw,
                            c: Colors.orange,
                            f: 2,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: provider.deviceLogList.length,
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
