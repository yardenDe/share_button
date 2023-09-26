import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yotzim_basalon/models/enums.dart';
import 'package:yotzim_basalon/models/Event/event.dart';

enum SocialMedia { whatsapp, facebook, instagram }

class ShareButtonSheet extends StatelessWidget {
  final Event event;

  ShareButtonSheet({required this.event});

  final Map<SocialMedia, String> socialMediaUrls = {
    SocialMedia.whatsapp: 'whatsapp://send?text=',
    SocialMedia.facebook: 'https://www.facebook.com/sharer/sharer.php?u=',
    SocialMedia.instagram: 'https://www.instagram.com/',
  };

  @override
  Widget build(BuildContext context) {
    final String description = event.description[Language.hebrew] ?? '';
    final String formattedDate =
    DateFormat('MMM d, HH:mm').format(event.startTime);
    final String day = DateFormat('EEE').format(event.startTime);
    final String street = event.address.street[Language.english] ?? '';
    final String city = event.address.city[Language.english] ?? '';
    final String country = event.address.country[Language.english] ?? '';
    final String imageUrl = event.imageUrl ?? '';

    final String link = '';

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close),
            ),
            const SizedBox(
              width: 120,
            ),
            const Text(
              'איזה כיף! למי לשלוח את הקישור?',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ],
        ),
        const Text(
          'הועתק',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                IconButton(
                  icon: Icon(FontAwesomeIcons.whatsapp),
                  onPressed: () async {
                    await share(SocialMedia.whatsapp, imageUrl, description, day,
                        formattedDate, street, city, country, link);
                  },
                ),
              ],
            ),
            const SizedBox(
              width: 10.0,
            ),
            Column(
              children: <Widget>[
                IconButton(
                  icon: const Icon(FontAwesomeIcons.facebook),
                  onPressed: () async {
                    await share(SocialMedia.facebook, imageUrl, description, day,
                        formattedDate, street, city, country, link);
                  },
                ),
              ],
            ),
            const SizedBox(
              width: 10.0,
            ),
            Column(
              children: <Widget>[
                IconButton(
                  icon: const Icon(FontAwesomeIcons.instagram),
                  onPressed: () async {
                    await share(SocialMedia.instagram, imageUrl, description, day,
                        formattedDate, street, city, country, link);
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Future<void> share(
      SocialMedia platform,
      String imageUrl,
      String description,
      String day,
      String formattedDate,
      String street,
      String city,
      String country,
      String link,
      ) async {
    final String? socialMediaUrl = socialMediaUrls[platform];
    final String socialMediaAppName = platform.toString().split('.').last;

    // if (socialMediaUrl.isEmpty) {
    //   print('URL for $socialMediaAppName is not defined.');
    //   return;
    // }

    String content = Uri.encodeComponent(
        'Check out "$description" on Eventbrite!\n\n'
            'Date: $day , $formattedDate GMT +03:00\n\n'
            'Location: $street, $city, $country\n\n'
            'Link: $link');

    if (platform == SocialMedia.whatsapp) {

      ;
    } else if (platform == SocialMedia.facebook) {

      ;
    } else if (platform == SocialMedia.instagram) {

      ;
    }

    if (await canLaunchUrl(socialMediaUrl as Uri)) {
      await launchUrl(socialMediaUrl as Uri);
    } else {
      print('Could not launch $socialMediaAppName');
    }
  }
}

void showShareBottomSheet(BuildContext context, Event event) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return ShareButtonSheet(event: event);
    },
  );
}
