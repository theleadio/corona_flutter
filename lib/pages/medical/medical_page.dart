import 'package:corona_flutter/core/hospital.dart';
import 'package:corona_flutter/core/travel_alert.dart';
import 'package:corona_flutter/pages/medical/hospital_page.dart';
import 'package:corona_flutter/pages/medical/sources_page.dart';
import 'package:corona_flutter/pages/medical/travel_alert_page.dart';
import 'package:corona_flutter/widgets/web_view_wrapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicalPage extends StatefulWidget {
  @override
  _MedicalPageState createState() => _MedicalPageState();
}

class _MedicalPageState extends State<MedicalPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  final List<EmbeddedWeb> _embededWebs = [
    EmbeddedWeb(
      title: 'What is COVID-19',
      url: 'https://www.cdc.gov/coronavirus/2019-ncov/about/index.html',
    ),
    EmbeddedWeb(
      title: 'Prevention',
      url:
          'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: _embededWebs.length + 3);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            child: SliverSafeArea(
              top: false,
              sliver: SliverAppBar(
                centerTitle: true,
                title: Text(
                  'Medical',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'AbrilFatface',
                    color: Colors.black.withOpacity(0.75),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                bottom: TabBar(
                  controller: _controller,
                  isScrollable: true,
                  indicatorWeight: 4.0,
                  labelColor: Colors.black.withOpacity(0.75),
                  labelStyle: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'HKGrotesk',
                    fontWeight: FontWeight.w700,
                  ),
                  tabs: [
                    Tab(text: 'Hospitals'),
                    Tab(text: 'Travel Alerts'),
                    ..._embededWebs
                        .map(
                          (web) => Tab(
                            text: web.title,
                          ),
                        )
                        .toList(),
                    Tab(text: 'Sources'),
                  ],
                ),
                elevation: 2.0,
                backgroundColor: Colors.grey[50],
                pinned: true,
                forceElevated: true,
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          Consumer<HospitalsService>(
            builder: (context, hospitalsService, _) => HospitalPage(
              hospitalsService: hospitalsService,
            ),
          ),
          Consumer<TravelAlertsService>(
            builder: (context, travelAlertsService, _) => TravelAlertPage(
              travelAlertsService: travelAlertsService,
            ),
          ),
          ..._embededWebs
              .map(
                (web) => WebViewWrapper(
                  key: Key(web.title),
                  initialUrl: web.url,
                ),
              )
              .toList(),
          SourcesPage(),
        ],
      ),
    );
  }
}
