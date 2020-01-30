import 'package:ant_icons/ant_icons.dart';
import 'package:corona_flutter/core/hospital.dart';
import 'package:corona_flutter/model/model.dart';
import 'package:corona_flutter/utils/helper.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recase/recase.dart';

class HospitalPage extends StatefulWidget {
  final HospitalsService hospitalsService;

  const HospitalPage({
    Key key,
    this.hospitalsService,
  }) : super(key: key);

  @override
  _HospitalPageState createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
  ScrollController hospitalsController;
  ScrollController appBarController;
  List<Hospital> hospitals = [];

  @override
  void initState() {
    super.initState();

    appBarController = ScrollController();
    hospitalsController = ScrollController()
      ..addListener(() {
        appBarController.jumpTo(hospitalsController.offset);
      });

    widget.hospitalsService.addListener(() {
      setState(() {});
    });

    widget.hospitalsService.refreshHospitals();
  }

  @override
  void dispose() {
    hospitalsController.dispose();
    super.dispose();
  }

  Future<void> handleRefresh() async {
    setState(() {
      widget.hospitalsService.refreshHospitals();
    });
    return;
  }

  List<Widget> _buildHospitalSnippets() {
    if (widget.hospitalsService.localHospitalsList.length == 0)
      return [
        Center(
          child: Text('No result'),
        ),
      ];

    return widget.hospitalsService.localHospitalsList
        .map(
          (hospital) => HospitalSnippet(
            name: hospital.name,
            address: hospital.address,
            city: hospital.city,
            state: hospital.state,
            country: hospital.country,
            telNumber: hospital.telNo,
            webUrl: hospital.officialAdvisory ?? '',
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: appBarController,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            centerTitle: true,
            title: Text(
              'Hospitals',
              style: TextStyle(
                fontSize: 24.0,
                fontFamily: 'AbrilFatface',
                color: Colors.black.withOpacity(0.75),
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Helper.getFlagIcon(
                  countryCode: widget.hospitalsService.countryCode ?? 'GLOBAL',
                  width: 24.0,
                  height: null,
                  color: Colors.black.withOpacity(0.75),
                ),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ],
            elevation: 0.0,
            backgroundColor: Colors.white24,
          ),
        ];
      },
      body: RefreshIndicator(
        onRefresh: handleRefresh,
        child: DraggableScrollbar.rrect(
          backgroundColor: Colors.teal,
          heightScrollThumb: 64.0,
          controller: hospitalsController,
          child: ListView(
            key: PageStorageKey('hospitals'),
            controller: hospitalsController,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  '${Helper.getCountryName(widget.hospitalsService.countryCode ?? 'GLOBAL')}',
                  style: TextStyle(
                    fontSize: 50.0,
                    fontFamily: 'AbrilFatface',
                    fontWeight: FontWeight.w700,
                    color: Colors.black.withOpacity(0.75),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 24.0,
                  right: MediaQuery.of(context).size.width * 0.20,
                ),
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                    isExpanded: true,
                    items: widget.hospitalsService
                        .getStateByCountry()
                        .map(
                          (state) => DropdownMenuItem(
                            child: Text(state),
                            value: state,
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        widget.hospitalsService.state = value;
                      });
                    },
                    elevation: 4,
                    style: TextStyle(
                        fontFamily: 'HKGrotesk',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.black.withOpacity(0.75)),
                    value: widget.hospitalsService.state,
                    underline: Container(
                      height: 2,
                      width: 60.0,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              ..._buildHospitalSnippets(),
            ],
          ),
        ),
      ),
    );
  }
}

class HospitalSnippet extends StatelessWidget {
  final String name;
  final String address;
  final String city;
  final String state;
  final String country;
  final String telNumber;
  final String webUrl;

  const HospitalSnippet({
    Key key,
    this.name,
    this.address,
    this.city,
    this.state,
    this.country,
    this.telNumber,
    this.webUrl,
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
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black.withOpacity(0.75),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ClipboardText(
                  title: 'Address:',
                  desc: ' $address',
                ),
              ),
              ClipboardText(
                title: 'Tel No.:',
                desc: ' $telNumber',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ClipboardText(
                  title: 'City:',
                  desc:
                      ' ${city.titleCase}, ${state.titleCase}, ${Helper.getCountryName(country)}',
                ),
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    color: Colors.teal,
                    icon: Container(
                      child: Icon(
                        AntIcons.phone_outline,
                      ),
                    ),
                    onPressed: () {
                      Helper.openTelNum(telNumber);
                    },
                  ),
                  webUrl.length <= 0
                      ? Container()
                      : IconButton(
                          icon: Icon(
                            AntIcons.global,
                            color: Colors.teal,
                          ),
                          onPressed: () {
                            Helper.openWebUrl(context: context, url: webUrl);
                          },
                        )
                ],
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
