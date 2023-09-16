import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/app_version_provider.dart';
import '../widget/delegate.dart';
import '../widget/row_widget.dart';

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

    return Consumer<AppVersionProvider>(
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
                        RowWidget(s: 'App name', w: cw, c: Colors.green, f: 1),
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
                    child: SizedBox(
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
                              s: provider.appVersionProviderList[index].name,
                              w: cw,
                              c: Colors.green,
                              f: 1),
                          RowWidget(
                              s: provider.appVersionProviderList[index].version,
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
                  );
                },
                childCount: provider.appVersionProviderList.length,
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
