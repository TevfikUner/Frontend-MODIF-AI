import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'sistem_ve_dil.dart';
import 'ortak_widgetlar.dart';
import 'sayfalar_ana.dart'; // Ana sayfa yönlendirmeleri için
import 'oyun_sayfasi.dart'; // Oyun sayfasına yönlendirmek için ekledik

// --- PROJE TİPİ SEÇİMİ ---
class ProjeTipiSecimSayfasi extends StatelessWidget {
  const ProjeTipiSecimSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
        valueListenable: appLanguage,
        builder: (context, lang, child) {
          final Color koyuArkaplan = const Color(0xFF0A1017);

          return Scaffold(
            backgroundColor: koyuArkaplan,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
              title: Text(t('select_project_type'), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () { HapticFeedback.mediumImpact(); Navigator.push(context, MaterialPageRoute(builder: (context) => const FotografYuklemeSayfasi2D())); },
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(image: NetworkImage('https://images.unsplash.com/photo-1552519507-da3b142c6e3d?q=80&w=1000'), fit: BoxFit.cover),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10, spreadRadius: 2)],
                      ),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withOpacity(0.8)])),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(Icons.image, color: Colors.white, size: 48),
                              const SizedBox(height: 12),
                              Text(t('2d_mod'), style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              Text(t('2d_desc'), textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () { HapticFeedback.mediumImpact(); Navigator.push(context, MaterialPageRoute(builder: (context) => const FotografYuklemeSayfasi())); },
                    child: Container(
                      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(image: NetworkImage('https://images.unsplash.com/photo-1617788138017-80ad40651399?q=80&w=1000'), fit: BoxFit.cover),
                        boxShadow: [BoxShadow(color: Colors.blueAccent.withOpacity(0.3), blurRadius: 10, spreadRadius: 2)],
                      ),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.blue.shade900.withOpacity(0.9)])),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(Icons.threed_rotation, color: Colors.white, size: 48),
                              const SizedBox(height: 12),
                              Text(t('3d_mod'), style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              Text(t('3d_desc'), textAlign: TextAlign.center, style: const TextStyle(color: Colors.blueAccent, fontSize: 14)),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
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

// --- FOTOĞRAF YÜKLEME (3D) ---
class FotografYuklemeSayfasi extends StatelessWidget {
  const FotografYuklemeSayfasi({super.key});

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
            appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)), title: Text(t('upload_photo'), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)), centerTitle: true),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: koyuYuzey, shape: BoxShape.circle), child: Icon(Icons.threed_rotation, color: anaRenk, size: 32)),
                    const SizedBox(height: 16),
                    Text(t('turn_3d'), textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, height: 1.2)),
                    const SizedBox(height: 12),
                    Text(t('upload_desc'), textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(height: 32),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.9,
                        children: [
                          _fotografKartiOlustur(context, t('front'), Icons.directions_car, koyuYuzey, anaRenk, false, ''),
                          _fotografKartiOlustur(context, t('right_side'), Icons.directions_car, koyuYuzey, anaRenk, false, ''),
                          _fotografKartiOlustur(context, t('left_side'), Icons.directions_car, koyuYuzey, anaRenk, true, 'https://images.unsplash.com/photo-1617788138017-80ad40651399?q=80&w=1000&auto=format&fit=crop'),
                          _fotografKartiOlustur(context, t('rear'), Icons.directions_car, koyuYuzey, anaRenk, false, ''),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () { HapticFeedback.lightImpact(); Navigator.push(context, MaterialPageRoute(builder: (context) => const ModifiyeSecimSayfasi())); },
                            icon: const Icon(Icons.camera_alt, color: Colors.white),
                            label: Text(t('continue_btn'), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(backgroundColor: anaRenk, minimumSize: const Size(double.infinity, 56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  Widget _fotografKartiOlustur(BuildContext context, String baslik, IconData ikon, Color arkaplanRengi, Color anaRenk, bool yuklendiMi, String resimUrl) {
    return InkWell(
      onTap: () => ortadanSecimDialoguGoster(context),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(color: arkaplanRengi, borderRadius: BorderRadius.circular(16), border: Border.all(color: yuklendiMi ? anaRenk : Colors.white.withOpacity(0.05), width: 1.5)),
        child: Stack(
          children: [
            if (yuklendiMi) ClipRRect(borderRadius: BorderRadius.circular(14), child: Image.network(resimUrl, width: double.infinity, height: double.infinity, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Container(color: Colors.black26, child: const Icon(Icons.image_not_supported, color: Colors.grey)))),
            if (yuklendiMi) Container(decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), borderRadius: BorderRadius.circular(14))),
            Positioned(top: 12, right: 12, child: Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: yuklendiMi ? anaRenk : Colors.white.withOpacity(0.05), shape: BoxShape.circle), child: Icon(yuklendiMi ? Icons.check : Icons.add, color: yuklendiMi ? Colors.white : Colors.grey, size: 16))),
            if (!yuklendiMi) Center(child: Icon(ikon, color: Colors.grey.withOpacity(0.3), size: 48)),
            Positioned(
              bottom: 12, left: yuklendiMi ? 12 : 0, right: yuklendiMi ? null : 0,
              child: Container(
                alignment: yuklendiMi ? Alignment.centerLeft : Alignment.center,
                padding: yuklendiMi ? const EdgeInsets.symmetric(horizontal: 8, vertical: 4) : EdgeInsets.zero,
                decoration: BoxDecoration(color: yuklendiMi ? Colors.black.withOpacity(0.8) : Colors.transparent, borderRadius: BorderRadius.circular(8)),
                child: Text(baslik, style: TextStyle(color: yuklendiMi ? Colors.white : Colors.grey, fontWeight: FontWeight.bold, fontSize: 14)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// --- FOTOĞRAF YÜKLEME (2D) ---
class FotografYuklemeSayfasi2D extends StatelessWidget {
  const FotografYuklemeSayfasi2D({super.key});

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
            appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)), title: Text(t('upload_photo'), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)), centerTitle: true),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: koyuYuzey, shape: BoxShape.circle), child: Icon(Icons.image, color: anaRenk, size: 32)),
                    const SizedBox(height: 16),
                    Text(t('turn_2d'), textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, height: 1.2)),
                    const SizedBox(height: 12),
                    Text(t('upload_desc_2d'), textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(height: 40),

                    Expanded(
                      child: InkWell(
                        onTap: () => ortadanSecimDialoguGoster(context),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: koyuYuzey,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white.withOpacity(0.05), width: 1.5, style: BorderStyle.solid),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), shape: BoxShape.circle),
                                child: const Icon(Icons.add_a_photo, color: Colors.grey, size: 48),
                              ),
                              const SizedBox(height: 16),
                              Text(t('single_photo'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                              const SizedBox(height: 8),
                              const Text('Üzerine Tıklayarak Yükle', style: TextStyle(color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () { HapticFeedback.lightImpact(); Navigator.push(context, MaterialPageRoute(builder: (context) => const ModifiyeSecimSayfasi())); },
                            icon: const Icon(Icons.camera_alt, color: Colors.white),
                            label: Text(t('continue_btn'), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(backgroundColor: anaRenk, minimumSize: const Size(double.infinity, 56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}

// --- MODİFİYE STÜDYOSU ---
class ModifiyeSecimSayfasi extends StatefulWidget {
  const ModifiyeSecimSayfasi({super.key});

  @override
  State<ModifiyeSecimSayfasi> createState() => _ModifiyeSecimSayfasiState();
}

class _ModifiyeSecimSayfasiState extends State<ModifiyeSecimSayfasi> {
  int _seciliRenkIndex = 0;
  int _seciliJantIndex = 0;
  bool _isYukleniyor = false;

  final List<Color> _renkPaleti = [
    Colors.red, Colors.redAccent, Colors.pinkAccent,
    Colors.blue, Colors.lightBlueAccent, Colors.cyanAccent,
    Colors.green, Colors.tealAccent, Colors.yellowAccent,
    Colors.orange, Colors.deepOrangeAccent, Colors.brown,
    Colors.black, Colors.grey, Colors.white,
    const Color(0xFFFFD700),
    const Color(0xFFC0C0C0),
    const Color(0xFFE5E4E2),
  ];

  final List<String> _jantResimleri = [
    'https://images.unsplash.com/photo-1579308107931-e421e42c262e?q=80&w=200',
    'https://images.unsplash.com/photo-1599819811279-d2924348f467?q=80&w=200',
    'https://images.unsplash.com/photo-1587350859733-146313b30263?q=80&w=200',
    'https://images.unsplash.com/photo-1601053163351-b8f4c0bf4a13?q=80&w=200',
    'https://images.unsplash.com/photo-1600861195091-690c92f1d2cc?q=80&w=200',
    'https://images.unsplash.com/photo-1607603731681-4fe6506a7469?q=80&w=200',
    'https://images.unsplash.com/photo-1600862086392-4943f6ff3982?q=80&w=200',
    'https://images.unsplash.com/photo-1611181165207-6c84b42b6a90?q=80&w=200',
    'https://images.unsplash.com/photo-1603512214695-0ed07675f917?q=80&w=200',
    'https://images.unsplash.com/photo-1616012480717-fd9867059ca0?q=80&w=200',
  ];

  void _uretimiBaslat(BuildContext context) {
    HapticFeedback.mediumImpact();
    setState(() { _isYukleniyor = true; });
    Future.delayed(const Duration(milliseconds: 1500), () {
      if(mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RenderSayfasi()));
      }
    });
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
            extendBodyBehindAppBar: true,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: GlassHeader(
                child: SafeArea(
                  bottom: false,
                  child: Row(
                    children: [
                      IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () { HapticFeedback.lightImpact(); Navigator.pop(context); }),
                      Expanded(child: Text(t('mod_selection'), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(left: 24, right: 24, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 220, width: double.infinity,
                            decoration: BoxDecoration(
                              color: koyuYuzey,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: Colors.white.withOpacity(0.08)),
                              gradient: RadialGradient(
                                center: Alignment.center,
                                radius: 0.8,
                                colors: [
                                  Colors.white.withOpacity(0.12),
                                  Colors.transparent,
                                ],
                                stops: const [0.0, 1.0],
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Opacity(
                                      opacity: 0.03,
                                      child: CustomPaint(
                                        painter: GridPainter(),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.directions_car, size: 80, color: Colors.grey),
                                        const SizedBox(height: 10),
                                        Text(t('preview_area'), style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),

                          Text(t('color_palette'), style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _renkPaleti.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, crossAxisSpacing: 10, mainAxisSpacing: 10),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  HapticFeedback.selectionClick();
                                  setState(() => _seciliRenkIndex = index);
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  decoration: BoxDecoration(
                                    color: _renkPaleti[index], shape: BoxShape.circle,
                                    border: Border.all(color: _seciliRenkIndex == index ? Colors.white : Colors.transparent, width: 3),
                                    boxShadow: _seciliRenkIndex == index ? [BoxShadow(color: _renkPaleti[index].withOpacity(0.6), blurRadius: 12, spreadRadius: 2)] : [],
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 32),

                          Text(t('wheel_options'), style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _jantResimleri.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    HapticFeedback.selectionClick();
                                    setState(() => _seciliJantIndex = index);
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    margin: const EdgeInsets.only(right: 12),
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: koyuYuzey,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: _seciliJantIndex == index ? anaRenk : Colors.white.withOpacity(0.05), width: 2.5),
                                      boxShadow: _seciliJantIndex == index ? [BoxShadow(color: anaRenk.withOpacity(0.3), blurRadius: 15, spreadRadius: 1)] : [],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(14),
                                      child: Stack(
                                        children: [
                                          Image.network(
                                            _jantResimleri[index],
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                            errorBuilder: (context, error, stackTrace) => Container(color: Colors.black26, child: const Icon(Icons.tire_repair, color: Colors.grey)),
                                          ),
                                          Positioned(
                                            bottom: 4, right: 4,
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                              decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(8)),
                                              child: Text('${t('wheel_name')} ${index + 1}', style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(color: koyuYuzey, borderRadius: const BorderRadius.vertical(top: Radius.circular(28)), border: const Border(top: BorderSide(color: Colors.white10, width: 0.5))),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: _isYukleniyor ? null : () => _uretimiBaslat(context),
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [Color(0xFF257bf4), Color(0xFF8A2387)]),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [BoxShadow(color: const Color(0xFF257bf4).withOpacity(0.5), blurRadius: 15, spreadRadius: 2)],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _isYukleniyor
                                  ? [const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3))]
                                  : [
                                const Icon(Icons.auto_fix_high, color: Colors.white, size: 24),
                                const SizedBox(width: 12),
                                Text(t('start_prod'), style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), borderRadius: BorderRadius.circular(12)),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.diamond, color: Colors.cyanAccent, size: 16),
                                      const SizedBox(width: 4),
                                      Text('50', style: premiumNumberStyle.copyWith(color: Colors.white)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const AnaSayfa(initialIndex: 2)), (Route<dynamic> route) => false);
                          },
                          child: Text(t('not_enough_credit'), style: const TextStyle(color: Colors.grey, fontSize: 12, decoration: TextDecoration.underline)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}

// Izgara çizicisi (Arka plandaki şık çizgiler)
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 0.5;

    double step = 20.0;

    for (double i = 0; i < size.width; i += step) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += step) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}