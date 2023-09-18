import 'package:dtradmin/model/branch_model.dart';
import 'package:dtradmin/model/device_model.dart';
import 'package:dtradmin/provider/branch_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/device_log_provider.dart';
import '../provider/device_provider.dart';
import '../widget/delegate.dart';
import '../widget/row_widget.dart';
import '../widget/snackbar_widget.dart';

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
    void addDevice() async {
      var b = Provider.of<BranchProvider>(context, listen: false);
      var d = Provider.of<DeviceProvider>(context, listen: false);
      await b.getBranch();
      if (mounted) {
        await showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            var branchList = [
              BranchModel(id: 0, branchId: '000', branchName: '--Select--')
            ];
            branchList.addAll(b.branchList);
            final deviceId = TextEditingController();
            final description = TextEditingController();
            var dpValue = branchList.first;

            return AlertDialog(
              title: const Text('Add Device'),
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
                            controller: deviceId,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              label: Text('Device ID'),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Container(
                          height: 40.0,
                          width: 400.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 1.0,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<BranchModel>(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              borderRadius: BorderRadius.circular(5),
                              value: dpValue,
                              onChanged: (BranchModel? value) async {
                                if (value != null) {
                                  setState(() {
                                    dpValue = value;
                                  });
                                }
                              },
                              items: branchList
                                  .map<DropdownMenuItem<BranchModel>>(
                                      (BranchModel value) {
                                return DropdownMenuItem<BranchModel>(
                                  value: value,
                                  child: Text(value.branchName),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          height: 40.0,
                          width: 400.0,
                          child: TextField(
                            controller: description,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              label: Text('Description'),
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
                    if (dpValue.id == 0) {
                      snackBarError('Invalid Branch', context);
                    } else {
                      await d.addDevice(
                          branchId: dpValue.branchId,
                          deviceId: deviceId.text,
                          active: 1,
                          description: description.text);
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
    }

    return Scaffold(
      body: DefaultTabController(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          addDevice();
        },
        child: const Text('Add'),
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

    void updateDevice(DeviceModel deviceModel) async {
      var b = Provider.of<BranchProvider>(context, listen: false);
      var d = Provider.of<DeviceProvider>(context, listen: false);

      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final deviceId = TextEditingController(text: deviceModel.deviceId);
          final description =
              TextEditingController(text: deviceModel.description);
          var dpValue = b.branchList
              .singleWhere((e) => e.branchId == deviceModel.branchId);

          return AlertDialog(
            title: const Text('Update Device'),
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
                          controller: deviceId,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            label: Text('Device ID'),
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        height: 40.0,
                        width: 400.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<BranchModel>(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            borderRadius: BorderRadius.circular(5),
                            value: dpValue,
                            onChanged: (BranchModel? value) async {
                              if (value != null) {
                                setState(() {
                                  dpValue = value;
                                });
                              }
                            },
                            items: b.branchList
                                .map<DropdownMenuItem<BranchModel>>(
                                    (BranchModel value) {
                              return DropdownMenuItem<BranchModel>(
                                value: value,
                                child: Text(value.branchName),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      SizedBox(
                        height: 40.0,
                        width: 400.0,
                        child: TextField(
                          controller: description,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            label: Text('Description'),
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
                  if (dpValue.id == 0) {
                    snackBarError('Invalid Branch', context);
                  } else {
                    await d.updateDevice(
                      branchId: dpValue.branchId,
                      deviceId: deviceId.text,
                      active: 1,
                      description: description.text,
                      id: deviceModel.id,
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

    void confirmDeleteDevice(DeviceModel deviceModel) async {
      var d = Provider.of<DeviceProvider>(context, listen: false);
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Remove Device'),
            content: Text('Delete ${deviceModel.deviceId}?'),
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
                  await d.deleteDevice(id: deviceModel.id);
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

    return Consumer<DeviceProvider>(
      builder: ((context, provider, child) {
        var b = Provider.of<BranchProvider>(context, listen: false);
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
                    child: InkWell(
                      onTap: () async {
                        await b.getBranch();
                        updateDevice(provider.deviceList[index]);
                      },
                      onLongPress: () async {
                        confirmDeleteDevice(provider.deviceList[index]);
                      },
                      child: Ink(
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
    const appvw = 100.0;
    const logtw = 180.0;

    return Consumer<DeviceLogProvider>(
      builder: ((context, provider, child) {
        return RefreshIndicator(
          onRefresh: () async {
            provider.refreshDeviceLog();
          },
          child: CustomScrollView(
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
                              s: dateFormat.format(
                                  provider.deviceLogList[index].logTime),
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
          ),
        );
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
