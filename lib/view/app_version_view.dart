import 'package:dtradmin/model/app_version_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/app_version_provider.dart';
import '../widget/delegate.dart';
import '../widget/row_widget.dart';
import '../widget/snackbar_widget.dart';

class AppVersionView extends StatefulWidget {
  const AppVersionView({super.key});

  @override
  State<AppVersionView> createState() => _AppVersionViewState();
}

class _AppVersionViewState extends State<AppVersionView>
    with AutomaticKeepAliveClientMixin<AppVersionView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var a = Provider.of<AppVersionProvider>(context, listen: false);

      await a.getAppVersion();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final dateFormat = DateFormat().add_yMEd().add_Hms();
    const idw = 100.0;
    const cw = 100.0;
    const updtw = 200.0;

    void updateEmployee(AppVersionModel appVersionModel) async {
      var avp = Provider.of<AppVersionProvider>(context, listen: false);

      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final appName = TextEditingController(text: appVersionModel.name);
          final appVersion =
              TextEditingController(text: appVersionModel.version);

          return AlertDialog(
            title: const Text('Update App Version'),
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
                          controller: appName,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            label: Text('App Name'),
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      SizedBox(
                        height: 40.0,
                        width: 400.0,
                        child: TextField(
                          controller: appVersion,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            label: Text('App Version'),
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
                  if (appName.text.isEmpty || appVersion.text.isEmpty) {
                    snackBarError('Invalid Parameterss', context);
                  } else {
                    avp.updateAppVersion(
                      name: appName.text.trim(),
                      version: appVersion.text.trim(),
                      id: appVersionModel.id,
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

    return Consumer<AppVersionProvider>(
      builder: ((context, provider, child) {
        return RefreshIndicator(
          onRefresh: () async {
            await provider.getAppVersion();
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
                          RowWidget(s: 'ID', w: idw, c: Colors.red, f: 1),
                          RowWidget(
                              s: 'App name', w: cw, c: Colors.green, f: 1),
                          RowWidget(s: 'Version', w: cw, c: Colors.blue, f: 1),
                          RowWidget(
                              s: 'Last Update', w: updtw, c: Colors.blue, f: 2),
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
                        onTap: () {
                          updateEmployee(
                              provider.appVersionProviderList[index]);
                        },
                        child: Ink(
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RowWidget(
                                  s: provider.appVersionProviderList[index].id
                                      .toString(),
                                  w: idw,
                                  c: Colors.red,
                                  f: 1),
                              RowWidget(
                                  s: provider
                                      .appVersionProviderList[index].name,
                                  w: cw,
                                  c: Colors.green,
                                  f: 1),
                              RowWidget(
                                  s: provider
                                      .appVersionProviderList[index].version,
                                  w: cw,
                                  c: Colors.blue,
                                  f: 1),
                              RowWidget(
                                  s: dateFormat.format(provider
                                      .appVersionProviderList[index].updated),
                                  w: updtw,
                                  c: Colors.yellow,
                                  f: 2),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: provider.appVersionProviderList.length,
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
