import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:provider/provider.dart';

import '../provider/app_version_provider.dart';
import 'app_version_view.dart';
import 'branch_view.dart';
import 'department_view.dart';
import 'device_view.dart';
import 'employee_view.dart';
import 'log_view.dart';
import 'schedule_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    super.initState();
    // Connect SideMenuController and PageController together
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<AppVersionProvider>(context, listen: false)
          .getPackageInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    const String title = 'UC-1 DTR Admin';

    final menuItems = [
      SideMenuItem(
        title: 'Logs',
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: const Icon(Icons.timer),
      ),
      SideMenuItem(
        title: 'Device',
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: const Icon(Icons.phone_android),
      ),
      SideMenuItem(
        title: 'Branch',
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: const Icon(Icons.home),
      ),
      SideMenuItem(
        title: 'Department',
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: const Icon(Icons.people),
      ),
      SideMenuItem(
        title: 'Employee',
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: const Icon(Icons.person),
      ),
      SideMenuItem(
        title: 'Schedule',
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: const Icon(Icons.calendar_month),
      ),
      SideMenuItem(
        title: 'App Version',
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: const Icon(Icons.format_list_numbered),
      ),
    ];

    final menuPages = <Widget>[
      const LogView(),
      const DeviceView(),
      const BranchView(),
      const DepartmentView(),
      const EmployeeView(),
      const ScheduleView(),
      const AppVersionView(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Consumer<AppVersionProvider>(
          builder: (context, provider, child) {
            var version = 'v${provider.appVersion}';
            return Row(
              children: [
                const Text(title),
                const SizedBox(
                  width: 2.5,
                ),
                Text(
                  version,
                  style: const TextStyle(fontSize: 12.0),
                ),
              ],
            );
          },
        ),
      ),
      body: Row(
        children: [
          SideMenu(
            controller: sideMenu,
            onDisplayModeChanged: (mode) {},
            items: menuItems,
            style: SideMenuStyle(
              backgroundColor: Colors.grey[300],
              iconSize: 16.0,
              itemOuterPadding: EdgeInsets.zero,
            ),
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              children: menuPages,
              onPageChanged: (index) {
                sideMenu.changePage(index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
