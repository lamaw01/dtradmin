import 'package:dtradmin/model/schedule_model.dart';
import 'package:dtradmin/model/week_schedule_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/schedule_provider.dart';
import '../provider/week_scheduke_provider.dart';
import '../widget/delegate.dart';
import '../widget/row_widget.dart';
import '../widget/snackbar_widget.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var ws = Provider.of<WeekScheduleProvider>(context, listen: false);
      var s = Provider.of<ScheduleProvider>(context, listen: false);

      await ws.getWeekSchedule();
      await s.getSchedule();
    });
  }

  @override
  Widget build(BuildContext context) {
    void addWeeklySchedule() async {
      var ws = Provider.of<WeekScheduleProvider>(context, listen: false);
      var s = Provider.of<ScheduleProvider>(context, listen: false);
      if (mounted) {
        await showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            var scheduleList = <ScheduleModel>[];
            scheduleList.add(ScheduleModel(
              id: 0,
              schedId: '--Select--',
              schedType: '',
              schedIn: '',
              breakStart: '',
              breakEnd: '',
              schedOut: '',
              description: '',
            ));
            scheduleList.addAll(s.scheduleProviderList);
            var ddMonday = scheduleList.first;
            var ddTuesday = scheduleList.first;
            var ddWednesday = scheduleList.first;
            var ddThursday = scheduleList.first;
            var ddFriday = scheduleList.first;
            var ddSaturday = scheduleList.first;
            var ddSunday = scheduleList.first;
            final weekSchedId = TextEditingController();
            final description = TextEditingController();

            return AlertDialog(
              title: const Text('Add Week Schedule'),
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
                            controller: weekSchedId,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              label: Text('Week Sched ID'),
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
                            child: DropdownButton<ScheduleModel>(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              borderRadius: BorderRadius.circular(5),
                              value: ddMonday,
                              onChanged: (ScheduleModel? value) async {
                                if (value != null) {
                                  setState(() {
                                    ddMonday = value;
                                  });
                                }
                              },
                              items: scheduleList
                                  .map<DropdownMenuItem<ScheduleModel>>(
                                      (ScheduleModel value) {
                                return DropdownMenuItem<ScheduleModel>(
                                  value: value,
                                  child: Text(
                                      "${value.schedId} | ${value.description}"),
                                );
                              }).toList(),
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
                            child: DropdownButton<ScheduleModel>(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              borderRadius: BorderRadius.circular(5),
                              value: ddTuesday,
                              onChanged: (ScheduleModel? value) async {
                                if (value != null) {
                                  setState(() {
                                    ddTuesday = value;
                                  });
                                }
                              },
                              items: scheduleList
                                  .map<DropdownMenuItem<ScheduleModel>>(
                                      (ScheduleModel value) {
                                return DropdownMenuItem<ScheduleModel>(
                                  value: value,
                                  child: Text(
                                    "${value.schedId} | ${value.description}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList(),
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
                            child: DropdownButton<ScheduleModel>(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              borderRadius: BorderRadius.circular(5),
                              value: ddWednesday,
                              onChanged: (ScheduleModel? value) async {
                                if (value != null) {
                                  setState(() {
                                    ddWednesday = value;
                                  });
                                }
                              },
                              items: scheduleList
                                  .map<DropdownMenuItem<ScheduleModel>>(
                                      (ScheduleModel value) {
                                return DropdownMenuItem<ScheduleModel>(
                                  value: value,
                                  child: Text(
                                    "${value.schedId} | ${value.description}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList(),
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
                            child: DropdownButton<ScheduleModel>(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              borderRadius: BorderRadius.circular(5),
                              value: ddThursday,
                              onChanged: (ScheduleModel? value) async {
                                if (value != null) {
                                  setState(() {
                                    ddThursday = value;
                                  });
                                }
                              },
                              items: scheduleList
                                  .map<DropdownMenuItem<ScheduleModel>>(
                                      (ScheduleModel value) {
                                return DropdownMenuItem<ScheduleModel>(
                                  value: value,
                                  child: Text(
                                    "${value.schedId} | ${value.description}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList(),
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
                            child: DropdownButton<ScheduleModel>(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              borderRadius: BorderRadius.circular(5),
                              value: ddFriday,
                              onChanged: (ScheduleModel? value) async {
                                if (value != null) {
                                  setState(() {
                                    ddFriday = value;
                                  });
                                }
                              },
                              items: scheduleList
                                  .map<DropdownMenuItem<ScheduleModel>>(
                                      (ScheduleModel value) {
                                return DropdownMenuItem<ScheduleModel>(
                                  value: value,
                                  child: Text(
                                    "${value.schedId} | ${value.description}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList(),
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
                            child: DropdownButton<ScheduleModel>(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              borderRadius: BorderRadius.circular(5),
                              value: ddSaturday,
                              onChanged: (ScheduleModel? value) async {
                                if (value != null) {
                                  setState(() {
                                    ddSaturday = value;
                                  });
                                }
                              },
                              items: scheduleList
                                  .map<DropdownMenuItem<ScheduleModel>>(
                                      (ScheduleModel value) {
                                return DropdownMenuItem<ScheduleModel>(
                                  value: value,
                                  child: Text(
                                    "${value.schedId} | ${value.description}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList(),
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
                            child: DropdownButton<ScheduleModel>(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              borderRadius: BorderRadius.circular(5),
                              value: ddSunday,
                              onChanged: (ScheduleModel? value) async {
                                if (value != null) {
                                  setState(() {
                                    ddSunday = value;
                                  });
                                }
                              },
                              items: scheduleList
                                  .map<DropdownMenuItem<ScheduleModel>>(
                                      (ScheduleModel value) {
                                return DropdownMenuItem<ScheduleModel>(
                                  value: value,
                                  child: Text(
                                    "${value.schedId} | ${value.description}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
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
                        const SizedBox(height: 10.0),
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
                    bool employeebranchExist =
                        ws.checkWeekSchedId(weekSchedId.text.trim());
                    if (ddMonday.id == 0 ||
                        ddTuesday.id == 0 ||
                        ddWednesday.id == 0 ||
                        ddThursday.id == 0 ||
                        ddFriday.id == 0 ||
                        ddSaturday.id == 0 ||
                        ddSunday.id == 0 ||
                        weekSchedId.text.isEmpty ||
                        description.text.isEmpty) {
                      snackBarError('Invalid Parameters', context);
                    } else if (employeebranchExist) {
                      snackBarError('Week Schedule Already Exist', context);
                    } else {
                      await ws.addWeekSchedule(
                        weekSchedId: weekSchedId.text.trim(),
                        monday: ddMonday.schedId,
                        tuesday: ddTuesday.schedId,
                        wednesday: ddWednesday.schedId,
                        thursday: ddThursday.schedId,
                        friday: ddFriday.schedId,
                        saturday: ddSaturday.schedId,
                        sunday: ddSunday.schedId,
                        description: description.text.trim(),
                      );
                    }
                    if (mounted) {
                      //60.121
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
                  Tab(text: 'Week Schedule'),
                  Tab(text: 'Day Schedule'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  WeekSchedulePage(),
                  SchedulePage(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (tabController.index == 0) {
            addWeeklySchedule();
          } else {
            // addEmployeeBranch();
          }
        },
        child: const Text('Add'),
      ),
    );
  }
}

class WeekSchedulePage extends StatefulWidget {
  const WeekSchedulePage({super.key});

  @override
  State<WeekSchedulePage> createState() => _WeekSchedulePageState();
}

class _WeekSchedulePageState extends State<WeekSchedulePage>
    with AutomaticKeepAliveClientMixin<WeekSchedulePage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    const idw = 100.0;
    const cw = 100.0;
    const descw = 250.0;

    void updateWeeklySchedule(WeekScheduleModel weekScheduleModel) async {
      var ws = Provider.of<WeekScheduleProvider>(context, listen: false);
      var s = Provider.of<ScheduleProvider>(context, listen: false);
      if (mounted) {
        await showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            var scheduleList = <ScheduleModel>[];
            scheduleList.addAll(s.scheduleProviderList);
            var ddMonday = scheduleList
                .singleWhere((e) => e.schedId == weekScheduleModel.monday);
            var ddTuesday = scheduleList
                .singleWhere((e) => e.schedId == weekScheduleModel.tuesday);
            var ddWednesday = scheduleList
                .singleWhere((e) => e.schedId == weekScheduleModel.wednesday);
            var ddThursday = scheduleList
                .singleWhere((e) => e.schedId == weekScheduleModel.thursday);
            var ddFriday = scheduleList
                .singleWhere((e) => e.schedId == weekScheduleModel.friday);
            var ddSaturday = scheduleList
                .singleWhere((e) => e.schedId == weekScheduleModel.saturday);
            var ddSunday = scheduleList
                .singleWhere((e) => e.schedId == weekScheduleModel.sunday);
            final weekSchedId =
                TextEditingController(text: weekScheduleModel.weekSchedId);
            final description =
                TextEditingController(text: weekScheduleModel.description);

            return AlertDialog(
              title: const Text('Add Week Schedule'),
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
                            controller: weekSchedId,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              label: Text('Week Sched ID'),
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
                            child: DropdownButton<ScheduleModel>(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              borderRadius: BorderRadius.circular(5),
                              value: ddMonday,
                              onChanged: (ScheduleModel? value) async {
                                if (value != null) {
                                  setState(() {
                                    ddMonday = value;
                                  });
                                }
                              },
                              items: scheduleList
                                  .map<DropdownMenuItem<ScheduleModel>>(
                                      (ScheduleModel value) {
                                return DropdownMenuItem<ScheduleModel>(
                                  value: value,
                                  child: Text(
                                      "${value.schedId} | ${value.description}"),
                                );
                              }).toList(),
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
                            child: DropdownButton<ScheduleModel>(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              borderRadius: BorderRadius.circular(5),
                              value: ddTuesday,
                              onChanged: (ScheduleModel? value) async {
                                if (value != null) {
                                  setState(() {
                                    ddTuesday = value;
                                  });
                                }
                              },
                              items: scheduleList
                                  .map<DropdownMenuItem<ScheduleModel>>(
                                      (ScheduleModel value) {
                                return DropdownMenuItem<ScheduleModel>(
                                  value: value,
                                  child: Text(
                                    "${value.schedId} | ${value.description}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList(),
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
                            child: DropdownButton<ScheduleModel>(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              borderRadius: BorderRadius.circular(5),
                              value: ddWednesday,
                              onChanged: (ScheduleModel? value) async {
                                if (value != null) {
                                  setState(() {
                                    ddWednesday = value;
                                  });
                                }
                              },
                              items: scheduleList
                                  .map<DropdownMenuItem<ScheduleModel>>(
                                      (ScheduleModel value) {
                                return DropdownMenuItem<ScheduleModel>(
                                  value: value,
                                  child: Text(
                                    "${value.schedId} | ${value.description}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList(),
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
                            child: DropdownButton<ScheduleModel>(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              borderRadius: BorderRadius.circular(5),
                              value: ddThursday,
                              onChanged: (ScheduleModel? value) async {
                                if (value != null) {
                                  setState(() {
                                    ddThursday = value;
                                  });
                                }
                              },
                              items: scheduleList
                                  .map<DropdownMenuItem<ScheduleModel>>(
                                      (ScheduleModel value) {
                                return DropdownMenuItem<ScheduleModel>(
                                  value: value,
                                  child: Text(
                                    "${value.schedId} | ${value.description}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList(),
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
                            child: DropdownButton<ScheduleModel>(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              borderRadius: BorderRadius.circular(5),
                              value: ddFriday,
                              onChanged: (ScheduleModel? value) async {
                                if (value != null) {
                                  setState(() {
                                    ddFriday = value;
                                  });
                                }
                              },
                              items: scheduleList
                                  .map<DropdownMenuItem<ScheduleModel>>(
                                      (ScheduleModel value) {
                                return DropdownMenuItem<ScheduleModel>(
                                  value: value,
                                  child: Text(
                                    "${value.schedId} | ${value.description}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList(),
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
                            child: DropdownButton<ScheduleModel>(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              borderRadius: BorderRadius.circular(5),
                              value: ddSaturday,
                              onChanged: (ScheduleModel? value) async {
                                if (value != null) {
                                  setState(() {
                                    ddSaturday = value;
                                  });
                                }
                              },
                              items: scheduleList
                                  .map<DropdownMenuItem<ScheduleModel>>(
                                      (ScheduleModel value) {
                                return DropdownMenuItem<ScheduleModel>(
                                  value: value,
                                  child: Text(
                                    "${value.schedId} | ${value.description}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList(),
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
                            child: DropdownButton<ScheduleModel>(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              borderRadius: BorderRadius.circular(5),
                              value: ddSunday,
                              onChanged: (ScheduleModel? value) async {
                                if (value != null) {
                                  setState(() {
                                    ddSunday = value;
                                  });
                                }
                              },
                              items: scheduleList
                                  .map<DropdownMenuItem<ScheduleModel>>(
                                      (ScheduleModel value) {
                                return DropdownMenuItem<ScheduleModel>(
                                  value: value,
                                  child: Text(
                                    "${value.schedId} | ${value.description}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
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
                        const SizedBox(height: 10.0),
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
                    bool weekSchedIdExist =
                        ws.checkWeekSchedId(weekSchedId.text.trim());
                    if (ddMonday.id == 0 ||
                        ddTuesday.id == 0 ||
                        ddWednesday.id == 0 ||
                        ddThursday.id == 0 ||
                        ddFriday.id == 0 ||
                        ddSaturday.id == 0 ||
                        ddSunday.id == 0 ||
                        weekSchedId.text.isEmpty ||
                        description.text.isEmpty) {
                      snackBarError('Invalid Parameters', context);
                    } else if (weekSchedIdExist &&
                        weekSchedId.text.trim() !=
                            weekScheduleModel.weekSchedId) {
                      snackBarError('Week Schedule Already Exist', context);
                    } else {
                      await ws.updateWeekSchedule(
                        weekSchedId: weekSchedId.text.trim(),
                        monday: ddMonday.schedId,
                        tuesday: ddTuesday.schedId,
                        wednesday: ddWednesday.schedId,
                        thursday: ddThursday.schedId,
                        friday: ddFriday.schedId,
                        saturday: ddSaturday.schedId,
                        sunday: ddSunday.schedId,
                        description: description.text.trim(),
                        id: weekScheduleModel.id,
                      );
                    }
                    if (mounted) {
                      //60.121
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

    void confirmDeleteWeekSchedule(WeekScheduleModel weekScheduleModel) async {
      var wsp = Provider.of<WeekScheduleProvider>(context, listen: false);
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Remove Week Schedule'),
            content: Text('Delete ${weekScheduleModel.weekSchedId}?'),
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
                  await wsp.deleteWeekSchedule(id: weekScheduleModel.id);
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

    return Consumer<WeekScheduleProvider>(
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
                        RowWidget(
                            s: 'Week Sched ID', w: cw, c: Colors.green, f: 1),
                        RowWidget(s: 'Monday', w: cw, c: Colors.blue, f: 1),
                        RowWidget(s: 'Tuesday', w: cw, c: Colors.blue, f: 1),
                        RowWidget(s: 'Wednesday', w: cw, c: Colors.blue, f: 1),
                        RowWidget(s: 'Thursday', w: cw, c: Colors.blue, f: 1),
                        RowWidget(s: 'Friday', w: cw, c: Colors.blue, f: 1),
                        RowWidget(s: 'Saturday', w: cw, c: Colors.blue, f: 1),
                        RowWidget(s: 'Sunday', w: cw, c: Colors.blue, f: 1),
                        RowWidget(
                            s: 'Description', w: descw, c: Colors.blue, f: 3),
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
                        updateWeeklySchedule(
                            provider.weekScheduleProviderList[index]);
                      },
                      onLongPress: () {
                        confirmDeleteWeekSchedule(
                            provider.weekScheduleProviderList[index]);
                      },
                      child: Ink(
                        height: 50.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RowWidget(
                                s: provider.weekScheduleProviderList[index].id
                                    .toString(),
                                w: idw,
                                c: Colors.red,
                                f: 1),
                            RowWidget(
                                s: provider.weekScheduleProviderList[index]
                                    .weekSchedId,
                                w: cw,
                                c: Colors.green,
                                f: 1),
                            RowWidget(
                                s: provider
                                    .weekScheduleProviderList[index].monday,
                                w: cw,
                                c: Colors.blue,
                                f: 1),
                            RowWidget(
                                s: provider
                                    .weekScheduleProviderList[index].tuesday,
                                w: cw,
                                c: Colors.blue,
                                f: 1),
                            RowWidget(
                                s: provider
                                    .weekScheduleProviderList[index].wednesday,
                                w: cw,
                                c: Colors.blue,
                                f: 1),
                            RowWidget(
                                s: provider
                                    .weekScheduleProviderList[index].thursday,
                                w: cw,
                                c: Colors.blue,
                                f: 1),
                            RowWidget(
                                s: provider
                                    .weekScheduleProviderList[index].friday,
                                w: cw,
                                c: Colors.blue,
                                f: 1),
                            RowWidget(
                                s: provider
                                    .weekScheduleProviderList[index].saturday,
                                w: cw,
                                c: Colors.blue,
                                f: 1),
                            RowWidget(
                                s: provider
                                    .weekScheduleProviderList[index].sunday,
                                w: cw,
                                c: Colors.blue,
                                f: 1),
                            RowWidget(
                                s: provider.weekScheduleProviderList[index]
                                    .description,
                                w: descw,
                                c: Colors.blue,
                                f: 3),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: provider.weekScheduleProviderList.length,
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

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage>
    with AutomaticKeepAliveClientMixin<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    const idw = 100.0;
    const cw = 100.0;
    const descw = 250.0;

    return Consumer<ScheduleProvider>(
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
                        RowWidget(s: 'Sched ID', w: cw, c: Colors.green, f: 1),
                        RowWidget(s: 'Sched type', w: cw, c: Colors.blue, f: 1),
                        RowWidget(s: 'In', w: cw, c: Colors.blue, f: 1),
                        RowWidget(s: 'Out Break', w: cw, c: Colors.blue, f: 1),
                        RowWidget(s: 'In Break', w: cw, c: Colors.blue, f: 1),
                        RowWidget(s: 'Out', w: cw, c: Colors.blue, f: 1),
                        RowWidget(
                            s: 'Description', w: descw, c: Colors.blue, f: 3),
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
                              s: provider.scheduleProviderList[index].id
                                  .toString(),
                              w: idw,
                              c: Colors.red,
                              f: 1),
                          RowWidget(
                              s: provider.scheduleProviderList[index].schedId,
                              w: cw,
                              c: Colors.green,
                              f: 1),
                          RowWidget(
                              s: provider.scheduleProviderList[index].schedType,
                              w: cw,
                              c: Colors.blue,
                              f: 1),
                          RowWidget(
                              s: provider.scheduleProviderList[index].schedId,
                              w: cw,
                              c: Colors.blue,
                              f: 1),
                          RowWidget(
                              s: provider
                                  .scheduleProviderList[index].breakStart,
                              w: cw,
                              c: Colors.blue,
                              f: 1),
                          RowWidget(
                              s: provider.scheduleProviderList[index].breakEnd,
                              w: cw,
                              c: Colors.blue,
                              f: 1),
                          RowWidget(
                              s: provider.scheduleProviderList[index].schedOut,
                              w: cw,
                              c: Colors.blue,
                              f: 1),
                          RowWidget(
                              s: provider
                                  .scheduleProviderList[index].description,
                              w: descw,
                              c: Colors.blue,
                              f: 3),
                        ],
                      ),
                    ),
                  );
                },
                childCount: provider.scheduleProviderList.length,
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
