import 'package:ant_icons/ant_icons.dart';
import 'package:corona_flutter/utils/constants.dart';
import 'package:corona_flutter/utils/helper.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.grey[50],
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black.withOpacity(0.75),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              centerTitle: true,
              title: Text(
                'About',
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'AbrilFatface',
                  color: Colors.black.withOpacity(0.75),
                  fontWeight: FontWeight.w700,
                ),
              ),
              floating: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: Text(
                      AppConstants.about,
                      textAlign: TextAlign.justify,
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
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        child: Container(
                          height: 1.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: Text(
                      'Heroes behind CoronaTracker',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.teal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  ...Developer.developers
                      .map(
                        (dev) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24.0,
                          ),
                          child: DeveloperSnippet(
                            name: dev.name,
                            position: dev.position,
                            linkedInUrl: dev.linkedInUrl,
                            twitterUrl: dev.twitterUrl,
                            mediumUrl: dev.mediumUrl,
                            pathToImage: dev.pathToImage,
                          ),
                        ),
                      )
                      .toList(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: FlatButton(
                      color: Colors.teal,
                      onPressed: () {
                        Helper.openWebUrl(
                          context: context,
                          url: AppConstants.devListUrl,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'AND MANY MORE!',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Made with Flutter',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DeveloperSnippet extends StatelessWidget {
  final String name;
  final String position;
  final String linkedInUrl;
  final String twitterUrl;
  final String mediumUrl;
  final String pathToImage;

  DeveloperSnippet({
    this.name,
    this.position,
    this.linkedInUrl,
    this.twitterUrl,
    this.mediumUrl,
    this.pathToImage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 64.0,
          height: 64.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36.0),
            image: DecorationImage(
              image: AssetImage(pathToImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 12.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black.withOpacity(0.75),
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                position,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black.withOpacity(0.75),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: <Widget>[
                  linkedInUrl.length <= 0
                      ? Container()
                      : IconButton(
                          icon: Icon(
                            AntIcons.linkedin,
                            color: Colors.black.withOpacity(0.75),
                          ),
                          iconSize: 36.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Helper.openWebUrl(
                                context: context, url: linkedInUrl);
                          },
                        ),
                  twitterUrl.length <= 0
                      ? Container()
                      : IconButton(
                          icon: Icon(
                            AntIcons.twitter_square,
                            color: Colors.black.withOpacity(0.75),
                          ),
                          iconSize: 36.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Helper.openWebUrl(
                                context: context, url: twitterUrl);
                          },
                        ),
                  mediumUrl.length <= 0
                      ? Container()
                      : IconButton(
                          icon: Icon(
                            AntIcons.medium,
                            color: Colors.black.withOpacity(0.75),
                          ),
                          iconSize: 36.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Helper.openWebUrl(context: context, url: mediumUrl);
                          },
                        ),
                ],
              ),
              SizedBox(height: 8.0),
            ],
          ),
        ),
      ],
    );
  }
}

class Developer {
  final String name;
  final String position;
  final String linkedInUrl;
  final String twitterUrl;
  final String mediumUrl;
  final String pathToImage;

  Developer({
    this.name,
    this.position,
    this.linkedInUrl,
    this.twitterUrl,
    this.mediumUrl,
    this.pathToImage,
  });

  static List<Developer> developers = [
    Developer(
      name: 'Dr. Lau Cher Han',
      position: 'Project Lead',
      linkedInUrl: 'https://www.linkedin.com/in/drhanlau/',
      twitterUrl: '',
      mediumUrl: '',
      pathToImage: 'assets/img/laucherhan.webp',
    ),
    Developer(
      name: 'Hafeez Nazri',
      position: 'Lead Data Scientist',
      linkedInUrl: 'https://www.linkedin.com/in/hafeeznazri/',
      twitterUrl: '',
      mediumUrl: '',
      pathToImage: 'assets/img/hafeezn.webp',
    ),
    Developer(
      name: 'Tan Wei Seng',
      position: 'Lead Frontend Engineer',
      linkedInUrl: 'https://www.linkedin.com/in/wei-seng-tan-304ba78a/',
      twitterUrl: '',
      mediumUrl: '',
      pathToImage: 'assets/img/tanweiseng.webp',
    ),
    Developer(
      name: 'Poon Chee Him',
      position: 'Lead Mobile Developer',
      linkedInUrl: 'https://www.linkedin.com/in/poon-cheehim/',
      twitterUrl: 'https://twitter.com/lvlzeros',
      mediumUrl: 'https://medium.com/@lvlzeros',
      pathToImage: 'assets/img/shian.webp',
    ),
    Developer(
      name: 'Dominic Ligot',
      position: 'Lead Analyst',
      linkedInUrl: 'https://www.linkedin.com/in/docligot/',
      twitterUrl: '',
      mediumUrl: '',
      pathToImage: 'assets/img/dominic.webp',
    ),
    Developer(
      name: 'Ummi Hasanah Zaidon',
      position: 'Head of Public Relation',
      linkedInUrl: 'https://www.linkedin.com/in/ummi-hasanah-zaidon-32148280/',
      twitterUrl: '',
      mediumUrl: '',
      pathToImage: 'assets/img/ummi.webp',
    ),
    Developer(
      name: 'Marcus Chia',
      position: 'Head of Product',
      linkedInUrl: 'https://www.linkedin.com/in/marcuschiam5/',
      twitterUrl: '',
      mediumUrl: '',
      pathToImage: 'assets/img/marcus.webp',
    ),
    Developer(
      name: 'Assistant Professor Dr. Fairoza Amira Binti Hamzah',
      position: 'Lead Researcher',
      linkedInUrl: 'https://www.linkedin.com/in/fairoza-amira-binti-hamzah/',
      twitterUrl: '',
      mediumUrl: '',
      pathToImage: 'assets/img/fairoza.webp',
    ),
  ];
}
