import 'package:flutter/material.dart';
import 'package:sd_online/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class MyCard extends StatefulWidget {
  const MyCard({super.key});

  @override
  State<MyCard> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    final Uri url = Uri.parse('tel:+021020687061');
    final Uri url1 = Uri.parse('mailto:ibrahemabokila@gmail.com');
    final Uri url2 = Uri.parse('https://www.facebook.com/ibrahimhelal22');
    final Uri url3 = Uri.parse('https://www.youtube.com/@cryptodome22');
    final Uri url4 = Uri.parse('https://www.tiktok.com/@ibrahimhelal1992');
    // Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: detailsAppBar(context),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("images/hema.jpg"),
            ),
            const Text(
              "إبراهيم هلال ابوكيلة",
              style: TextStyle(
                  fontSize: 38,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "مبرمج تطبيقات ومواقع",
              style: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 200,
              height: 20,
              child: Divider(
                color: Colors.cyan[100],
              ),
            ),
            Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: const Icon(
                  Icons.phone,
                  color: kPrimaryColor,
                ),
                onTap: () async {
                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch $url');
                  }
                },
                title: const Text(
                  "01020687061",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: const Icon(
                  Icons.email,
                  color: kPrimaryColor,
                ),
                onTap: () async {
                  if (!await launchUrl(url1)) {
                    throw Exception('Could not launch $url1');
                  }
                },
                title: const Text(
                  "email إضغط هنا",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: const Icon(
                  Icons.facebook,
                  color: kPrimaryColor,
                ),
                onTap: () async {
                  if (!await launchUrl(url2)) {
                    throw Exception('Could not launch $url2');
                  }
                },
                title: const Text(
                  "facebook إضغط هنا",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: const Icon(
                  Icons.home,
                  color: kPrimaryColor,
                ),
                onTap: () async {
                  if (!await launchUrl(url3)) {
                    throw Exception('Could not launch $url3');
                  }
                },
                title: const Text(
                  "youtube إضغط هنا",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: const Icon(
                  Icons.tiktok,
                  color: kPrimaryColor,
                ),
                onTap: () async {
                  if (!await launchUrl(url4)) {
                    throw Exception('Could not launch $url4');
                  }
                },
                title: const Text(
                  "tiktok إضغط هنا",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar detailsAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: kBackgroundColor,
      leading: IconButton(
        padding: const EdgeInsets.only(right: kDefaultPadding),
        icon: const Icon(
          Icons.arrow_back,
          color: kPrimaryColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: false,
      title: Text(
        "رجوع",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
