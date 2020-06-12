
import 'dart:async';

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
import 'package:intl/src/intl_helpers.dart';

//import 'messages_de.dart' as messages_de;
//import 'messages_en.dart' as messages_en;
//import 'messages_fr.dart' as messages_fr;
//import 'messages_id.dart' as messages_id;
//import 'messages_it.dart' as messages_it;
//import 'messages_nl.dart' as messages_nl;
//import 'messages_pl.dart' as messages_pl;
//import 'messages_pt.dart' as messages_pt;
//import 'messages_ru.dart' as messages_ru;
//import 'messages_uk.dart' as messages_uk;
//import 'messages_zh.dart' as messages_zh;

typedef Future<dynamic> LibraryLoader();
Map<String, LibraryLoader> _deferredLibraries = {
  'de': () => new Future.value(null),
  'en': () => new Future.value(null),
  'fr': () => new Future.value(null),
  'id': () => new Future.value(null),
  'it': () => new Future.value(null),
  'nl': () => new Future.value(null),
  'pl': () => new Future.value(null),
  'pt': () => new Future.value(null),
  'ru': () => new Future.value(null),
  'uk': () => new Future.value(null),
  'zh': () => new Future.value(null),
};

MessageLookupByLibrary _findExact(String localeName) {
  switch (localeName) {
    case 'de':
      //return messages_de.messages;
    case 'en':
      //return messages_en.messages;
    case 'fr':
      //return messages_fr.messages;
    case 'id':
      //return messages_id.messages;
    case 'it':
      //return messages_it.messages;
    case 'nl':
      //return messages_nl.messages;
    case 'pl':
      //return messages_pl.messages;
    case 'pt':
      //return messages_pt.messages;
    case 'ru':
      //return messages_ru.messages;
    case 'uk':
      //return messages_uk.messages;
    case 'zh':
      //return messages_zh.messages;
    default:
      return null;
  }
}

/// User programs should call this before using [localeName] for messages.
Future<bool> initializeMessages(String localeName) async {
  var availableLocale = Intl.verifiedLocale(
      localeName, (locale) => _deferredLibraries[locale] != null,
      onFailure: (_) => null);
  if (availableLocale == null) {
    return new Future.value(false);
  }
  var lib = _deferredLibraries[availableLocale];
  await (lib == null ? new Future.value(false) : lib());
  initializeInternalMessageLookup(() => new CompositeMessageLookup());
  messageLookup.addLocale(availableLocale, _findGeneratedMessagesFor);
  return new Future.value(true);
}

bool _messagesExistFor(String locale) {
  try {
    return _findExact(locale) != null;
  } catch (e) {
    return false;
  }
}

MessageLookupByLibrary _findGeneratedMessagesFor(String locale) {
  var actualLocale =
  Intl.verifiedLocale(locale, _messagesExistFor, onFailure: (_) => null);
  if (actualLocale == null) return null;
  return _findExact(actualLocale);
}
