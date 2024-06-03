import 'package:boilerplate/providers/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

 Widget _buildLanguageDropDown(bool isDarkMode){
    return Selector<LocaleProvider, Locale>(
      selector: (ctx, localeProvider) => localeProvider.locale,
      builder: (BuildContext context, locale, Widget? child) { 
      return DropdownButton<Locale>(
                    value: locale,
                    onChanged: (newLocale) {
                      Provider.of<LocaleProvider>(context, listen: false)
                          .setLocale(newLocale!);
                    },
                    items: AppLocalizations.supportedLocales
                        .map((locale) => DropdownMenuItem<Locale>(
                              value: locale,
                              child: Text(locale.languageCode),
                            ))
                        .toList());
     },);
  }