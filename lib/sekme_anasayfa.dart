import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'sistem_ve_dil.dart';
import 'ortak_widgetlar.dart';
import 'sayfalar_islem.dart'; // Proje seçim ekranı için
// --- YENİ EKLENEN ÇEVİRMEN VE POSTACIMIZ ---
import '../modeller/araba_model.dart';
import '../servisler/api_servisi.dart';

class SekmeAnaSayfa extends StatefulWidget {
  const SekmeAnaSayfa({super.key});

  @override
  State<SekmeAnaSayfa> createState() => _SekmeAnaSayfaState();
}

class _SekmeAnaSayfaState extends State<SekmeAnaSayfa> {
  bool _taslakGosterilsin = true;
  final Color anaRenk = const Color(0xFF257bf4);
  final Color koyuYuzey = const Color(0xFF182434);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 110),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _yeniProjeKartiOlustur(context),
          _istatistikleriOlustur(),
          _garajKismiOlustur(context),
          _taslaklarKismiOlustur(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _yeniProjeKartiOlustur(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Container(
        height: 280,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [anaRenk.withOpacity(0.9), Colors.blue.shade900], begin: Alignment.topLeft, end: Alignment.bottomRight),
          boxShadow: [BoxShadow(color: anaRenk.withOpacity(0.3), blurRadius: 20, spreadRadius: 2)],
        ),
        child: Stack(
          children: [
            Opacity(opacity: 0.3, child: ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.network('https://images.unsplash.com/photo-1617788138017-80ad40651399?q=80&w=1000&auto=format&fit=crop', width: double.infinity, height: double.infinity, fit: BoxFit.cover))),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                    child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.auto_awesome, color: Colors.white, size: 14), SizedBox(width: 4), Text('AI Studio', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))]),
                  ),
                  const SizedBox(height: 8),
                  Text(t('design_dream'), style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, height: 1.1)),
                  const SizedBox(height: 8),
                  Text(t('ai_step'), style: const TextStyle(color: Colors.blueAccent, fontSize: 12)),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProjeTipiSecimSayfasi()));
                    },
                    icon: Icon(Icons.add_circle, color: anaRenk),
                    label: Text(t('new_project'), style: TextStyle(color: anaRenk, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white, minimumSize: const Size(double.infinity, 48), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _istatistikleriOlustur() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          children: [
            _istatistikKartiOlustur(Icons.garage, t('total'), '12', t('cars_in_garage'), anaRenk),
            const SizedBox(width: 12),
            _istatistikKartiOlustur(Icons.view_in_ar, 'Render', '45', t('created'), Colors.purpleAccent),
            const SizedBox(width: 12),
            _istatistikKartiOlustur(Icons.savings, t('credit'), '850', t('available'), Colors.greenAccent),
          ],
        ),
      ),
    );
  }

  Widget _istatistikKartiOlustur(IconData ikon, String baslik, String deger, String altBaslik, Color renk) {
    return Container(
      width: 130, padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: koyuYuzey, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withOpacity(0.05))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [Icon(ikon, color: renk, size: 18), const SizedBox(width: 4), Text(baslik, style: TextStyle(color: renk, fontSize: 12, fontWeight: FontWeight.bold))]),
          const SizedBox(height: 8),
          Text(deger, style: premiumNumberStyle.copyWith(color: Colors.white, fontSize: 24)),
          Text(altBaslik, style: const TextStyle(color: Colors.grey, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _garajKismiOlustur(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [Container(width: 4, height: 20, color: anaRenk), const SizedBox(width: 8), Text(t('my_garage'), style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))]),
              TextButton(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const TumGarajSayfasi()));
                },
                child: Row(children: [Text(t('see_all'), style: TextStyle(color: anaRenk, fontSize: 12)), Icon(Icons.arrow_forward_ios, color: anaRenk, size: 12)]),
              )
            ],
          ),
          const SizedBox(height: 8),
          // --- BURASI DİNAMİK OLDU (Veritabanından 1 araba çekecek) ---
          FutureBuilder<List<Araba>>(
            future: ApiServisi().garajiGetir(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator()));
              } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                return Container(
                  width: double.infinity, padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: koyuYuzey, borderRadius: BorderRadius.circular(16)),
                  child: const Text("Garajın şu an boş veya bağlantı yok.", style: TextStyle(color: Colors.grey), textAlign: TextAlign.center),
                );
              }

              // Listeden en son eklenen arabayı (ilk arabayı) göster
              final araba = snapshot.data!.first;
              // Eğer veritabanından resim gelmezse boş kalmasın diye hazır bir resim koyuyoruz
              final resimUrl = araba.imageUrl.isNotEmpty ? araba.imageUrl : 'https://images.unsplash.com/photo-1603386329225-868f9b1ee6c9?q=80&w=1000';

              return ArabaKartiOlusturucu.olustur('${araba.marka} ${araba.model}', 'AI Custom Render', resimUrl, t('hours_ago'), anaRenk, koyuYuzey);
            },
          ),
        ],
      ),
    );
  }

  Widget _taslaklarKismiOlustur() {
    if (!_taslakGosterilsin) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        children: [
          Row(children: [Container(width: 4, height: 20, color: Colors.orange), const SizedBox(width: 8), Text(t('drafts'), style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))]),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: koyuYuzey, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.orange.withOpacity(0.5), style: BorderStyle.solid)),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.orange.withOpacity(0.1), shape: BoxShape.circle), child: const Icon(Icons.design_services, color: Colors.orange)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Nissan 350Z - Drift Spec', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                          const SizedBox(height: 4),
                          Text(t('unfinished_wheel'), style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        setState(() { _taslakGosterilsin = false; });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t('draft_deleted'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), backgroundColor: Colors.redAccent, behavior: SnackBarBehavior.floating));
                      },
                      icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 18),
                      label: Text(t('delete_draft'), style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                    ),
                    ElevatedButton(
                      onPressed: () { HapticFeedback.lightImpact(); Navigator.push(context, MaterialPageRoute(builder: (context) => const ModifiyeSecimSayfasi())); },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                      child: Text(t('continue_btn'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// --- TÜM GARAJ SAYFASI (BURASI DA DİNAMİK OLDU) ---
class TumGarajSayfasi extends StatelessWidget {
  const TumGarajSayfasi({super.key});

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
            body: Stack(
              children: [
                Positioned.fill(child: Image.network('https://images.unsplash.com/photo-1553440569-bcc63803a83d?q=80&w=1000&auto=format&fit=crop', fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Container(color: koyuArkaplan))),
                Positioned.fill(child: Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [koyuArkaplan.withOpacity(0.6), koyuArkaplan.withOpacity(0.95), koyuArkaplan])))),
                SafeArea(
                  child: Column(
                    children: [
                      AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)), title: Text(t('all_my_cars'), style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), centerTitle: true),
                      Expanded(
                        child: FutureBuilder<List<Araba>>(
                          future: ApiServisi().garajiGetir(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator(color: anaRenk));
                            } else if (snapshot.hasError) {
                              return Center(child: Text("Hata: ${snapshot.error}", style: const TextStyle(color: Colors.redAccent)));
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Center(child: Text("Garajın şu an tamamen boş.", style: TextStyle(color: Colors.white, fontSize: 18)));
                            }

                            final arabalar = snapshot.data!;

                            return ListView.builder(
                              padding: const EdgeInsets.all(24.0),
                              itemCount: arabalar.length,
                              itemBuilder: (context, index) {
                                final araba = arabalar[index];
                                final resimUrl = araba.imageUrl.isNotEmpty ? araba.imageUrl : 'https://images.unsplash.com/photo-1603386329225-868f9b1ee6c9?q=80&w=1000';

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: ArabaKartiOlusturucu.olustur('${araba.marka} ${araba.model}', 'AI Rendered', resimUrl, 'Yeni', anaRenk, koyuYuzey),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}

// ARABA KARTI OLUŞTURUCU
class ArabaKartiOlusturucu {
  static Widget olustur(String baslik, String altBaslik, String resimUrl, String zaman, Color anaRenk, Color koyuYuzey) {
    return Container(
      decoration: BoxDecoration(color: koyuYuzey, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withOpacity(0.05))),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(16)), child: Image.network(resimUrl, height: 150, width: double.infinity, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Container(height: 150, width: double.infinity, color: Colors.black26, child: const Icon(Icons.directions_car, color: Colors.grey, size: 40)))),
              Positioned(top: 10, right: 10, child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.black.withOpacity(0.7), borderRadius: BorderRadius.circular(4)), child: Row(children: [const Icon(Icons.circle, color: Colors.green, size: 8), const SizedBox(width: 4), Text(t('completed'), style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))]))),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(baslik, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)), Text(altBaslik, style: const TextStyle(color: Colors.grey, fontSize: 12))]),
                    const Icon(Icons.more_vert, color: Colors.grey),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: Colors.white10, height: 1),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [const Icon(Icons.schedule, color: Colors.grey, size: 14), const SizedBox(width: 4), Text(zaman, style: const TextStyle(color: Colors.grey, fontSize: 12))]),
                    Row(
                      children: [
                        Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.share, color: Colors.white, size: 16)),
                        const SizedBox(width: 8),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: anaRenk, borderRadius: BorderRadius.circular(8)), child: Text(t('edit'), style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}