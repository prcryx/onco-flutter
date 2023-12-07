enum CountryCode {
  ind,
  us,
  ca,
  uk,
  ger,
  fr,
  it,
  spn,
  chn,
  bz,
  aus,
  sk,
  arg,
  mx,
  ru,
  uae,
  ng,
  eg,
  jp,
  sa,
}

class CountryInfo {
  String country;
  String phoneCode;
  CountryCode code;

  CountryInfo({
    required this.country,
    required this.phoneCode,
    required this.code,
  });
}

class CountryInfoUtils {
  const CountryInfoUtils._();
  static List<CountryInfo> get _list => [
        CountryInfo(country: 'USA', phoneCode: '+1', code: CountryCode.us),
        CountryInfo(country: 'Canada', phoneCode: '+1', code: CountryCode.ca),
        CountryInfo(country: 'UK', phoneCode: '+44', code: CountryCode.uk),
        CountryInfo(
            country: 'Germany', phoneCode: '+49', code: CountryCode.ger),
        CountryInfo(country: 'France', phoneCode: '+33', code: CountryCode.fr),
        CountryInfo(country: 'Italy', phoneCode: '+39', code: CountryCode.it),
        CountryInfo(country: 'Spain', phoneCode: '+34', code: CountryCode.spn),
        CountryInfo(country: 'Japan', phoneCode: '+81', code: CountryCode.jp),
        CountryInfo(country: 'China', phoneCode: '+86', code: CountryCode.chn),
        CountryInfo(country: 'India', phoneCode: '+91', code: CountryCode.ind),
        CountryInfo(country: 'Brazil', phoneCode: '+55', code: CountryCode.bz),
        CountryInfo(
            country: 'Australia', phoneCode: '+61', code: CountryCode.aus),
        CountryInfo(
            country: 'South Korea', phoneCode: '+82', code: CountryCode.sk),
        CountryInfo(country: 'Mexico', phoneCode: '+52', code: CountryCode.mx),
        CountryInfo(country: 'Russia', phoneCode: '+7', code: CountryCode.ru),
        CountryInfo(
            country: 'South Africa', phoneCode: '+27', code: CountryCode.sa),
        CountryInfo(
            country: 'Argentina', phoneCode: '+54', code: CountryCode.arg),
        CountryInfo(
            country: 'Saudi Arabia', phoneCode: '+966', code: CountryCode.uae),
        CountryInfo(
            country: 'Nigeria', phoneCode: '+234', code: CountryCode.ng),
        CountryInfo(country: 'Egypt', phoneCode: '+20', code: CountryCode.eg),
      ];

  static List<CountryInfo> get countryInfoList => _list;

  static CountryInfo fromCountryCode(CountryCode code) {
    return _list.firstWhere((countryInfo) => countryInfo.code == code);
  }
}
