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

  static List<String> languages() => ['en', 'tr'];

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
    String? enText = '',
    String? trText = '',
  }) =>
      [enText, trText][languageIndex] ?? '';

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
      'en': 'Esen',
      'tr': 'Yemek',
    },
    'xhhiwnms': {
      'en': 'Meal',
      'tr': 'Planlayıcı',
    },
    '31v5xhd9': {
      'en': 'Get Started',
      'tr': 'Başlayın',
    },
    '4wjpihri': {
      'en': 'Already a member?  ',
      'tr': 'Zaten üye misiniz?',
    },
    '8lsxlbi9': {
      'en': 'Sign In',
      'tr': 'Kayıt olmak',
    },
    '98afmct9': {
      'en': 'Home',
      'tr': 'Ev',
    },
  },
  // SignIn
  {
    's2vy008c': {
      'en': 'Sign In',
      'tr': 'Kayıt olmak',
    },
    'j3xrk9jj': {
      'en': 'Email',
      'tr': 'E-posta',
    },
    'enkcecei': {
      'en': 'tsmith@email.com',
      'tr': 'tsmith@e-posta.com',
    },
    '55ye3cf8': {
      'en': 'Password',
      'tr': 'Şifre',
    },
    'lhxezft7': {
      'en': 'password',
      'tr': 'şifre',
    },
    '2xnd42jl': {
      'en': 'Email is required.',
      'tr': 'E-posta gereklidir.',
    },
    'dj1rve5w': {
      'en': 'Please choose an option from the dropdown',
      'tr': 'Lütfen açılır menüden bir seçenek seçin',
    },
    '9tyhbmdw': {
      'en': 'Passsword is required.',
      'tr': 'Şifre gereklidir.',
    },
    '6fhsm0au': {
      'en': 'Please choose an option from the dropdown',
      'tr': 'Lütfen açılır menüden bir seçenek seçin',
    },
    '3lhh97lc': {
      'en': 'Sign In',
      'tr': 'Kayıt olmak',
    },
    'ikxbufr4': {
      'en': 'I don\'t remember my password',
      'tr': 'Şifremi hatırlamıyorum',
    },
    '56rqthk3': {
      'en': 'Don\'t have an account yet?',
      'tr': 'Henüz bir hesabınız yok mu?',
    },
    'm18p91z9': {
      'en': 'Create Account',
      'tr': 'Hesap oluşturmak',
    },
    'nnh5sv0f': {
      'en': 'Home',
      'tr': 'Ev',
    },
  },
  // Onboarding_Slideshow
  {
    'qaffj8g9': {
      'en': 'Local, Customized\nMeal Planning',
      'tr': 'Yerel, Özelleştirilmiş\nYemek Planlaması',
    },
    'dvq8k6lg': {
      'en':
          'Create your own customized meal plan from our selection of healthy meal options.',
      'tr':
          'Sağlıklı yemek seçeneklerimizden kendi kişiselleştirilmiş yemek planınızı oluşturun.',
    },
    'lt12kdpa': {
      'en': 'Delicious and Nutritious Fresh Meals',
      'tr': 'Lezzetli ve Besleyici Taze Yemekler',
    },
    'afqq2gek': {
      'en':
          'Enjoy healthy and delicious meals delivered to your doorstep, prepared with fresh, high-quality ingredients.',
      'tr':
          'Taze ve kaliteli malzemelerle hazırlanan sağlıklı ve lezzetli yemeklerin tadını kapınıza kadar getirin.',
    },
    'tmze9jvy': {
      'en': 'Gourmet Quality,\nHassle-Free',
      'tr': 'Gurme Kalitesi,\nZahmetsiz',
    },
    '9yy6vzec': {
      'en':
          'Savor chef-inspired meals without the hassle of cooking or cleaning up, with our gourmet meal delivery service.',
      'tr':
          'Gurme yemek dağıtım hizmetimizle, yemek pişirme veya temizlik zahmetine girmeden şeflerin elinden çıkmış yemeklerin tadını çıkarın.',
    },
    'ad9tk3z8': {
      'en': 'Continue',
      'tr': 'Devam etmek',
    },
    '6drb072m': {
      'en': 'Home',
      'tr': 'Ev',
    },
  },
  // Onboarding_CreateAccount
  {
    'd9kxnl4m': {
      'en': 'Create an account',
      'tr': 'Bir hesap oluşturun',
    },
    'dbt4iqx9': {
      'en': 'Full Name',
      'tr': 'Ad Soyad',
    },
    '23mqq1h9': {
      'en': 'Email',
      'tr': 'E-posta',
    },
    '4hfqujz1': {
      'en': 'Password',
      'tr': 'Şifre',
    },
    'm4lppm7g': {
      'en': 'Full name is required.',
      'tr': 'Tam adınız zorunludur.',
    },
    'lk9f96e1': {
      'en': 'Please choose an option from the dropdown',
      'tr': 'Lütfen açılır menüden bir seçenek seçin',
    },
    'iyd781wa': {
      'en': 'Email is required.',
      'tr': 'E-posta gereklidir.',
    },
    '3b93m7va': {
      'en': 'Please choose an option from the dropdown',
      'tr': 'Lütfen açılır menüden bir seçenek seçin',
    },
    'dtyrqbhc': {
      'en': 'Password is required.',
      'tr': 'Şifre gereklidir.',
    },
    '1woik12o': {
      'en': 'Please choose an option from the dropdown',
      'tr': 'Lütfen açılır menüden bir seçenek seçin',
    },
    'dq9psavc': {
      'en': 'Create Account',
      'tr': 'Hesap oluşturmak',
    },
    '6ongsqy2': {
      'en': 'By clicking \"Create Account,\" you agree to MealPlanner\'s ',
      'tr': '\"Hesap Oluştur\"a tıklayarak MealPlanner\'ın',
    },
    '2pblnw75': {
      'en': 'Terms of Use',
      'tr': 'Kullanım Şartları',
    },
    'bhixtav8': {
      'en': '.',
      'tr': '.',
    },
    'v86fzc5i': {
      'en': 'Home',
      'tr': 'Ev',
    },
  },
  // Dashboard
  {
    'c4t4o3xf': {
      'en': 'This week\'s meals',
      'tr': 'Bu haftanın yemekleri',
    },
    'ypkv73np': {
      'en': 'Made to order with fresh ingredients each week.',
      'tr': 'Her hafta taze malzemelerle sipariş üzerine hazırlanıyor.',
    },
    '8hmmat3d': {
      'en': 'Meals',
      'tr': 'Yemekler',
    },
  },
  // MealDetails
  {
    'p7j8y38u': {
      'en': 'Ingredients',
      'tr': 'İçindekiler',
    },
    'pobcme6j': {
      'en': 'Allergens',
      'tr': 'Alerjenler',
    },
    'mjqhhvq9': {
      'en': 'Home',
      'tr': 'Ev',
    },
  },
  // Profile
  {
    'c3kv9o0d': {
      'en': 'Thank you for supporting us!',
      'tr': 'Desteğiniz için teşekkür ederiz!',
    },
    'kgh51cuf': {
      'en':
          'As a local business, we thank you for supporting us and hope you enjoy.',
      'tr':
          'Yerel bir işletme olarak bize verdiğiniz destekten dolayı teşekkür eder, keyifli vakit geçirmenizi dileriz.',
    },
    'ircptpp9': {
      'en': 'Edit Profile',
      'tr': 'Profili Düzenle',
    },
    '57x88ouh': {
      'en': 'Eating Preferences',
      'tr': 'Yeme Tercihleri',
    },
    '0ncruabu': {
      'en': 'About Us',
      'tr': 'Hakkımızda',
    },
    'lij60voe': {
      'en': 'Support Center',
      'tr': 'Destek Merkezi',
    },
    '46uk37z7': {
      'en': 'Contact Us',
      'tr': 'Bize Ulaşın',
    },
    'bwl07a9y': {
      'en': 'Share MealPlanner App',
      'tr': 'MealPlanner Uygulamasını Paylaş',
    },
    'tciosm8t': {
      'en': 'Review in the App Store',
      'tr': 'App Store\'da inceleme',
    },
    'gv8a91o1': {
      'en': 'Log out',
      'tr': 'Çıkış yap',
    },
    'upjxgphb': {
      'en': 'Profile',
      'tr': 'Profil',
    },
  },
  // EditProfile
  {
    'h5o4ato9': {
      'en': 'Edit Profile',
      'tr': 'Profili Düzenle',
    },
    '3o2812gv': {
      'en': 'Full Name',
      'tr': 'Ad Soyad',
    },
    'd3n4xbcd': {
      'en': '',
      'tr': '',
    },
    'ect2f8wa': {
      'en': '',
      'tr': '',
    },
    'hr2y9oa3': {
      'en': 'Reset Password',
      'tr': 'Şifreyi Sıfırla',
    },
    'q3h3nqv8': {
      'en': 'Delete Account',
      'tr': 'Hesabı Sil',
    },
    'w5k5wmw2': {
      'en': 'Home',
      'tr': 'Ev',
    },
  },
  // AboutUs
  {
    'bnkxu3y2': {
      'en': 'About Us',
      'tr': 'Hakkımızda',
    },
    'ldsk4k8r': {
      'en': 'Your Chefs',
      'tr': 'Şefleriniz',
    },
    '05h4mca9': {
      'en': 'Home',
      'tr': 'Ev',
    },
  },
  // EatingPreferences
  {
    '8qqy010q': {
      'en': 'Eating Preferences',
      'tr': 'Yeme Tercihleri',
    },
    'ff5kww42': {
      'en': 'Diet',
      'tr': 'Diyet',
    },
    'rr9egqgr': {
      'en': 'Allergens',
      'tr': 'Alerjenler',
    },
    'eqsljcfa': {
      'en': 'Disliked Ingredients',
      'tr': 'Beğenilmeyen Malzemeler',
    },
    'rlvb21id': {
      'en': 'Home',
      'tr': 'Ev',
    },
  },
  // SupportCenter
  {
    'j0taqs22': {
      'en': 'Support Center',
      'tr': 'Destek Merkezi',
    },
    'l2n580ow': {
      'en': 'Home',
      'tr': 'Ev',
    },
  },
  // ForgotPassword
  {
    'cm13q2us': {
      'en': 'Forgot password',
      'tr': 'Parolanızı mı unuttunuz',
    },
    'dg7yzmtl': {
      'en': 'We\'ll send you an email to reset your password.',
      'tr': 'Şifrenizi sıfırlamanız için size bir e-posta göndereceğiz.',
    },
    '4clpr9je': {
      'en': 'Email',
      'tr': 'E-posta',
    },
    'avd910a8': {
      'en': '',
      'tr': '',
    },
    'ngnxh2hm': {
      'en': '',
      'tr': '',
    },
    '6pzz9d4w': {
      'en': 'Email is required.',
      'tr': 'E-posta gereklidir.',
    },
    'sctqhtpn': {
      'en': 'Please choose an option from the dropdown',
      'tr': 'Lütfen açılır menüden bir seçenek seçin',
    },
    '41xxuolz': {
      'en': 'Reset Password',
      'tr': 'Şifreyi Sıfırla',
    },
    'qoxde1fc': {
      'en': 'Home',
      'tr': 'Ev',
    },
  },
  // EditPreferences
  {
    'lu3dj396': {
      'en': 'Update diet',
      'tr': 'Diyeti güncelle',
    },
    '3czgpbc4': {
      'en': 'Update allergies',
      'tr': 'Alerjileri güncelle',
    },
    '1d7qfql6': {
      'en': 'Update dislikes',
      'tr': 'Beğenilmeyenleri güncelle',
    },
    'b1h6hi6e': {
      'en': 'Update',
      'tr': 'Güncelleme',
    },
    'q6s7j463': {
      'en': 'Home',
      'tr': 'Ev',
    },
  },
  // Onboarding
  {
    'pb7vd1dr': {
      'en': 'Select your diet',
      'tr': 'Diyetinizi seçin',
    },
    'amodiz20': {
      'en': 'Any allergies?',
      'tr': 'Herhangi bir alerjiniz var mı?',
    },
    'm7inv3vo': {
      'en': 'How about dislikes?',
      'tr': 'Peki ya beğenmeme durumları?',
    },
    'py1kjc9m': {
      'en': 'Continue',
      'tr': 'Devam etmek',
    },
    'qks3s4xq': {
      'en': 'Home',
      'tr': 'Ev',
    },
  },
  // mealBottomSheet
  {
    'f07s7tjv': {
      'en': 'Share meal details',
      'tr': 'Yemek ayrıntılarını paylaş',
    },
    '90ogrt1b': {
      'en': 'Send feedback',
      'tr': 'Geri bildirim gönder',
    },
  },
  // feedbackBottomSheet
  {
    '1yod7mp2': {
      'en': 'Send Anonymous Feedback',
      'tr': 'Anonim Geri Bildirim Gönder',
    },
    '224uodu6': {
      'en': 'Type something...',
      'tr': 'Bir şey yaz...',
    },
    'vdzn0jtn': {
      'en': 'Feedback is required.',
      'tr': 'Geri bildirim gerekiyor.',
    },
    'zz097kd4': {
      'en': 'Please choose an option from the dropdown',
      'tr': 'Lütfen açılır menüden bir seçenek seçin',
    },
    'd2v8g821': {
      'en': 'Send Feedback',
      'tr': 'Geri bildirim gönder',
    },
  },
  // Miscellaneous
  {
    'r1nvfjgp': {
      'en':
          'MealPlanner needs to send you notifications about meal updates and other important messages.',
      'tr':
          'MealPlanner\'ın size yemek güncellemeleri ve diğer önemli mesajlar hakkında bildirimler göndermesi gerekiyor.',
    },
    'sgqqgscx': {
      'en': '',
      'tr': '',
    },
    'n92be62l': {
      'en': '',
      'tr': '',
    },
    '1ecm4fwf': {
      'en': '',
      'tr': '',
    },
    'qsk3eku9': {
      'en': '',
      'tr': '',
    },
    'q8rm2xva': {
      'en': '',
      'tr': '',
    },
    'uzlgqtgw': {
      'en': '',
      'tr': '',
    },
    's9jc94lf': {
      'en': '',
      'tr': '',
    },
    'ch4pfpm9': {
      'en': '',
      'tr': '',
    },
    'avz1nxja': {
      'en': '',
      'tr': '',
    },
    'hzbs5fqj': {
      'en': '',
      'tr': '',
    },
    'ru9noeet': {
      'en': '',
      'tr': '',
    },
    'ehkwxexf': {
      'en': '',
      'tr': '',
    },
    'qhs01vlu': {
      'en': '',
      'tr': '',
    },
    'alnuvjrk': {
      'en': '',
      'tr': '',
    },
    'g9d4iu6q': {
      'en': '',
      'tr': '',
    },
    'kr9uvcb1': {
      'en': '',
      'tr': '',
    },
    '0waui4s1': {
      'en': '',
      'tr': '',
    },
    'tkveptrz': {
      'en': '',
      'tr': '',
    },
    '598ndygu': {
      'en': '',
      'tr': '',
    },
    'c5ztd9b8': {
      'en': '',
      'tr': '',
    },
    'zkrbpdro': {
      'en': '',
      'tr': '',
    },
    'jd2pv8zc': {
      'en': '',
      'tr': '',
    },
    'oy9r5abg': {
      'en': '',
      'tr': '',
    },
    'hmzlukad': {
      'en': '',
      'tr': '',
    },
    'ymqqblgd': {
      'en': '',
      'tr': '',
    },
  },
].reduce((a, b) => a..addAll(b));
