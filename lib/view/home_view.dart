import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:provider/provider.dart';

import '../provider/app_version_provider.dart';
import '../provider/branch_employee_provider.dart';
import '../provider/branch_provider.dart';
import '../provider/department_employee_provider.dart';
import '../provider/department_provider.dart';
import '../provider/device_log_provider.dart';
import '../provider/device_provider.dart';
import '../provider/employee_provider.dart';
import '../provider/log_provider.dart';
import '../provider/schedule_provider.dart';
import '../provider/week_scheduke_provider.dart';
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
        onTap: (index, _) async {
          sideMenu.changePage(index);
          await Provider.of<LogProvider>(context, listen: false).getLog();
        },
        icon: const Icon(Icons.timer),
      ),
      SideMenuItem(
        title: 'Device',
        onTap: (index, _) async {
          sideMenu.changePage(index);
          var dp = Provider.of<DeviceProvider>(context, listen: false);
          var dlp = Provider.of<DeviceLogProvider>(context, listen: false);

          await dp.getDevice();
          await dlp.getDeviceLog();
        },
        icon: const Icon(Icons.phone_android),
      ),
      SideMenuItem(
        title: 'Branch',
        onTap: (index, _) async {
          sideMenu.changePage(index);
          var b = Provider.of<BranchProvider>(context, listen: false);
          var be = Provider.of<BranchEmployeeProvider>(context, listen: false);

          await b.getBranch();
          await be.getEmployeeBranch();
        },
        icon: const Icon(Icons.home),
      ),
      SideMenuItem(
        title: 'Department',
        onTap: (index, _) async {
          sideMenu.changePage(index);
          var dp = Provider.of<DepartmentProvider>(context, listen: false);
          var dpe =
              Provider.of<DepartmentEmployeeProvider>(context, listen: false);

          await dp.getDepartment();
          await dpe.getDepartmentEmployee();
        },
        icon: const Icon(Icons.people),
      ),
      SideMenuItem(
        title: 'Employee',
        onTap: (index, _) async {
          sideMenu.changePage(index);
          var e = Provider.of<EmployeeProvider>(context, listen: false);

          await e.getEmployee();
        },
        icon: const Icon(Icons.person),
      ),
      SideMenuItem(
        title: 'Schedule',
        onTap: (index, _) async {
          sideMenu.changePage(index);
          var ws = Provider.of<WeekScheduleProvider>(context, listen: false);
          var s = Provider.of<ScheduleProvider>(context, listen: false);

          await ws.getWeekSchedule();
          await s.getSchedule();
        },
        icon: const Icon(Icons.calendar_month),
      ),
      SideMenuItem(
        title: 'App Version',
        onTap: (index, _) async {
          sideMenu.changePage(index);
          var a = Provider.of<AppVersionProvider>(context, listen: false);

          await a.getAppVersion();
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
              itemInnerSpacing: 16.0,
              iconSize: 16.0,
              itemOuterPadding: EdgeInsets.zero,
              openSideMenuWidth: 160.0,
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
