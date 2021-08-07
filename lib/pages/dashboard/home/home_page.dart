import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempapp/commons/constants/resource.dart';
import 'package:tempapp/pages/base_page.dart';
import 'package:tempapp/pages/dashboard/home/home_controller.dart';
import 'package:tempapp/pages/dashboard/home/widgets/battery_temp_widget.dart';
import 'package:tempapp/pages/dashboard/home/widgets/charts/chart_page.dart';
import 'package:tempapp/pages/dashboard/home/widgets/charts/line_chart_widget.dart';
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
                style:
                    Theme.of(context).textTheme.headline5!.copyWith(color: Colors.blue, fontWeight: FontWeight.bold)),
            actions: [NotifyWidget(controller: controller, sizeInfo: sizeInfo)],
          ),
          body: Container(
              child: Column(
            children: [
              Container(
                color: Colors.white,
                child: BatteryTempWidget(controller: controller, sizeInfo: sizeInfo),
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
                            border: Border(bottom: BorderSide(color: Colors.blue, width: 3)),
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
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '',
                                            softWrap: true,
                                            textScaleFactor: 1,
                                          ),
                                          IconButton(
                                            constraints: BoxConstraints(maxHeight: 30),
                                            icon: Image.asset('assets/images/fullscreen.png',
                                                fit: BoxFit.contain, color: Resource.backgroundColor),
                                            onPressed: () {
                                              Future.delayed(Duration(milliseconds: 100), () {
                                                //Get.to(() => ChartPage(controller: controller));

                                                /* Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      fullscreenDialog: true,
                                                      builder: (BuildContext context) =>
                                                          ChartPage(controller: controller)),
                                                );*/

                                                Navigator.of(context).push(
                                                  PageRouteBuilder(
                                                    fullscreenDialog: true,
                                                    transitionDuration: Duration(milliseconds: 1000),
                                                    pageBuilder: (BuildContext context, Animation<double> animation,
                                                        Animation<double> secondaryAnimation) {
                                                      return ChartPage(controller: controller);
                                                    },
                                                    transitionsBuilder: (BuildContext context,
                                                        Animation<double> animation,
                                                        Animation<double> secondaryAnimation,
                                                        Widget child) {
                                                      return Align(
                                                        child: FadeTransition(
                                                          opacity: animation,
                                                          child: child,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: LineChartWidget(
                                          controller: controller,
                                          sizeInfo: sizeInfo,
                                          limitY: true,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(color: Colors.white, child: Center(child: Text('Hướng dẫn'))),
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
