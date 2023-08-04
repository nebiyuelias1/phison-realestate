// Flutter imports:
import 'package:flutter/material.dart';
import 'package:phison_realestate_mobile/pages/login/view/login_page.dart';
import 'package:phison_realestate_mobile/pages/main/view/main_page.dart';

import '../../../generated/l10n.dart';
import '../../../shared/constants/app_assets_constant.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
  static Page page() => const MaterialPage<void>(child: WelcomePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(PhisonImages.welcomeImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  PhisonColors.purple.shade50.withOpacity(0.4),
                  PhisonColors.purple.shade100.withOpacity(0.4),
                  PhisonColors.purple.shade200.withOpacity(0.4),
                  PhisonColors.purple.shade300.withOpacity(0.4),
                  PhisonColors.purple.shade400.withOpacity(0.5),
                  PhisonColors.purple.shade500.withOpacity(0.5),
                  PhisonColors.purple.shade600.withOpacity(0.5),
                  PhisonColors.purple.shade700.withOpacity(0.5),
                  PhisonColors.purple.shade800.withOpacity(0.5),
                  PhisonColors.purple.shade900.withOpacity(0.7),
                ],
                tileMode: TileMode.mirror,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    child: SizedBox.shrink(),
                  ),
                  Image.asset('assets/images/phison-logo.png'),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    S.of(context).letsFindYour,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.white),
                  ),
                  Text(
                    S.of(context).dreamHome,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: Colors.white),
                  ),
                  Text(
                    S.of(context).aLuxuriousResidentialHousesAndApartmentsInAddisAbabaEthiopia,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => const MainPage())));
                    },
                    child: Text(
                      S.of(context).continueAsGuest,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          S.of(context).or,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const LoginPage(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          PhisonColors.orange.shade900),
                    ),
                    child: Text(
                      S.of(context).login,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
