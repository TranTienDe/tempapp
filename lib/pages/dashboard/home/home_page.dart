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
      return SafeArea(
        child: Scaffold(
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
                    controller: controller, sizeInfo: sizeInfo),
              ),
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
                                bottom:
                                    BorderSide(color: Colors.blue, width: 3)),
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
                              padding: EdgeInsets.all(5.0),
                              child: Card(
                                elevation: 2.0,
                                child: Column(
                                  children: [
                                    InkWell(
                                      splashColor: Colors.grey.withOpacity(0.4),
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 5, 10, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '',
                                              softWrap: true,
                                              textScaleFactor: 1,
                                            ),
                                            Container(
                                              height: 24,
                                              width: 24,
                                              color: Colors.transparent,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 0, 5, 5),
                                                child: Image.asset(
                                                    'assets/images/fullscreen.png',
                                                    fit: BoxFit.contain,
                                                    height: 20,
                                                    width: 20,
                                                    color: Resource
                                                        .backgroundColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        //color: Colors.yellow,
                                        child: LineChartWidget(
                                            controller: controller,
                                            sizeInfo: sizeInfo),
                                      ),
                                    ),
                                  ],
                                ),
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
        ),
      );
    });
  }
}
