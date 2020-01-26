import 'package:cached_network_image/cached_network_image.dart';
import 'package:corona_flutter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ArticleSnippet extends StatelessWidget {
  final String title;
  final String timestamp;
  final String imgUrl;
  final VoidCallback onTap;

  const ArticleSnippet({
    Key key,
    this.title,
    this.timestamp,
    this.imgUrl,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 12.0,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 200.0,
            minWidth: double.maxFinite,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black.withOpacity(0.75),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      timestamp != ''
                          ? Text(
                              DateFormat.yMMMEd()
                                  .format(DateTime.parse(timestamp)),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              CachedNetworkImage(
                imageUrl: imgUrl,
                width: 100.0,
                height: 100.0,
                fit: BoxFit.cover,
                fadeInDuration: Duration(milliseconds: 300),
                errorWidget: (context, url, error) {
                  return Image.asset(
                    AppConstants.placeholderImgPath,
                    fit: BoxFit.cover,
                    width: 100.0,
                    height: 100.0,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
