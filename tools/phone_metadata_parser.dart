import 'dart:collection';

import 'package:xml/xml.dart';

mixin PhoneMetadataParser {
  Map<String, dynamic> parseTerritory(XmlElement e) {
    return {
      'id': _getId(e),
      'country_code': _getCountryCode(e),
      'international_prefix': _getInternationalPrefix(e),
      'preferred_international_prefix': _getPreferredInternationalPrefix(e),
      'national_prefix': _getNationalPrefix(e),
      'preferred_extn_prefix': _getPreferredExtnPrefix(e),
      'national_prefix_for_parsing': _getNationalPrefixForParsing(e),
      'national_prefix_transform_rule': _getNationalPrefixTransformRule(e),
      'same_mobile_and_fixed_line_pattern': _getSameMobileAndFixedLinePattern(e),
      'main_country_for_code': _getMainCountryForCode(e),
      'leading_digits': _getLeadingDigits(e),
      'mobile_number_portable_region': _getMobileNumberPortableRegion(e),
      'general_desc': _getGeneralDesc(e),
      'fixed_line': _getGroup_(e, 'fixedLine'),
      'mobile': _getGroup_(e, 'mobile'),
      'toll_free': _getGroup_(e, 'tollFree'),
      'premium_rate': _getGroup_(e, 'premiumRate'),
      'shared_cost': _getGroup_(e, 'sharedCost'),
      'personal_number': _getGroup_(e, 'personalNumber'),
      'voip': _getGroup_(e, 'voip'),
      'pager': _getGroup_(e, 'pager'),
      'uan': _getGroup_(e, 'uan'),
      'emergency': _getGroup_(e, 'emergency'),
      'voicemail': _getGroup_(e, 'voicemail'),
      'short_code': _getGroup_(e, 'shortCode'),
      'standard_rate': _getGroup_(e, 'standardRate'),
      'carrier_specific': _getGroup_(e, 'carrierSpecific'),
      'sms_services': _getGroup_(e, 'smsServices'),
      'no_international_dialling': _getGroup_(e, 'noInternationalDialling'),
      'number_format': _getNumberFormat(e),
      'intl_number_format': _getIntlNumberFormat(e),
    };
  }

  String _getId(XmlElement e) {
    return e.getAttribute('id') ?? '';
  }

  int _getCountryCode(XmlElement e) {
    return int.parse(e.getAttribute('countryCode') ?? '0');
  }

  String? _getInternationalPrefix(XmlElement e) {
    return e.getAttribute('internationalPrefix');
  }

  String? _getPreferredInternationalPrefix(XmlElement e) {
    return e.getAttribute('preferredInternationalPrefix');
  }

  String? _getNationalPrefix(XmlElement e) {
    return e.getAttribute('nationalPrefix');
  }

  String? _getPreferredExtnPrefix(XmlElement e) {
    return e.getAttribute('preferredExtnPrefix');
  }

  String? _getNationalPrefixForParsing(XmlElement e) {
    final String? nationalPrefixForParsing = e.getAttribute('nationalPrefixForParsing');
    final String? nationalPrefix = _getNationalPrefix(e);
    final String? prefix = nationalPrefixForParsing ?? nationalPrefix;
    return prefix?.replaceAll('\n', '').replaceAll(' ', '');
  }

  String? _getNationalPrefixTransformRule(XmlElement e) {
    return e.getAttribute('nationalPrefixTransformRule');
  }

  bool _getSameMobileAndFixedLinePattern(XmlElement e) {
    final String value =
        e.getAttribute('sameMobileAndFixedLinePattern')?.replaceAll('\n', '').replaceAll(' ', '') ?? '';
    return bool.tryParse(value) ?? false;
  }

  bool _getMainCountryForCode(XmlElement e) {
    final String? value = e.getAttribute('mainCountryForCode');
    return bool.tryParse('$value') ?? false;
  }

  String? _getLeadingDigits(XmlElement e) {
    return e.getAttribute('leadingDigits');
  }

  bool _getMobileNumberPortableRegion(XmlElement e) {
    final String? value = e.getAttribute('mobileNumberPortableRegion');
    return bool.tryParse('$value') ?? false;
  }

  Map<String, dynamic> _getGeneralDesc(XmlElement e) {
    final SplayTreeSet<int> possibleLengthSet = SplayTreeSet();
    final SplayTreeSet<int> possibleLengthLocalSet = SplayTreeSet();

    possibleLengthSet.addAll(_addToPossibleLength_(e, 'fixedLine', 'possible_length'));
    possibleLengthLocalSet.addAll(_addToPossibleLength_(e, 'fixedLine', 'possible_length_local_only'));

    possibleLengthSet.addAll(_addToPossibleLength_(e, 'mobile', 'possible_length'));
    possibleLengthLocalSet.addAll(_addToPossibleLength_(e, 'mobile', 'possible_length_local_only'));

    possibleLengthSet.addAll(_addToPossibleLength_(e, 'tollFree', 'possible_length'));
    possibleLengthLocalSet.addAll(_addToPossibleLength_(e, 'tollFree', 'possible_length_local_only'));

    possibleLengthSet.addAll(_addToPossibleLength_(e, 'premiumRate', 'possible_length'));
    possibleLengthLocalSet.addAll(_addToPossibleLength_(e, 'premiumRate', 'possible_length_local_only'));

    possibleLengthSet.addAll(_addToPossibleLength_(e, 'sharedCost', 'possible_length'));
    possibleLengthLocalSet.addAll(_addToPossibleLength_(e, 'sharedCost', 'possible_length_local_only'));

    possibleLengthSet.addAll(_addToPossibleLength_(e, 'personalNumber', 'possible_length'));
    possibleLengthLocalSet.addAll(_addToPossibleLength_(e, 'personalNumber', 'possible_length_local_only'));

    possibleLengthSet.addAll(_addToPossibleLength_(e, 'voip', 'possible_length'));
    possibleLengthLocalSet.addAll(_addToPossibleLength_(e, 'voip', 'possible_length_local_only'));

    possibleLengthSet.addAll(_addToPossibleLength_(e, 'pager', 'possible_length'));
    possibleLengthLocalSet.addAll(_addToPossibleLength_(e, 'pager', 'possible_length_local_only'));

    possibleLengthSet.addAll(_addToPossibleLength_(e, 'uan', 'possible_length'));
    possibleLengthLocalSet.addAll(_addToPossibleLength_(e, 'uan', 'possible_length_local_only'));

    possibleLengthSet.addAll(_addToPossibleLength_(e, 'emergency', 'possible_length'));
    possibleLengthLocalSet.addAll(_addToPossibleLength_(e, 'emergency', 'possible_length_local_only'));

    possibleLengthSet.addAll(_addToPossibleLength_(e, 'voicemail', 'possible_length'));
    possibleLengthLocalSet.addAll(_addToPossibleLength_(e, 'voicemail', 'possible_length_local_only'));

    possibleLengthSet.addAll(_addToPossibleLength_(e, 'shortCode', 'possible_length'));
    possibleLengthLocalSet.addAll(_addToPossibleLength_(e, 'shortCode', 'possible_length_local_only'));

    possibleLengthSet.addAll(_addToPossibleLength_(e, 'standardRate', 'possible_length'));
    possibleLengthLocalSet.addAll(_addToPossibleLength_(e, 'standardRate', 'possible_length_local_only'));

    possibleLengthSet.addAll(_addToPossibleLength_(e, 'carrierSpecific', 'possible_length'));
    possibleLengthLocalSet.addAll(_addToPossibleLength_(e, 'carrierSpecific', 'possible_length_local_only'));

    possibleLengthSet.addAll(_addToPossibleLength_(e, 'smsServices', 'possible_length'));
    possibleLengthLocalSet.addAll(_addToPossibleLength_(e, 'smsServices', 'possible_length_local_only'));

    possibleLengthSet.addAll(_addToPossibleLength_(e, 'noInternationalDialling', 'possible_length'));
    possibleLengthLocalSet.addAll(_addToPossibleLength_(e, 'noInternationalDialling', 'possible_length_local_only'));

    final XmlElement? node = e.findElements('generalDesc').firstOrNull;
    return {
      'national_number_pattern': _getNationalNumberPattern_(node),
      'possible_length': possibleLengthSet.toList(),
      'possible_length_local_only': possibleLengthLocalSet.toList(),
      'example_number': _getExampleNumber_(node),
    };
  }

  List<Map<String, dynamic>> _getNumberFormat(XmlElement e) {
    final Iterable<XmlElement> nodes = e.findAllElements('numberFormat');
    return nodes.map((f) {
      return {
        'pattern': _getPattern_(f),
        'format': _getFormat_(f),
        'leading_digits_pattern': _getLeadingDigitsPattern_(f),
        'national_prefix_optional_when_formatting': _getNationalPrefixOptionalWhenFormatting_(e, f),
        'national_prefix_formatting_rule': _getPrefixFormattingRule_(e, f, 'nationalPrefixFormattingRule'),
        'domestic_carrier_code_formatting_rule': _getPrefixFormattingRule_(e, f, 'carrierCodeFormattingRule'),
      };
    }).toList();
  }

  List<dynamic> _getIntlNumberFormat(XmlElement e) {
    final Iterable<XmlElement> elements = e.findAllElements('numberFormat').where((f) => _hasIntlFormat_(f));
    return elements.map((f) {
      final String? intFormat = _getIntlFormat_(f);
      final String? format = intFormat ?? _getFormat_(f);
      return {
        'pattern': _getPattern_(f),
        'format': format,
        'leading_digits_pattern': _getLeadingDigitsPattern_(f),
        'national_prefix_formatting_rule': _getPrefixFormattingRule_(e, f, 'nationalPrefixFormattingRule'),
        'domestic_carrier_code_formatting_rule': _getPrefixFormattingRule_(e, f, 'carrierCodeFormattingRule'),
        'national_prefix_optional_when_formatting': _getNationalPrefixOptionalWhenFormatting_(e, f),
      };
    }).toList();
  }

  List<int> _addToPossibleLength_(XmlElement e, String parentName, String childName) {
    final Map<String, dynamic>? node = _getGroup_(e, parentName);
    final List<int> lengths = List<int>.from(node?[childName] ?? []);
    return lengths.where((f) => f != -1).toList();
  }

  Map<String, dynamic>? _getGroup_(XmlElement e, String selector) {
    final XmlElement? node = e.findElements(selector).firstOrNull;
    final List<int>? nationalLength = _getPossibleLengths_(node, 'national');
    final List<int>? localOnlyLength = _getPossibleLengths_(node, 'localOnly');

    return {
      'national_number_pattern': _getNationalNumberPattern_(node),
      'possible_length': (nationalLength != null) ? nationalLength : [-1],
      'possible_length_local_only': (localOnlyLength != null) ? localOnlyLength : [-1],
      'example_number': _getExampleNumber_(node),
    };
  }

  String? _getNationalNumberPattern_(XmlElement? e) {
    return e?.findElements('nationalNumberPattern').firstOrNull?.innerText.replaceAll('\n', '').replaceAll(' ', '');
  }

  List<int>? _getPossibleLengths_(XmlElement? e, String attributeName) {
    final Iterable<XmlElement>? nodes = e?.findAllElements('possibleLengths').where((node) {
      return (node.getAttribute(attributeName) != null);
    });

    final List<int> lengths = [];

    for (XmlElement node in nodes ?? []) {
      List<String> rangeGroups = node.getAttribute(attributeName)?.split(',') ?? [];

      for (String group in rangeGroups) {
        if (group.contains(',')) {
          Iterable<int> ranges = group.split(',').map((e) => int.parse(e));
          lengths.addAll(ranges);
        } else {
          List<String> range = group.replaceAll('[', '').replaceAll(']', '').split('-');
          int start = int.parse(range.first);
          int end = int.parse(range.last);
          List<int> ranges = List<int>.generate(end - start + 1, (index) => start + index);
          lengths.addAll(ranges);
        }
      }
    }

    return (lengths.isEmpty) ? null : lengths;
  }

  String? _getExampleNumber_(XmlElement? e) {
    return e?.findElements('exampleNumber').firstOrNull?.innerText;
  }

  String? _getPattern_(XmlElement e) {
    return e.getAttribute('pattern')?.replaceAll('\n', '').replaceAll(' ', '');
  }

  String? _getFormat_(XmlElement e) {
    return e.findElements('format').firstOrNull?.innerText;
  }

  String? _getIntlFormat_(XmlElement e) {
    return e.findElements('intlFormat').firstOrNull?.innerText;
  }

  bool _hasIntlFormat_(XmlElement e) {
    final String? intFormat = _getIntlFormat_(e);
    return (intFormat != 'NA');
  }

  List<String?> _getLeadingDigitsPattern_(XmlElement e) {
    return e.findAllElements('leadingDigits').map((e) => e.innerText.replaceAll('\n', '').replaceAll(' ', '')).toList();
  }

  String? _getPrefixFormattingRule_(XmlElement e, XmlElement f, String attribute) {
    final String? rootRule = e.getAttribute(attribute);
    final String? childRule = f.getAttribute(attribute);
    final String? rule = childRule ?? rootRule;

    final String? rootFormat = _getFormat_(e);
    final String? childFormat = _getFormat_(f);
    final String format = childFormat ?? rootFormat ?? '';

    final String prefix = _getNationalPrefix(e) ?? '';
    final RegExpMatch? match = RegExp(r"\$(\d+)").firstMatch(format);

    if (match != null) {
      final String firstGroup = match.group(1) ?? '';
      return rule?.replaceFirst('\$NP', prefix).replaceFirst('FG', firstGroup);
    }

    return null;
  }

  bool _getNationalPrefixOptionalWhenFormatting_(XmlElement e, XmlElement f) {
    final String? rootNationalPrefix = e.getAttribute('nationalPrefixOptionalWhenFormatting');
    final String? numberFormatNationalPrefix = f.getAttribute('nationalPrefixOptionalWhenFormatting');
    final String? value = rootNationalPrefix ?? numberFormatNationalPrefix;
    return bool.tryParse('$value') ?? false;
  }
}
