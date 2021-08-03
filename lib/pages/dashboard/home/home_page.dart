import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempapp/commons/constants/resource.dart';
import 'package:tempapp/pages/base_page.dart';
import 'package:tempapp/pages/dashboard/home/home_controller.dart';
import 'package:tempapp/pages/dashboard/home/widgets/battery_temp_widget.dart';
import 'package:tempapp/pages/dashboard/home/widgets/line_chart_widget.dart';
import 'package:tempapp/pages/dashboard/home/widgets/notify_widget.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(builder: (context, sizeInfo) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          elevation: 0.8,
          title: Text(Resource.appName,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Colors.blue, fontWeight: FontWeight.bold)),
          actions: [NotifyWidget(controller: controller, sizeInfo: sizeInfo)],
        ),
        body: Container(
            child: Column(
          children: [
            Container(
                color: Colors.white,
                child: BatteryTempWidget(
                    controller: controller, sizeInfo: sizeInfo)),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: TabBar(
                        labelColor: Colors.blue.shade700,
                        unselectedLabelColor: Colors.black,
                        indicator: BoxDecoration(
                          color: Colors.transparent,
                          border: Border(
                              bottom: BorderSide(color: Colors.blue, width: 3)),
                        ),
                        tabs: [
                          Tab(text: 'Biểu đồ nhiệt độ'),
                          Tab(text: 'Hướng dẫn'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: <Widget>[
                          Container(
                            color: Colors.white,
                            margin: EdgeInsets.only(top: 5.0),
                            child: Center(
                              child: LineChartWidget(
                                  controller: controller, sizeInfo: sizeInfo),
                            ),
                          ),
                          Container(
                              color: Colors.white,
                              child: Center(child: Text('Hướng dẫn'))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
      );
    });
  }
}
