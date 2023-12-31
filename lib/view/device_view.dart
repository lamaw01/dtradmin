import 'package:dtradmin/model/branch_model.dart';
import 'package:dtradmin/model/device_model.dart';
import 'package:dtradmin/provider/branch_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

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

class _DeviceViewState extends State<DeviceView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  ValueNotifier<bool> hideFloating = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var dp = Provider.of<DeviceProvider>(context, listen: false);
      var dlp = Provider.of<DeviceLogProvider>(context, listen: false);

      await dp.getDevice();
      await dlp.getDeviceLog();
      tabController.addListener(() {
        if (tabController.index == 1) {
          hideFloating.value = true;
        } else {
          hideFloating.value = false;
        }
      });
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Branch:'),
                            const SizedBox(width: 5.0),
                            Container(
                              height: 40.0,
                              width: 330.0,
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
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
                          ],
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
                    bool devicedExist = d.checkDeviceId(deviceId.text.trim());
                    if (dpValue.id == 0) {
                      snackBarError('Invalid Branch', context);
                    } else if (deviceId.text.isEmpty ||
                        description.text.isEmpty) {
                      snackBarError('Invalid Parameter', context);
                    } else if (devicedExist) {
                      snackBarError('Device Already Exist', context);
                    } else {
                      await d.addDevice(
                          branchId: dpValue.branchId,
                          deviceId: deviceId.text,
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
              child: TabBar(
                controller: tabController,
                indicatorColor: Colors.blue,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 4.0,
                tabs: const [
                  Tab(text: 'Device'),
                  Tab(text: 'Device Logs'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  DevicesPage(),
                  DeviceLogsPage(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: hideFloating,
        builder: (context, value, child) {
          if (!value) {
            return FloatingActionButton(
              onPressed: () async {
                if (tabController.index == 0) {
                  addDevice();
                }
              },
              child: const Text('Add'),
            );
          } else {
            return const SizedBox();
          }
        },
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
                  bool devicedExist = d.checkDeviceId(deviceId.text.trim());
                  if (dpValue.id == 0) {
                    snackBarError('Invalid Branch', context);
                  } else if (devicedExist &&
                      deviceModel.branchId != deviceId.text.trim()) {
                    snackBarError('Device Already Exist', context);
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
        return RefreshIndicator(
          onRefresh: () async {
            await provider.getDevice();
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
                          RowWidget(
                              s: 'ID', w: idw, c: Colors.red, f: 1, bold: true),
                          RowWidget(
                              s: 'Device ID',
                              w: dIdw,
                              c: Colors.blue,
                              f: 3,
                              bold: true),
                          RowWidget(
                              s: 'Branch Name',
                              w: bw,
                              c: Colors.green,
                              f: 2,
                              bold: true),
                          RowWidget(
                              s: 'Description',
                              w: dw,
                              c: Colors.yellow,
                              f: 2,
                              bold: true),
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
          ),
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
  Color? backgroundColor(String description) {
    switch (description) {
      case 'unathorized':
        return Colors.red[200];
      case 'unknown':
        return Colors.orange[200];
      default:
        return null;
    }
  }

  Future<void> showToast(
    BuildContext context, {
    required String message,
  }) async {
    showToastWidget(
      Container(
        height: 150.0,
        width: 300.0,
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.blue[300],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Device ID copied',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
          ],
        ),
      ),
      context: context,
      animation: StyledToastAnimation.none,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.center,
      animDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final dateFormat = DateFormat().add_yMEd().add_Hms();
    const idw = 100.0;
    const dIdw = 350.0;
    const addw = 220.0;
    const ltw = 180.0;
    const appnw = 120.0;
    const appvw = 120.0;
    const logtw = 180.0;

    return Consumer<DeviceLogProvider>(
      builder: ((context, provider, child) {
        return RefreshIndicator(
          onRefresh: () async {
            await provider.getDeviceLog();
          },
          child: CustomScrollView(
            slivers: <Widget>[
              if (MediaQuery.of(context).size.width > 600) ...[
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
                                bold: true),
                            RowWidget(
                                s: 'Device ID',
                                w: dIdw,
                                c: Colors.blue,
                                f: 3,
                                bold: true),
                            RowWidget(
                                s: 'Address',
                                w: addw,
                                c: Colors.green,
                                f: 3,
                                bold: true),
                            RowWidget(
                                s: 'LatLng',
                                w: ltw,
                                c: Colors.yellow,
                                f: 2,
                                bold: true),
                            RowWidget(
                                s: 'App name',
                                w: appnw,
                                c: Colors.pink,
                                f: 2,
                                bold: true),
                            RowWidget(
                                s: 'App Version',
                                w: appvw,
                                c: Colors.purple,
                                f: 2,
                                bold: true),
                            RowWidget(
                                s: 'Log Time',
                                w: logtw,
                                c: Colors.orange,
                                f: 2,
                                bold: true),
                            RowWidget(
                                s: 'Description',
                                w: logtw,
                                c: Colors.orange,
                                f: 3,
                                bold: true),
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
                            showToast(context,
                                message:
                                    provider.deviceLogList[index].deviceId);
                            await Clipboard.setData(ClipboardData(
                                text: provider.deviceLogList[index].deviceId));
                          },
                          child: Ink(
                            color: backgroundColor(
                                provider.deviceLogList[index].description),
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
                                // Flexible(
                                //   flex: 3,
                                //   fit: FlexFit.loose,
                                //   child: SizedBox(
                                //     height: 50.0,
                                //     width: dIdw,
                                //     child: Center(
                                //       child: SelectableText(
                                //         provider.deviceLogList[index].deviceId,
                                //         maxLines: 2,
                                //         textAlign: TextAlign.center,
                                //         style: const TextStyle(
                                //           overflow: TextOverflow.ellipsis,
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
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
                                  f: 2,
                                ),
                                RowWidget(
                                  s: provider.deviceLogList[index].version,
                                  w: appvw,
                                  c: Colors.purple,
                                  f: 2,
                                ),
                                RowWidget(
                                  s: dateFormat.format(
                                      provider.deviceLogList[index].logTime),
                                  w: logtw,
                                  c: Colors.orange,
                                  f: 2,
                                ),
                                RowWidget(
                                  s: provider.deviceLogList[index].description,
                                  w: logtw,
                                  c: Colors.orange,
                                  f: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: provider.deviceLogList.length,
                  ),
                ),
              ] else ...[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Card(
                        child: InkWell(
                          onTap: () async {
                            showToast(context,
                                message:
                                    provider.deviceLogList[index].deviceId);
                            await Clipboard.setData(ClipboardData(
                                text: provider.deviceLogList[index].deviceId));
                          },
                          child: Ink(
                            color: backgroundColor(
                                provider.deviceLogList[index].description),
                            height: 180.0,
                            width: 550.0,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'ID: ',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              '${provider.deviceLogList[index].id}',
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Device ID: ',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: provider
                                              .deviceLogList[index].deviceId,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Address: ',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: provider
                                              .deviceLogList[index].address,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Lat Long: ',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: provider
                                              .deviceLogList[index].latlng,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    maxLines: 1,
                                    text: TextSpan(
                                      text: 'App: ',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: provider
                                              .deviceLogList[index].appName,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      text: 'Version: ',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: provider
                                              .deviceLogList[index].version,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Timestamp: ',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: dateFormat.format(provider
                                              .deviceLogList[index].timeStamp),
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Description: ',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: provider
                                              .deviceLogList[index].description,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: provider.deviceLogList.length,
                  ),
                ),
              ]
            ],
          ),
        );
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
