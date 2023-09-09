import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/device_log_provider.dart';
import '../provider/device_provider.dart';

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

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DeviceProvider>(
      builder: ((context, provider, child) {
        return ListView.builder(
          itemCount: provider.deviceList.length,
          itemBuilder: (context, index) {
            var isActive = provider.deviceList[index].active;
            return Card(
              child: ListTile(
                leading: Text('ID: ${provider.deviceList[index].id}'),
                title: Text(provider.deviceList[index].deviceId),
                subtitle: Text(
                    'Description: ${provider.deviceList[index].description}'),
                trailing: Text(provider.deviceList[index].branchName),
                tileColor: isActive == 1 ? null : Colors.red[400],
                onTap: () {},
                visualDensity: VisualDensity.compact,
              ),
            );
          },
        );
      }),
    );
  }
}

class DeviceLogsPage extends StatelessWidget {
  const DeviceLogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat().add_yMEd().add_Hms();

    return Consumer<DeviceLogProvider>(
      builder: ((context, provider, child) {
        return ListView.builder(
          itemCount: provider.deviceLogList.length,
          itemBuilder: (context, index) {
            return Card(
              child: SizedBox(
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DeviceLogWidget(
                      s: 'ID: ${provider.deviceLogList[index].id}',
                      w: 80.0,
                      c: Colors.red,
                    ),
                    DeviceLogWidget(
                      s: provider.deviceLogList[index].deviceId,
                      w: 300.0,
                      c: Colors.blue,
                    ),
                    DeviceLogWidget(
                      s: provider.deviceLogList[index].address,
                      w: 200.0,
                      c: Colors.green,
                    ),
                    DeviceLogWidget(
                      s: provider.deviceLogList[index].latlng,
                      w: 120.0,
                      c: Colors.yellow,
                    ),
                    DeviceLogWidget(
                      s: provider.deviceLogList[index].appName,
                      w: 100.0,
                      c: Colors.pink,
                    ),
                    DeviceLogWidget(
                      s: provider.deviceLogList[index].version,
                      w: 70.0,
                      c: Colors.purple,
                    ),
                    DeviceLogWidget(
                      s: dateFormat
                          .format(provider.deviceLogList[index].logTime),
                      w: 175.0,
                      c: Colors.orange,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class DeviceLogWidget extends StatelessWidget {
  const DeviceLogWidget({
    super.key,
    required this.s,
    required this.w,
    this.c,
  });
  final String s;
  final double w;
  final Color? c;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        color: null,
        width: w,
        child: Center(
          child: Text(
            s,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
