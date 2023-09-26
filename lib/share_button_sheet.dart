import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yotzim_basalon/models/enums.dart';
import 'package:yotzim_basalon/models/Event/event.dart';

enum SocialMedia { whatsapp, facebook, instagram }

class ShareButtonSheet extends StatelessWidget {
  final Event event;

  ShareButtonSheet({required this.event});

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
    final String link = ''; // add link for event

    final Map<SocialMedia, String> socialMediaUrls = {
      SocialMedia.whatsapp: 'whatsapp://send?text=$description\n\n'
          'Date: $day, $formattedDate GMT +03:00\n\n'
          'Location: $street, $city, $country\n\n$link',
      SocialMedia.facebook: '', // Add   Facebook sharing URL here
      SocialMedia.instagram: '', // Add Instagram sharing URL here
    };

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
            IconButton(
              icon: Icon(FontAwesomeIcons.whatsapp),
              onPressed: () async {
                final String whatsappUrl = socialMediaUrls[SocialMedia.whatsapp] ?? '';
                if (await canLaunchUrl(whatsappUrl)) {
                  await launchUrl(whatsappUrl);
                } else {
                  print('Could not launch WhatsApp');
                }
              },
            ),
            const SizedBox(width: 20.0),
            IconButton(
              icon: const Icon(FontAwesomeIcons.facebook),
              onPressed: () async {
                final String facebookUrl = socialMediaUrls[SocialMedia.facebook] ?? '';
                if (await canLaunchUrl(facebookUrl)) {
                  await launchUrl(facebookUrl);
                } else {
                  print('Could not launch Facebook');
                }
              },
            ),
            const SizedBox(width: 20.0),
            IconButton(
              icon: const Icon(FontAwesomeIcons.instagram),
              onPressed: () async {
                final String instagramUrl = socialMediaUrls[SocialMedia.instagram] ?? '';
                if (await canLaunchUrl(instagramUrl)) {
                  await launchUrl(instagramUrl);
                } else {
                  print('Could not launch Instagram');
                }
              },
            ),
          ],
        ),
      ],
    );
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
