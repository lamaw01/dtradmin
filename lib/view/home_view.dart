import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';

import 'branch_view.dart';
import 'department_view.dart';
import 'device_view.dart';

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
    // Connect SideMenuController and PageController together
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const String title = 'UC-1 DTR Admin';

    final menuItems = [
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
    ];

    final menuPages = <Widget>[
      const DeviceView(),
      const BranchView(),
      const DepartmentView(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
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
