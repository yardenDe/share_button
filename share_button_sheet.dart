import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:yotzim_basalon/models/enums.dart';
import 'package:yotzim_basalon/models/Event/event.dart';


enum SocialMedia { whatsapp, facebook, instagram }

class ShareButtonSheet extends StatelessWidget {
  final Event event;

  ShareButtonSheet({super.key, required this.event});

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            const SizedBox(width: 120),
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
            )

          ],
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () {
            final String description = event.description[Language.hebrew] ?? '';
            final String formattedDate =
            DateFormat('MMM d, HH:mm').format(event.startTime);
            final String day = DateFormat('EEE').format(event.startTime);
            final String street = event.address.street[Language.english] ?? '';
            final String city = event.address.city[Language.english] ?? '';
            final String country = event.address.country[Language.english] ?? '';
          //  final String imageUrl = event.imageUrl ?? '';

            String text = 'Check out "$description" on Eventbrite! \n\n'
                'Date: $day, $formattedDate\n\n'
                'Location: $country $city $street\n\n';
            final String urlShare = Uri.encodeComponent(
              //add link for current event
              ' ',
            );
            Clipboard.setData(ClipboardData(text: text));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('copied to clipboard!'),
              ),
            );
          },
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
                side: BorderSide(width: 1, color: Color(0xFF3F1E5B)),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.transparent,
            ),
          ),
          child: const Text(
            'קישור URL הועתק',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF3F1E5B),
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              height: 0.10,
              letterSpacing: 0.10,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.whatsapp,
                color: Colors.green.shade300,
              ),
              onPressed: () async {
                await share(SocialMedia.whatsapp);
              },
            ),
            const SizedBox(width: 20.0),
            IconButton(
              icon:  Icon(FontAwesomeIcons.instagram,
                color: Colors.orange.shade100,
              ),
              onPressed: () async {
                await share(SocialMedia.instagram);
              },
            ),
            const SizedBox(width: 20.0),
            IconButton(
              icon: const Icon(FontAwesomeIcons.facebook,
                color: Colors.blueAccent,
              ),
              onPressed: () async {
                await share(SocialMedia.facebook);
              },
            ),
          ],
        ),
      ],
    );
  }

  Future<void> share(SocialMedia platform,) async {
    final String description = event.description[Language.hebrew] ?? '';
    final String formattedDate =
    DateFormat('MMM d, HH:mm').format(event.startTime);
    final String day = DateFormat('EEE').format(event.startTime);
    final String street = event.address.street[Language.english] ?? '';
    final String city = event.address.city[Language.english] ?? '';
    final String country = event.address.country[Language.english] ?? '';
    final String imageUrl = event.imageUrl ?? '';
    final String link = '';
    String text = 'Check out $description on Eventbrite!%0A%0A'
        'Date: $day, $formattedDate%0A%0A'
        'Location: $country $city $street%0A%0A';
    final String urlShare = Uri.encodeComponent(link);

    final Map<SocialMedia, String> socialMediaUrls = {
      SocialMedia.whatsapp: 'https://api.whatsapp.com/send?text=$text$urlShare&image=$imageUrl',
      SocialMedia.facebook:
      'https://www.facebook.com/sharer/sharer.php?u=$urlShare&t=$text&picture=$imageUrl',
      SocialMedia.instagram: 'https://www.instagram.com/',
    };
    final String? url = socialMediaUrls[platform];
    if (await canLaunchUrlString(url!)) {
      await launchUrlString(url);
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
