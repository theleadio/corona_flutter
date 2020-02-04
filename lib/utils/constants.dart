import 'package:corona_flutter/pages/medical/sources_page.dart';

class AppConstants {
  static String coronaTrackerWebUrl = "https://www.coronatracker.com/";
  static String devListUrl =
      'https://docs.google.com/spreadsheets/d/1cG1UmEa-0IUetdKzYsMKXpypGFWoO88eTzadvN4NS5Y/';

  static String placeholderImgPath = 'assets/img/img_placeholder.png';

  // Shared Preferences
  static String sprefNewsFeedType = 'sprefNewsFeedType';
  static String sprefCountry = 'sprefCountry';

  // Countries
  static List<Map<String, String>> countriesList = [
    {"code": "GLOBAL", "name": "Global"},
    {"code": "CN", "name": "China"},
    {"code": "ID", "name": "Indonesia"},
    {"code": "JP", "name": "Japan"},
    {"code": "KR", "name": "South Korea"},
    {"code": "MY", "name": "Malaysia"},
    {"code": "PH", "name": "Philippines"},
    {"code": "SG", "name": "Singapore"},
    {"code": "TH", "name": "Thailand"},
    {"code": "VN", "name": "Vietnam"},
  ];

  // News Languages
  static List<Map<String, String>> languagesList = [
    {"id": "en", "name": "English"},
    {"id": "ms", "name": "Bahasa Melayu"},
    {"id": "zh", "name": "简体中文"},
    {"id": "zh_TW", "name": "繁體中文"},
  ];

  // About us text
  static String about = "CORONATRACKER.com is a community-based project powered by over 460 volunteers from across the globe, ranging from data scientists, medical professionals, UI/UX designers, fullstack developers, to the general public.\n\n" +
      "It acts as a portal for the public to keep track of the latest news development about the 2019-nCov, alongside collecting data for further analysis. All the contents are handpicked, filtered, and curated by volunteers to our best extent to ensure that sources are reliable with minimal hoaxes and fake news, in the best benefit of the public. Natural Language Processing (NLP) is used to analyze trending content and identify meaningful topics over various news sources and social media platforms prior to being verified by our team.\n\n" +
      "CORONATRACKER.com also aims to gather data for in-depth analysis (e.g. time series to monitor the growth, spread of the virus) and localized news (e.g. news related to Malaysia, or KL only).The platform is vital for information consolidation, and all gathered information is open to use for the public.This is a 100% open source project, all information and publishable data are available on Github as well. Everyone is welcomed to contribute through our telegram channel.\n\n" +
      "Our team of data scientists use OSEMN framework to collect, clean, explore, model, and run their own analysis. For ease of public understanding, it is presented using graphic visualizations and dashboards. Through the data obtained, we hope to build machine learning models very soon.\n\n" +
      "We were inspired by the Coronavirus Outbreak Map by John Hopkins University that was very informative. We also recognised the difficulty to gather data for in-depth analysis through various other sources of scattered data on different news portals as well as in different languages.\n\n" +
      "Works started on the 25th of January, the first day of the Lunar New Year. Our team has been working relentlessly to make this a success, and launched officially on the 27th of January.\n\n" +
      "We aim to use technology and make information more accessible, gather talented people all around the world to win the fight!";

  static List<Sources> sources = [
    Sources(
      title:
          'Discovery of a novel coronavirus associated with the recent pneumonia outbreak in humans and its potential bat origin',
      description:
          'A report by Jasper Fuk-Woo Chan and colleagues, documented infections in health-care workers caring for patients with 2019-nCoV indicate human-to-human transmission and thus the risk of much wider spread of the disease.',
      source: 'The Lancet',
      url:
          'https://www.thelancet.com/journals/lancet/article/PIIS0140-6736(20)30185-9/fulltext',
    ),
    Sources(
      title: 'Another year, another coronavirus',
      description:
          'For the third time in as many decades, a zoonotic coronavirus has crossed species to infect human populations. This virus, provisionally called 2019-nCoV, was first identified in Wuhan, China, in persons exposed to a seafood or wet market.',
      source: 'The New England Journal of Medcine',
      url: 'https://www.nejm.org/doi/full/10.1056/NEJMe2001126',
    ),
    Sources(
      title: 'Wuhan Coronavirus (2019-nCoV) Global Cases (by JHU CSSE)',
      description:
          'An online dashboard to visualize and track the reported cases on a daily timescale',
      source: 'John Hopkins University',
      url:
          'https://gisanddata.maps.arcgis.com/apps/opsdashboard/index.html#/bda7594740fd40299423467b48e9ecf6',
    ),
  ];
}
