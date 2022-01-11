import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'id_values.dart';

class TextResource {
  TextResource._(this.locale) : forIdValues = ForIdValues(const Locale('en'));

  final Locale locale;
  final ForIdValues forIdValues;

  static TextResource? of(BuildContext context) {
    return Localizations.of<TextResource>(context, TextResource);
  }
}

class TextResourceDelegate extends LocalizationsDelegate<TextResource> {
  const TextResourceDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<TextResource> load(Locale locale) {
    return SynchronousFuture<TextResource>(TextResource._(locale));
  }

  @override
  bool shouldReload(TextResourceDelegate old) => false;
}
