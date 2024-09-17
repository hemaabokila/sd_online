import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sd_online/AdManger.dart';
import 'package:sd_online/constants.dart';
import 'package:sd_online/widgets/hmoe/home_body2.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  List<QueryDocumentSnapshot> data = [];
  bool isloding = true;
  BannerAd? bannerAd;
  bool isLoaded = false;
  getDtat() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Categories")
        .orderBy("name")
        .where("id")
        .get();
    data.addAll(querySnapshot.docs);
    isloding = false;
    setState(() {});
  }

  @override
  void initState() {
    getDtat();
    load();
    super.initState();
  }

  void load() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdManger.bannerHome,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    )..load();
  }

  @override
  void dispose() {
    if (isLoaded) {
      bannerAd!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Center(
            child: isLoaded
                ? SizedBox(
                    width: bannerAd!.size.width.toDouble(),
                    height: bannerAd!.size.height.toDouble(),
                    child: AdWidget(
                      ad: bannerAd!,
                    ),
                  )
                : const SizedBox(),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 70),
                  decoration: const BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),
                isloding == true
                    ? const Center(
                        child: Text(
                          "جاري التحميل....",
                        ),
                      )
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, i) {
                          Size size = MediaQuery.of(context).size;
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding,
                              vertical: kDefaultPadding / 2,
                            ),
                            height: 190,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        HomeBody2(categorieid: data[i].id)));
                              },
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Container(
                                    height: 166,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(22),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          offset: Offset(0, 15),
                                          blurRadius: 25,
                                          color: Colors.black12,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 0.0,
                                    left: 0.0,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: kDefaultPadding),
                                      height: 160,
                                      width: 200,
                                      child: Image.network(
                                        "${data[i]['url']}",
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                          return const Text(
                                            'لا يوجد انترنت',
                                            style: TextStyle(fontSize: 20),
                                          );
                                        },
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0.0,
                                    right: 0.0,
                                    child: SizedBox(
                                      height: 136,
                                      width: size.width - 200,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: kDefaultPadding,
                                            ),
                                            child: Text(
                                              "${data[i]['name']}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                          ),
                                          const Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: kDefaultPadding),
                                            child: Text(
                                              "${data[i]['title']}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                          ),
                                          const Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.all(
                                                kDefaultPadding),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal:
                                                          kDefaultPadding * 1.5,
                                                      vertical:
                                                          kDefaultPadding / 50),
                                              decoration: BoxDecoration(
                                                color: kSecondaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(22),
                                              ),
                                              child: Text(
                                                "${data[i]['subtitle']}",
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ],
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
