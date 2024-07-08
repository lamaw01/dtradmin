import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:provider/provider.dart';

import '../provider/app_version_provider.dart';
import '../provider/branch_provider.dart';
import '../provider/company_provider.dart';
import '../provider/department_provider.dart';
import '../provider/device_log_provider.dart';
import '../provider/device_provider.dart';
import '../provider/employee_provider.dart';
import '../provider/log_provider.dart';
import '../provider/schedule_provider.dart';
import '../provider/week_scheduke_provider.dart';
import 'app_version_view.dart';
import 'branch_view.dart';
import 'company_view.dart';
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
  SideMenuController sideMenu = SideMenuController();
  int index = 0;
  String title = 'UC-1 DTR Admin';

  @override
  void initState() {
    super.initState();
    // Connect SideMenuController and PageController together
    // sideMenu.addListener((index) {
    //   pageController.jumpToPage(index);
    // });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<AppVersionProvider>(context, listen: false)
          .getPackageInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      SideMenuItem(
        title: 'Logs',
        onTap: (i, _) async {
          sideMenu.changePage(i);
          setState(() {
            index = i;
          });
          await Provider.of<LogProvider>(context, listen: false).getLog();
        },
        icon: const Icon(Icons.timer),
      ),
      SideMenuItem(
        title: 'Device',
        onTap: (i, _) async {
          sideMenu.changePage(i);
          setState(() {
            index = i;
          });
          var dp = Provider.of<DeviceProvider>(context, listen: false);
          var dlp = Provider.of<DeviceLogProvider>(context, listen: false);

          await dp.getDevice();
          await dlp.getDeviceLog();
        },
        icon: const Icon(Icons.phone_android),
      ),
      SideMenuItem(
        title: 'Branch',
        onTap: (i, _) async {
          sideMenu.changePage(i);
          setState(() {
            index = i;
          });
          var b = Provider.of<BranchProvider>(context, listen: false);

          await b.getBranch();
        },
        icon: const Icon(Icons.home),
      ),
      SideMenuItem(
        title: 'Department',
        onTap: (i, _) async {
          sideMenu.changePage(i);
          setState(() {
            index = i;
          });
          var dp = Provider.of<DepartmentProvider>(context, listen: false);

          await dp.getDepartment();
        },
        icon: const Icon(Icons.people),
      ),
      SideMenuItem(
        title: 'Company',
        onTap: (i, _) async {
          sideMenu.changePage(i);
          setState(() {
            index = i;
          });
          var b = Provider.of<CompanyProvider>(context, listen: false);

          await b.getCompany();
        },
        icon: const Icon(Icons.business_outlined),
      ),
      SideMenuItem(
        title: 'Employee',
        onTap: (i, _) async {
          sideMenu.changePage(i);
          setState(() {
            index = i;
          });
          var e = Provider.of<EmployeeProvider>(context, listen: false);

          await e.getEmployee();
        },
        icon: const Icon(Icons.person),
      ),
      SideMenuItem(
        title: 'Schedule',
        onTap: (i, _) async {
          sideMenu.changePage(i);
          setState(() {
            index = i;
          });
          var ws = Provider.of<WeekScheduleProvider>(context, listen: false);
          var s = Provider.of<ScheduleProvider>(context, listen: false);

          await ws.getWeekSchedule();
          await s.getSchedule();
        },
        icon: const Icon(Icons.calendar_month),
      ),
      SideMenuItem(
        title: 'App Version',
        onTap: (i, _) async {
          sideMenu.changePage(i);
          setState(() {
            index = i;
          });
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
      const CompanyView(),
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
                Text(title),
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
            // child: PageView(
            //   controller: pageController,
            //   children: menuPages,
            //   onPageChanged: (index) {
            //     sideMenu.changePage(index);
            //   },
            // ),
            child: menuPages.elementAt(index),
          ),
        ],
      ),
    );
  }
}
