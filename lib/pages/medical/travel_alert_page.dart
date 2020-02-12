import 'package:corona_flutter/core/travel_alert.dart';
import 'package:corona_flutter/model/model.dart';
import 'package:corona_flutter/utils/helper.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TravelAlertPage extends StatefulWidget {
  final TravelAlertsService travelAlertsService;

  const TravelAlertPage({
    Key key,
    this.travelAlertsService,
  }) : super(key: key);

  @override
  _TravelAlertPageState createState() => _TravelAlertPageState();
}

class _TravelAlertPageState extends State<TravelAlertPage>
    with AutomaticKeepAliveClientMixin {
  ScrollController travelAlertsController;
  List<TravelAlert> travelAlerts = [];

  @override
  void initState() {
    super.initState();

    travelAlertsController = ScrollController();

    widget.travelAlertsService.addListener(() {
      setState(() {});
    });

    widget.travelAlertsService.refreshTravelLists();
  }

  @override
  void dispose() {
    travelAlertsController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> handleRefresh() async {
    setState(() {
      widget.travelAlertsService.refreshTravelLists();
    });
    return;
  }

  List<Widget> _buildTravelAlertSnippets() {
    if (widget.travelAlertsService.localTravelAlert.length == 0)
      return [
        Center(
          child: Text('No result'),
        ),
      ];

    return widget.travelAlertsService.localTravelAlert
        .map(
          (travelAlert) => TravelAlertSnippet(
            countryCode: travelAlert.countryCode,
            publishedDate: travelAlert.publishedDate,
            alertMessage: travelAlert.alertMessage,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: handleRefresh,
      child: DraggableScrollbar.rrect(
        backgroundColor: Colors.teal,
        heightScrollThumb: 64.0,
        controller: travelAlertsController,
        child: ListView(
          key: PageStorageKey('travelAlerts'),
          controller: travelAlertsController,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                top: 16.0,
              ),
              child: Text(
                'Travel Alerts',
                style: TextStyle(
                  fontSize: 45.0,
                  fontFamily: 'AbrilFatface',
                  fontWeight: FontWeight.w700,
                  color: Colors.black.withOpacity(0.75),
                ),
              ),
            ),
            ButtonTheme(
              alignedDropdown: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: DropdownButton(
                  isExpanded: true,
                  items: widget.travelAlertsService
                      .getCountriesCodesAvailable()
                      .map(
                        (countryCode) => DropdownMenuItem(
                          child: Text(
                            Helper.getCountryName(countryCode),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: countryCode,
                        ),
                      )
                      .toList(),
                  value: widget.travelAlertsService.countryCode,
                  onChanged: (value) {
                    print(value);
                    widget.travelAlertsService.countryCode = value;
                  },
                  elevation: 4,
                  style: TextStyle(
                    fontFamily: 'HKGrotesk',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black.withOpacity(0.75),
                  ),
                  underline: Container(
                    height: 2,
                    color: Colors.teal,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.0),
            ..._buildTravelAlertSnippets(),
            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                top: 16.0,
              ),
              child: Text(
                'Sources: IATA',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black.withOpacity(0.75),
                ),
              ),
            ),
            SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}

class TravelAlertSnippet extends StatelessWidget {
  final String countryCode;
  final String publishedDate;
  final String alertMessage;

  const TravelAlertSnippet({
    Key key,
    this.countryCode,
    this.publishedDate,
    this.alertMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            top: 16.0,
            bottom: 24.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                      icon: Helper.getFlagIcon(
                        countryCode: countryCode ?? 'GLOBAL',
                        width: 24.0,
                        height: null,
                        color: Colors.black.withOpacity(0.75),
                      ),
                      onPressed: null,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      Helper.getCountryName(countryCode),
                      style: TextStyle(
                        fontSize: 28.0,
                        fontFamily: 'AbrilFatface',
                        fontWeight: FontWeight.w700,
                        color: Colors.black.withOpacity(0.75),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ClipboardText(
                  title: 'Updated on:',
                  desc: ' ${Helper.formatShortDate(publishedDate)}',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              ClipboardText(
                title: 'Alert Message:',
                desc: ' \n${alertMessage.replaceAll('|', '\n')}',
              ),
            ],
          ),
        ),
        SizedBox(
          height: 12.0,
          child: Container(color: Colors.grey[200]),
        ),
      ],
    );
  }
}

class ClipboardText extends StatelessWidget {
  final String title;
  final String desc;

  ClipboardText({
    Key key,
    this.title,
    this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Clipboard.setData(ClipboardData(text: desc))
            .catchError((e) {})
            .whenComplete(() {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('Copied to clipboard'),
              duration: Duration(seconds: 2),
            ),
          );
        });
      },
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 15.0,
            fontFamily: 'HKGrotesk',
            fontWeight: FontWeight.w600,
            color: Colors.black.withOpacity(0.75),
          ),
          children: <TextSpan>[
            TextSpan(
              text: title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(text: desc),
          ],
        ),
      ),
    );
  }
}
