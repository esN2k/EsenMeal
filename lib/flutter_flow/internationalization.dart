import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['tr', 'en'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? trText = '',
    String? enText = '',
  }) =>
      [trText, enText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // Splash
  {
    'ftlk10x5': {
      'tr': 'Esen',
      'en': 'Esen',
    },
    'xhhiwnms': {
      'tr': 'Meal',
      'en': 'Meal',
    },
    '31v5xhd9': {
      'tr': 'Başlayalım',
      'en': 'Let\'s get started',
    },
    '4wjpihri': {
      'tr': 'Üye Misin?',
      'en': 'Are you a member?',
    },
    '8lsxlbi9': {
      'tr': 'Giriş Yap',
      'en': 'Login',
    },
    '98afmct9': {
      'tr': 'Ana Sayfa',
      'en': 'Home Page',
    },
  },
  // SignIn
  {
    's2vy008c': {
      'tr': 'Giriş Yap',
      'en': 'Login',
    },
    'j3xrk9jj': {
      'tr': 'E-posta',
      'en': 'Email',
    },
    'enkcecei': {
      'tr': 'dodikbalaman@gmail.com',
      'en': 'dodikbalaman@gmail.com',
    },
    '55ye3cf8': {
      'tr': 'Şifre',
      'en': 'Password',
    },
    'lhxezft7': {
      'tr': 'şifre',
      'en': 'password',
    },
    '2xnd42jl': {
      'tr': 'E-posta gereklidir.',
      'en': 'Email is required.',
    },
    'dj1rve5w': {
      'tr': 'Lütfen açılır menüden bir seçenek seçin',
      'en': 'Please select an option from the drop-down menu',
    },
    '9tyhbmdw': {
      'tr': 'Şifre gereklidir.',
      'en': 'Password is required.',
    },
    '6fhsm0au': {
      'tr': 'Lütfen açılır menüden bir seçenek seçin',
      'en': 'Please select an option from the drop-down menu',
    },
    '3lhh97lc': {
      'tr': 'Giriş Yap',
      'en': 'Login',
    },
    'ikxbufr4': {
      'tr': 'Şifremi hatırlamıyorum',
      'en': 'I don\'t remember my password',
    },
    '56rqthk3': {
      'tr': 'Henüz bir hesabınız yok mu?',
      'en': 'Don\'t have an account yet?',
    },
    'm18p91z9': {
      'tr': 'Hesap Oluştur',
      'en': 'Create Account',
    },
    'nnh5sv0f': {
      'tr': 'Ana Sayfa',
      'en': 'Home Page',
    },
  },
  // Onboarding_Slideshow
  {
    'qaffj8g9': {
      'tr': 'Yerel, Özelleştirilmiş\nYemek Planlama',
      'en': 'Local, Customized\nMeal Planning',
    },
    'dvq8k6lg': {
      'tr':
          'Sağlıklı yemek seçeneklerimiz arasından kendi özelleştirilmiş yemek planınızı oluşturun.',
      'en':
          'Create your own customized meal plan from our selection of healthy meals.',
    },
    'lt12kdpa': {
      'tr': 'Lezzetli ve Besleyici Taze Yemekler',
      'en': 'Delicious and Nutritious Fresh Meals',
    },
    'afqq2gek': {
      'tr':
          'Taze, yüksek kaliteli malzemelerle hazırlanan, kapınıza kadar teslim edilen sağlıklı ve lezzetli yemeklerin tadını çıkarın.',
      'en':
          'Enjoy healthy and delicious meals made with fresh, high-quality ingredients, delivered right to your door.',
    },
    'tmze9jvy': {
      'tr': 'Gurme Kalitesi,\nSorunsuz',
      'en': 'Gourmet Quality,\nProblem-Free',
    },
    '9yy6vzec': {
      'tr':
          'Gurme yemek dağıtım hizmetimizle, yemek pişirme veya temizlik zahmetine girmeden şeften ilham alan yemeklerin tadını çıkarın.',
      'en':
          'Enjoy chef-inspired meals without the hassle of cooking or cleanup with our gourmet meal delivery service.',
    },
    'ad9tk3z8': {
      'tr': 'Devam et',
      'en': 'Continue',
    },
    '6drb072m': {
      'tr': 'Ana Sayfa',
      'en': 'Home Page',
    },
  },
  // Onboarding_CreateAccount
  {
    'd9kxnl4m': {
      'tr': 'Create an account',
      'en': 'Create an account',
    },
    'dbt4iqx9': {
      'tr': 'Ad Soyad',
      'en': 'Name Surname',
    },
    '23mqq1h9': {
      'tr': 'E-posta',
      'en': 'Email',
    },
    '4hfqujz1': {
      'tr': 'Şifre',
      'en': 'Password',
    },
    'm4lppm7g': {
      'tr': 'Tam isim gereklidir.',
      'en': 'Full name is required.',
    },
    'lk9f96e1': {
      'tr': 'Lütfen açılır menüden bir seçenek seçin',
      'en': 'Please select an option from the drop-down menu',
    },
    'iyd781wa': {
      'tr': 'E-posta gereklidir.',
      'en': 'Email is required.',
    },
    '3b93m7va': {
      'tr': 'Lütfen açılır menüden bir seçenek seçin',
      'en': 'Please select an option from the drop-down menu',
    },
    'dtyrqbhc': {
      'tr': 'Şifre gereklidir.',
      'en': 'Password is required.',
    },
    '1woik12o': {
      'tr': 'Lütfen açılır menüden bir seçenek seçin',
      'en': 'Please select an option from the drop-down menu',
    },
    'dq9psavc': {
      'tr': 'Hesap Oluştur',
      'en': 'Create Account',
    },
    '6ongsqy2': {
      'tr': '“Hesap Oluştur” seçeneğine tıklayarak EsenMeal\'ın',
      'en':
          'By clicking on the “Create Account” option, you can sign up for EsenMeal',
    },
    '2pblnw75': {
      'tr': 'Kullanım Koşulları',
      'en': 'Terms of Use',
    },
    'bhixtav8': {
      'tr': '.',
      'en': '.',
    },
    'v86fzc5i': {
      'tr': 'Ana Sayfa',
      'en': 'Home Page',
    },
  },
  // Dashboard
  {
    'c4t4o3xf': {
      'tr': 'Bu haftanın yemekleri',
      'en': 'This week\'s dishes',
    },
    'ypkv73np': {
      'tr': 'Her hafta taze malzemelerle sipariş üzerine yapılır.',
      'en': 'Made to order with fresh ingredients every week.',
    },
    '8hmmat3d': {
      'tr': 'Yemekler',
      'en': 'Foods',
    },
  },
  // MealDetails
  {
    'p7j8y38u': {
      'tr': 'Malzemeler',
      'en': 'Materials',
    },
    'pobcme6j': {
      'tr': 'Alerjenler',
      'en': 'Allergens',
    },
    'mjqhhvq9': {
      'tr': 'Ana Sayfa',
      'en': 'Home Page',
    },
  },
  // Profile
  {
    'c3kv9o0d': {
      'tr': 'Bizi desteklediğiniz için teşekkür ederiz!',
      'en': 'Thank you for supporting us!',
    },
    'kgh51cuf': {
      'tr':
          'Bizim gibi bir yerel işletmeyi desteklediğiniz için teşekkür eder, iyi eğlenceler dileriz.',
      'en':
          'Thank you for supporting a local business like us and we hope you have fun.',
    },
    'ircptpp9': {
      'tr': 'Profil Düzenle',
      'en': 'Edit Profile',
    },
    '57x88ouh': {
      'tr': 'Yemek Tercihleri',
      'en': 'Food Preferences',
    },
    '0ncruabu': {
      'tr': 'Hakkımızda',
      'en': 'About Us',
    },
    'lij60voe': {
      'tr': 'Destek Merkezi',
      'en': 'Support Center',
    },
    '46uk37z7': {
      'tr': 'Bize Ulaşın',
      'en': 'Contact us',
    },
    'bwl07a9y': {
      'tr': 'EsenMeal Uygulamasını Paylaş',
      'en': 'Share EsenMeal App',
    },
    'tciosm8t': {
      'tr': 'App Store\'da İncele',
      'en': 'Check it out on the App Store',
    },
    'gv8a91o1': {
      'tr': 'Oturumu kapat',
      'en': 'Log out',
    },
    'upjxgphb': {
      'tr': 'Profil',
      'en': 'Profile',
    },
  },
  // EditProfile
  {
    'h5o4ato9': {
      'tr': 'Profil Düzenle',
      'en': 'Edit Profile',
    },
    '3o2812gv': {
      'tr': 'Ad Soyad',
      'en': 'Name Surname',
    },
    'd3n4xbcd': {
      'tr': '',
      'en': '',
    },
    'ect2f8wa': {
      'tr': '',
      'en': '',
    },
    'hr2y9oa3': {
      'tr': 'Şifre Sıfırlama',
      'en': 'Password Reset',
    },
    'q3h3nqv8': {
      'tr': 'Hesabı Sil',
      'en': 'Delete Account',
    },
    'w5k5wmw2': {
      'tr': 'Ana Sayfa',
      'en': 'Home Page',
    },
  },
  // AboutUs
  {
    'bnkxu3y2': {
      'tr': 'Hakkımızda',
      'en': 'About Us',
    },
    'ldsk4k8r': {
      'tr': 'Şefleriniz',
      'en': 'Your Chiefs',
    },
    '05h4mca9': {
      'tr': 'Ana Sayfa',
      'en': 'Home Page',
    },
  },
  // EatingPreferences
  {
    '8qqy010q': {
      'tr': 'Yemek Tercihleri',
      'en': 'Food Preferences',
    },
    'ff5kww42': {
      'tr': 'Diyet',
      'en': 'Diet',
    },
    'rr9egqgr': {
      'tr': 'Alerjenler',
      'en': 'Allergens',
    },
    'eqsljcfa': {
      'tr': 'Beğenmediğiniz Malzemeler',
      'en': 'Ingredients You Don\'t Like',
    },
    'rlvb21id': {
      'tr': 'Ana Sayfa',
      'en': 'Home Page',
    },
  },
  // SupportCenter
  {
    'j0taqs22': {
      'tr': 'Destek Merkezi',
      'en': 'Support Center',
    },
    'l2n580ow': {
      'tr': 'Ana Sayfa',
      'en': 'Home Page',
    },
  },
  // ForgotPassword
  {
    'cm13q2us': {
      'tr': 'Şifremi unuttum',
      'en': 'I forgot my password',
    },
    'dg7yzmtl': {
      'tr': 'Şifrenizi sıfırlamanız için size bir e-posta göndereceğiz.',
      'en': 'We will send you an email to reset your password.',
    },
    '4clpr9je': {
      'tr': 'E-posta',
      'en': 'Email',
    },
    'avd910a8': {
      'tr': '',
      'en': '',
    },
    'ngnxh2hm': {
      'tr': '',
      'en': '',
    },
    '6pzz9d4w': {
      'tr': 'E-posta gereklidir.',
      'en': 'Email is required.',
    },
    'sctqhtpn': {
      'tr': 'Lütfen açılır menüden bir seçenek seçin',
      'en': 'Please select an option from the drop-down menu',
    },
    '41xxuolz': {
      'tr': 'Şifre Sıfırlama',
      'en': 'Password Reset',
    },
    'qoxde1fc': {
      'tr': 'Ana Sayfa',
      'en': 'Home Page',
    },
  },
  // EditPreferences
  {
    'lu3dj396': {
      'tr': 'Diyeti güncellE',
      'en': 'Update diet',
    },
    '3czgpbc4': {
      'tr': 'Alerjileri güncelleyin',
      'en': 'Update on allergies',
    },
    '1d7qfql6': {
      'tr': 'Beğenmediklerinizi güncelleyin',
      'en': 'Update the ones you don\'t like',
    },
    'b1h6hi6e': {
      'tr': 'Güncelle',
      'en': 'Update',
    },
    'q6s7j463': {
      'tr': 'Ana Sayfa',
      'en': 'Home Page',
    },
  },
  // Onboarding
  {
    'pb7vd1dr': {
      'tr': 'Diyetinizi seçin',
      'en': 'Choose your diet',
    },
    'amodiz20': {
      'tr': 'Alerjiniz var mı?',
      'en': 'Do you have allergies?',
    },
    'm7inv3vo': {
      'tr': 'Peki ya sevmedikleriniz?',
      'en': 'What about the ones you don\'t like?',
    },
    'py1kjc9m': {
      'tr': 'Devam et',
      'en': 'Continue',
    },
    'qks3s4xq': {
      'tr': 'Ana Sayfa',
      'en': 'Home Page',
    },
  },
  // mealBottomSheet
  {
    'f07s7tjv': {
      'tr': 'Yemek detaylarını paylaşın',
      'en': 'Share meal details',
    },
    '90ogrt1b': {
      'tr': 'Geri bildirim gönderin',
      'en': 'Send feedback',
    },
  },
  // feedbackBottomSheet
  {
    '1yod7mp2': {
      'tr': 'Send Anonymous Feedback',
      'en': 'Send Anonymous Feedback',
    },
    '224uodu6': {
      'tr': 'Type something...',
      'en': 'Type of thing...',
    },
    'vdzn0jtn': {
      'tr': 'Feedback is required.',
      'en': 'Feedback is required.',
    },
    'zz097kd4': {
      'tr': 'Please choose an option from the dropdown',
      'en': 'Please choose an option from the dropdown',
    },
    'd2v8g821': {
      'tr': 'Send Feedback',
      'en': 'Send Feedback',
    },
  },
  // Miscellaneous
  {
    'r1nvfjgp': {
      'tr':
          'EsenMeal size yemek güncellemeleri ve diğer önemli mesajlar hakkında bildirimler göndermesi gerekir.',
      'en':
          'EsenMeal should send you notifications about meal updates and other important messages.',
    },
    'sgqqgscx': {
      'tr': '',
      'en': '',
    },
    'n92be62l': {
      'tr': '',
      'en': '',
    },
    '1ecm4fwf': {
      'tr': '',
      'en': '',
    },
    'qsk3eku9': {
      'tr': '',
      'en': '',
    },
    'q8rm2xva': {
      'tr': '',
      'en': '',
    },
    'uzlgqtgw': {
      'tr': '',
      'en': '',
    },
    's9jc94lf': {
      'tr': '',
      'en': '',
    },
    'ch4pfpm9': {
      'tr': '',
      'en': '',
    },
    'avz1nxja': {
      'tr': '',
      'en': '',
    },
    'hzbs5fqj': {
      'tr': '',
      'en': '',
    },
    'ru9noeet': {
      'tr': '',
      'en': '',
    },
    'ehkwxexf': {
      'tr': '',
      'en': '',
    },
    'qhs01vlu': {
      'tr': '',
      'en': '',
    },
    'alnuvjrk': {
      'tr': '',
      'en': '',
    },
    'g9d4iu6q': {
      'tr': '',
      'en': '',
    },
    'kr9uvcb1': {
      'tr': '',
      'en': '',
    },
    '0waui4s1': {
      'tr': '',
      'en': '',
    },
    'tkveptrz': {
      'tr': '',
      'en': '',
    },
    '598ndygu': {
      'tr': '',
      'en': '',
    },
    'c5ztd9b8': {
      'tr': '',
      'en': '',
    },
    'zkrbpdro': {
      'tr': '',
      'en': '',
    },
    'jd2pv8zc': {
      'tr': '',
      'en': '',
    },
    'oy9r5abg': {
      'tr': '',
      'en': '',
    },
    'hmzlukad': {
      'tr': '',
      'en': '',
    },
    'ymqqblgd': {
      'tr': '',
      'en': '',
    },
  },
].reduce((a, b) => a..addAll(b));
