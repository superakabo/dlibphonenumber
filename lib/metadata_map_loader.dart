abstract class MetadataMapLoader {
  const MetadataMapLoader();

  Map<String, Object?>? getTerritory(String code);
  Map<String, List<String>> get countryCodeToRegionCodeMap =>
      throw UnimplementedError();
}
