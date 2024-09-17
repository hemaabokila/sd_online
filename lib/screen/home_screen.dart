import "package:flutter/material.dart";
import "package:sd_online/constants.dart";
import "package:sd_online/widgets/admobe/ads.dart";
import "package:sd_online/widgets/hmoe/card.dart";
import "package:sd_online/widgets/hmoe/home_body.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kPrimaryColor,
      appBar: homeAppBar(),
      body: const HomeBody(),
    );
  }

  AppBar homeAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      title: const Text(
        "سيدى سالم اونلاين",
      ),
      centerTitle: false,
      actions: [
        IconButton(
          onPressed: () {
            Ads().showAppOpenAd();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const MyCard(),
              ),
            );
          },
          icon: const Icon(Icons.menu),
        )
      ],
    );
  }
}
