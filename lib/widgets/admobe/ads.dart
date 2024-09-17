import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sd_online/AdManger.dart';

class Ads {
  InterstitialAd? _interstitialAd;
  AppOpenAd? _appOpenAd;
  void showAd() {
    InterstitialAd.load(
        adUnitId: AdManger.interstitialAd,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            _interstitialAd = ad;
            if (_interstitialAd != null) {
              _interstitialAd!.show();
            }
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdWillDismissFullScreenContent: (ad) {
                ad.dispose();
              },
              onAdFailedToShowFullScreenContent: (ad, error) {
                ad.dispose();
              },
            );
          },
          onAdFailedToLoad: (error) {
            print(error);
          },
        ));
  }

  void showAppOpenAd() {
    AppOpenAd.load(
        adUnitId: AdManger.appOpenAd,
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(onAdLoaded: (ad) {
          _appOpenAd = ad;
          if (_appOpenAd != null) {
            _appOpenAd!.show();
          }
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdWillDismissFullScreenContent: (ad) {
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
            },
          );
        }, onAdFailedToLoad: (error) {
          print(error);
        }));
  }
}
