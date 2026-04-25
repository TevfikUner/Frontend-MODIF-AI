import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'sistem_ve_dil.dart';
import 'ortak_widgetlar.dart';
import 'sayfalar_islem.dart';
import 'sekme_anasayfa.dart';
import 'sekme_kesfet.dart';
import 'sekme_magaza.dart';
import 'sekme_profil.dart';
import '../servisler/api_servisi.dart';

// --- 0. PROJE AÇILIŞ EKRANI (SPLASH SCREEN) ---
class AcilisSayfasi extends StatefulWidget {
  const AcilisSayfasi({super.key});

  @override
  State<AcilisSayfasi> createState() => _AcilisSayfasiState();
}

class _AcilisSayfasiState extends State<AcilisSayfasi> {
  @override
  void initState() {
    super.initState();
    // 3 saniye sonra Giriş Sayfasına yumuşak geçiş yap
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        yumusakGecisYap(context, const GirisSayfasi(), eskiSayfayiKapat: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1017),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // EFSANE LOGOMUZ (LOGO101)
            Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/LOGO101.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // YENİ İSMİMİZ
            const Text(
              'Modif AI',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                letterSpacing: 3.0,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'AI CAR TUNING STUDIO',
              style: TextStyle(color: Colors.blueAccent, fontSize: 12, letterSpacing: 2.0),
            ),
            const SizedBox(height: 60),
            // KÜÇÜK YÜKLENİYOR HALKASI
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(color: Color(0xFF257bf4), strokeWidth: 2),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 1. KULLANICI GİRİŞ SAYFASI ---
class GirisSayfasi extends StatefulWidget {
  const GirisSayfasi({super.key});

  @override
  State<GirisSayfasi> createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  final TextEditingController kullaniciAdiGirdisi = TextEditingController();
  final TextEditingController sifreGirdisi = TextEditingController();
  bool _isYukleniyor = false;

  // --- API BAĞLANTILI YENİ GİRİŞ MOTORU ---
  Future<void> _girisYap(BuildContext context) async {
    HapticFeedback.mediumImpact();

    // 1. Kutulara yazılan yazıları alıyoruz
    String email = kullaniciAdiGirdisi.text.trim();
    String sifre = sifreGirdisi.text.trim();

    // 2. Boş alan kontrolü (API'yi yormadan önce)
    if (email.isEmpty || sifre.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t('Lütfen tüm alanları doldurun!')), // Dil dosyasından da çekebilirsin
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // 3. Butonu "Yükleniyor" moduna sok
    setState(() { _isYukleniyor = true; });

    try {
      // 4. FastAPI'ye gidip şifreyi soruyoruz!
      String token = await ApiServisi().girisYap(email, sifre);

      // 5. EĞER BURAYA DÜŞERSE ŞİFRE DOĞRUDUR! Kapıları açıyoruz:
      if (mounted) {
        // Senin özel yumuşak geçiş fonksiyonun
        yumusakGecisYap(context, const AnaSayfa(), eskiSayfayiKapat: true);
      }
    } catch (hata) {
      // 6. ŞİFRE YANLIŞSA VEYA SUNUCU KAPALIYSA kırmızı uyarı çıkar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(hata.toString().replaceAll("Exception: ", "")),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      // 7. İşlem bitti (doğru veya yanlış), dönen çarkı durdur.
      if (mounted) {
        setState(() { _isYukleniyor = false; });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
        valueListenable: appLanguage,
        builder: (context, lang, child) {
          final Color anaRenk = const Color(0xFF257bf4);
          final Color koyuArkaplan = const Color(0xFF0A1017);
          final Color koyuYuzey = const Color(0xFF182434);

          return Scaffold(
            backgroundColor: koyuArkaplan,
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    'https://images.unsplash.com/photo-1542282088-fe8426682b8f?q=80&w=1000&auto=format&fit=crop',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, koyuArkaplan.withOpacity(0.8), koyuArkaplan],
                        stops: const [0.0, 0.6, 1.0],
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Icon(Icons.auto_awesome_mosaic, size: 64, color: Colors.white),
                          const SizedBox(height: 16),
                          Text(t('app_title'), textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                          const SizedBox(height: 8),
                          Text(t('welcome_title'), textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                          const SizedBox(height: 48),
                          TextField(
                            controller: kullaniciAdiGirdisi,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: koyuYuzey.withOpacity(0.8),
                                hintText: t('username'),
                                hintStyle: const TextStyle(color: Colors.grey),
                                prefixIcon: const Icon(Icons.person, color: Colors.grey),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: anaRenk, width: 2))
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: sifreGirdisi,
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: koyuYuzey.withOpacity(0.8),
                                hintText: t('password'),
                                hintStyle: const TextStyle(color: Colors.grey),
                                prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: anaRenk, width: 2))
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: _isYukleniyor ? null : () => _girisYap(context),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: anaRenk,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                elevation: 8
                            ),
                            child: _isYukleniyor
                                ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3))
                                : Text(t('login'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () {},
                            child: RichText(
                                text: TextSpan(
                                    text: t('no_account'),
                                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                                    children: [
                                      TextSpan(text: t('signup'), style: TextStyle(color: anaRenk, fontWeight: FontWeight.bold))
                                    ]
                                )
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}

// --- 2. ANA SAYFA (MENÜ YÖNETİCİSİ) ---
class AnaSayfa extends StatefulWidget {
  final int initialIndex;
  const AnaSayfa({super.key, this.initialIndex = 0});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  late int _seciliSayfaIndex;
  final Color anaRenk = const Color(0xFF257bf4);
  final Color koyuYuzey = const Color(0xFF182434);
  final Color koyuArkaplan = const Color(0xFF0A1017);

  final int _toplamAraba = 15;
  String _aktifProfilFoto = 'https://images.unsplash.com/photo-1603386329225-868f9b1ee6c9?q=80&w=300';

  final List<String> _hazirAvatarlar = [
    'https://images.unsplash.com/photo-1603386329225-868f9b1ee6c9?q=80&w=300',
    'https://images.unsplash.com/photo-1544829099-b9a0c07fad1a?q=80&w=300',
    'https://images.unsplash.com/photo-1614200179396-2bdb77ebf81b?q=80&w=300',
    'https://images.unsplash.com/photo-1503376713222-25ec13d8cbb8?q=80&w=300',
    'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?q=80&w=1000',
    'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?q=80&w=300',
    'https://images.unsplash.com/photo-1611821064430-0d4022414ce8?q=80&w=300',
    'https://images.unsplash.com/photo-1511919884226-fd3cad34687c?q=80&w=300',
    'https://images.unsplash.com/photo-1580273916550-e323be2ae537?q=80&w=300',
  ];

  @override
  void initState() {
    super.initState();
    _seciliSayfaIndex = widget.initialIndex;
  }

  Map<String, dynamic> _getRankDetails(int renders) {
    if (renders >= 50) return {'level': 5, 'name': t('grandmaster'), 'icon': '👑', 'color': const Color(0xFFFFD700), 'progress': 1.0, 'next': 50, 'min': 50};
    if (renders >= 30) return {'level': 4, 'name': t('senior'), 'icon': '🏅', 'color': Colors.orangeAccent, 'progress': (renders - 30) / 20.0, 'next': 50, 'min': 30};
    if (renders >= 20) return {'level': 3, 'name': t('master'), 'icon': '⚙️', 'color': Colors.blueGrey.shade300, 'progress': (renders - 20) / 10.0, 'next': 30, 'min': 20};
    if (renders >= 10) return {'level': 2, 'name': t('journeyman'), 'icon': '🛠️', 'color': Colors.green.shade400, 'progress': (renders - 10) / 10.0, 'next': 20, 'min': 10};
    return {'level': 1, 'name': t('apprentice'), 'icon': '🔧', 'color': Colors.brown.shade300, 'progress': renders / 10.0, 'next': 10, 'min': 0};
  }

  void _diliSec() {
    showModalBottomSheet(
        context: context,
        backgroundColor: koyuYuzey,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(padding: const EdgeInsets.all(16.0), child: Text(t('select_lang_title'), style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
                ListTile(leading: const Text('🇹🇷', style: TextStyle(fontSize: 24)), title: const Text('Türkçe', style: TextStyle(color: Colors.white)), onTap: () { HapticFeedback.selectionClick(); appLanguage.value = 'tr'; Navigator.pop(context); }),
                ListTile(leading: const Text('🇬🇧', style: TextStyle(fontSize: 24)), title: const Text('English', style: TextStyle(color: Colors.white)), onTap: () { HapticFeedback.selectionClick(); appLanguage.value = 'en'; Navigator.pop(context); }),
                const SizedBox(height: 20),
              ],
            ),
          );
        }
    );
  }

  void _showAvatarSelectionMenu() {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
        context: context,
        backgroundColor: koyuYuzey,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t('edit_profile_photo'), style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  ListTile(leading: const Text('📸', style: TextStyle(fontSize: 24)), title: Text(t('take_photo'), style: const TextStyle(color: Colors.white)), onTap: () { Navigator.pop(context); HapticFeedback.selectionClick(); ortakYakindaToastGoster(context); }),
                  ListTile(leading: const Text('🖼️', style: TextStyle(fontSize: 24)), title: Text(t('choose_gallery'), style: const TextStyle(color: Colors.white)), onTap: () { Navigator.pop(context); HapticFeedback.selectionClick(); ortakYakindaToastGoster(context); }),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 8),
                  Text(t('select_avatar'), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _hazirAvatarlar.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            HapticFeedback.selectionClick();
                            setState(() { _aktifProfilFoto = _hazirAvatarlar[index]; });
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 12), width: 70,
                            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: _aktifProfilFoto == _hazirAvatarlar[index] ? anaRenk : Colors.transparent, width: 3), image: DecorationImage(image: NetworkImage(_hazirAvatarlar[index]), fit: BoxFit.cover)),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        }
    );
  }

  void _showRanksMenu(int currentRenders) {
    HapticFeedback.lightImpact();
    var myRank = _getRankDetails(currentRenders);
    showModalBottomSheet(
        context: context,
        backgroundColor: koyuYuzey,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t('all_ranks'), style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  _rankListItem(5, t('grandmaster'), '👑', const Color(0xFFFFD700), '50+ ${t('renders_needed')}', myRank['level'] == 5),
                  _rankListItem(4, t('senior'), '🏅', Colors.orangeAccent, '30-49 ${t('renders_needed')}', myRank['level'] == 4),
                  _rankListItem(3, t('master'), '⚙️', Colors.blueGrey.shade300, '20-29 ${t('renders_needed')}', myRank['level'] == 3),
                  _rankListItem(2, t('journeyman'), '🛠️', Colors.green.shade400, '10-19 ${t('renders_needed')}', myRank['level'] == 2),
                  _rankListItem(1, t('apprentice'), '🔧', Colors.brown.shade300, '0-9 ${t('renders_needed')}', myRank['level'] == 1),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        }
    );
  }

  Widget _rankListItem(int level, String name, String icon, Color color, String requiredRenders, bool isCurrent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: isCurrent ? color.withOpacity(0.15) : Colors.transparent, border: Border.all(color: isCurrent ? color : Colors.white.withOpacity(0.05)), borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [Text(icon, style: const TextStyle(fontSize: 24)), const SizedBox(width: 16), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('$level. ${t('level')} $name', style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16)), const SizedBox(height: 4), Text(requiredRenders, style: const TextStyle(color: Colors.grey, fontSize: 12))])]),
          if (isCurrent) Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)), child: Text(t('current_rank'), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10)))
        ],
      ),
    );
  }

  Widget _sayfaIceriginiGetir() {
    switch (_seciliSayfaIndex) {
      case 0: return const SekmeAnaSayfa();
      case 1: return const SekmeKesfet();
      case 2: return const SekmeMagaza();
      case 3:
        return SekmeProfil(
          aktifProfilFoto: _aktifProfilFoto,
          toplamAraba: _toplamAraba,
          rankDetails: _getRankDetails(_toplamAraba),
          onAvatarTap: _showAvatarSelectionMenu,
          onRanksTap: () => _showRanksMenu(_toplamAraba),
          onTopUpTap: () { HapticFeedback.lightImpact(); setState(() { _seciliSayfaIndex = 2; }); },
          onLangTap: _diliSec,
        );
      default: return const SekmeAnaSayfa();
    }
  }

  Widget _floatingAppBarOlustur() {
    if (_seciliSayfaIndex == 0) return Positioned(top: 0, left: 0, right: 0, child: _ustBilgiOlustur());
    if (_seciliSayfaIndex == 3) return const Positioned(top: 0, left: 0, right: 0, child: GlassHeader(child: SafeArea(child: Text('Tevfik', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)))));
    return const SizedBox.shrink();
  }

  Widget _ustBilgiOlustur() {
    var rankDetails = _getRankDetails(_toplamAraba);
    return GlassHeader(
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(children: [Container(width: 48, height: 48, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: anaRenk.withOpacity(0.3), width: 2), image: DecorationImage(image: NetworkImage(_aktifProfilFoto), fit: BoxFit.cover))), Positioned(bottom: 0, right: 0, child: Container(width: 12, height: 12, decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.12), width: 2))))]),
                const SizedBox(width: 16),
                Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [Text(t('welcome_user'), style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)), const Text('Tevfik', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)), const SizedBox(height: 4), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: rankDetails['color'].withOpacity(0.1), border: Border.all(color: rankDetails['color']), borderRadius: BorderRadius.circular(12)), child: Row(mainAxisSize: MainAxisSize.min, children: [Text(rankDetails['icon'], style: const TextStyle(fontSize: 10)), const SizedBox(width: 4), Text('${rankDetails['level']}. ${t('level')} ${rankDetails['name']}', style: TextStyle(color: rankDetails['color'], fontWeight: FontWeight.bold, fontSize: 10))]))]),
              ],
            ),
            Container(decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), shape: BoxShape.circle), child: IconButton(icon: const Icon(Icons.notifications_none, color: Colors.white), onPressed: () { HapticFeedback.lightImpact(); }))
          ],
        ),
      ),
    );
  }

  Widget _altMenusuButonuOlustur(IconData ikon, String etiket, int index) {
    bool aktifMi = _seciliSayfaIndex == index;
    return MaterialButton(
      minWidth: 40,
      onPressed: () { if (!aktifMi) HapticFeedback.lightImpact(); setState(() { _seciliSayfaIndex = index; }); },
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(ikon, color: aktifMi ? anaRenk : Colors.grey, size: 24), Text(etiket, style: TextStyle(color: aktifMi ? anaRenk : Colors.grey, fontSize: 10))]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
        valueListenable: appLanguage,
        builder: (context, lang, child) {
          return PopScope(
            canPop: false,
            onPopInvoked: (cikisIstegi) async {
              if (cikisIstegi) return;
              HapticFeedback.lightImpact();
              final bool cikisYapilsinMi = await showDialog(context: context, builder: (context) => AlertDialog(backgroundColor: koyuYuzey, title: Text(t('exit_app'), style: const TextStyle(color: Colors.white)), content: Text(t('exit_sure'), style: const TextStyle(color: Colors.grey)), actions: [TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(t('no'), style: const TextStyle(color: Colors.grey))), ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: anaRenk), onPressed: () { HapticFeedback.mediumImpact(); SystemNavigator.pop(); }, child: Text(t('yes'), style: const TextStyle(color: Colors.white)))])) ?? false;
            },
            child: Scaffold(
              backgroundColor: koyuArkaplan,
              extendBodyBehindAppBar: true,
              body: Stack(children: [_sayfaIceriginiGetir(), _floatingAppBarOlustur()]),
              floatingActionButton: FloatingActionButton(onPressed: () {
                HapticFeedback.lightImpact();
                // Yumuşak geçiş motoruna bağlandı
                yumusakGecisYap(context, const ProjeTipiSecimSayfasi());
              }, backgroundColor: anaRenk, shape: const CircleBorder(), elevation: 8, child: const Icon(Icons.auto_fix_high, color: Colors.white, size: 28)),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: BottomAppBar(color: koyuYuzey, shape: const CircularNotchedRectangle(), notchMargin: 8.0, child: SizedBox(height: 60, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[_altMenusuButonuOlustur(Icons.home, t('home_tab'), 0), _altMenusuButonuOlustur(Icons.photo_library_outlined, t('discover_tab'), 1), const SizedBox(width: 40), _altMenusuButonuOlustur(Icons.diamond_outlined, t('store_tab'), 2), _altMenusuButonuOlustur(Icons.person_outline, t('profile_tab'), 3)]))),
            ),
          );
        }
    );
  }
}