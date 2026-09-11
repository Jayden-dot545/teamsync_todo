import 'package:flutter/widgets.dart';
import '../uebersetzungen/app_localizations.dart';
import '../uebersetzungen/app_localizations_de.dart';
import '../uebersetzungen/app_localizations_en.dart';
import 'user_prefs.dart';

export '../uebersetzungen/app_localizations.dart';

extension LocalizationContext on BuildContext {
  AppLocalizations get l10n {
    final loc = AppLocalizations.of(this);
    if (loc != null) return loc;
    final prefLocale = UserPrefs.localeNotifier.value;
    if (prefLocale?.languageCode == 'en') {
      return AppLocalizationsEn();
    }
    return AppLocalizationsDe();
  }

  bool get isEn => l10n.localeName.startsWith('en');
}

