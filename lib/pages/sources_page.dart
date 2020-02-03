import 'package:corona_flutter/utils/constants.dart';
import 'package:corona_flutter/utils/helper.dart';
import 'package:flutter/material.dart';

class SourcesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 24.0, top: 16.0),
          child: Text(
            'Sources',
            style: TextStyle(
              fontSize: 45.0,
              fontFamily: 'AbrilFatface',
              fontWeight: FontWeight.w700,
              color: Colors.black.withOpacity(0.75),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 8.0),
          child: Text(
            'Here you can find a list of sources handpicked by the team.',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black.withOpacity(0.75),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: 36.0,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                height: 1.0,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 12.0,
          child: Container(color: Colors.grey[200]),
        ),
        ...AppConstants.sources
            .map(
              (source) => SourcesSnippet(
                title: source.title,
                source: source.source,
                description: source.description,
                url: source.url,
              ),
            )
            .toList(),
        SizedBox(
          height: 36.0,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                height: 1.0,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 8.0),
          child: Text(
            'If you believe any of the source information above is inaccurate, please lodge a report using the following form.',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black.withOpacity(0.75),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 24.0,
            horizontal: 24.0,
          ),
          child: FlatButton(
            color: Colors.teal,
            onPressed: () {
              Helper.openWebUrl(
                context: context,
                url:
                    'https://docs.google.com/forms/d/1A5Sw_gdJ6tsHA74Bz2_2uVMKqf9k_APRMQIAEoSXSNY/viewform?edit_requested=true',
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Issues Report Form',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }
}

class SourcesSnippet extends StatelessWidget {
  final String title;
  final String description;
  final String source;
  final String url;

  const SourcesSnippet({
    Key key,
    this.title,
    this.description,
    this.source,
    this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Helper.openWebUrl(
        context: context,
        url: url,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black.withOpacity(0.75),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              source,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black.withOpacity(0.75),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          SizedBox(
            height: 12.0,
            child: Container(color: Colors.grey[200]),
          ),
        ],
      ),
    );
  }
}

class Sources {
  final String title;
  final String description;
  final String source;
  final String url;

  Sources({
    this.title,
    this.description,
    this.source,
    this.url,
  });
}
