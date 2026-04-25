import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'sistem_ve_dil.dart';
import 'ortak_widgetlar.dart';
import 'sekme_anasayfa.dart'; // TumGarajSayfasi için

class SekmeKesfet extends StatelessWidget {
  const SekmeKesfet({super.key});

  @override
  Widget build(BuildContext context) {
    final Color anaRenk = const Color(0xFF257bf4);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlassHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t('discover_title'), style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(t('discover_desc'), style: const TextStyle(color: Colors.grey, fontSize: 14)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: ElevatedButton.icon(
              onPressed: () {
                HapticFeedback.lightImpact();
                Navigator.push(context, MaterialPageRoute(builder: (context) => const TumGarajSayfasi()));
              },
              icon: const Icon(Icons.rocket_launch, color: Colors.white),
              label: Text(t('share_your_legend'), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: anaRenk,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 8,
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              padding: const EdgeInsets.all(24.0),
              childAspectRatio: 0.8,
              children: const [
                KesfetGonderisiCard(resimUrl: 'https://images.unsplash.com/photo-1614200179396-2bdb77ebf81b?q=80&w=1000', kullaniciAdi: '@Viper_Garage', baslik: 'Skyline GTR R34', baslangicAlev: 5430, isFire: true),
                KesfetGonderisiCard(resimUrl: 'https://images.unsplash.com/photo-1544829099-b9a0c07fad1a?q=80&w=1000', kullaniciAdi: '@Kaan_Drift', baslik: 'Neon Supra MK4', baslangicAlev: 3125),
                KesfetGonderisiCard(resimUrl: 'https://images.unsplash.com/photo-1503376713222-25ec13d8cbb8?q=80&w=1000', kullaniciAdi: '@Ahmet3D', baslik: 'Porsche 911 GT3', baslangicAlev: 820),
                KesfetGonderisiCard(resimUrl: 'https://images.unsplash.com/photo-1511919884226-fd3cad34687c?q=80&w=1000', kullaniciAdi: '@RacerMat', baslik: 'Aventador Spez.', baslangicAlev: 1540),
              ],
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

// KEŞFET KARTI BURAYA TAŞINDI
class KesfetGonderisiCard extends StatefulWidget {
  final String resimUrl;
  final String kullaniciAdi;
  final String baslik;
  final int baslangicAlev;
  final bool isFire;

  const KesfetGonderisiCard({
    super.key,
    required this.resimUrl,
    required this.kullaniciAdi,
    required this.baslik,
    required this.baslangicAlev,
    this.isFire = false,
  });

  @override
  State<KesfetGonderisiCard> createState() => _KesfetGonderisiCardState();
}

class _KesfetGonderisiCardState extends State<KesfetGonderisiCard> {
  late int alevSayisi;
  bool begenildi = false;

  @override
  void initState() {
    super.initState();
    alevSayisi = widget.baslangicAlev;
  }

  void _alevTikla() {
    HapticFeedback.selectionClick();
    setState(() {
      if (begenildi) { alevSayisi--; begenildi = false; }
      else { alevSayisi++; begenildi = true; }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color koyuYuzey = const Color(0xFF182434);

    return Container(
      decoration: BoxDecoration(
        color: koyuYuzey,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: widget.isFire ? Colors.deepOrange : Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(widget.resimUrl, width: double.infinity, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Container(color: Colors.black26, child: const Icon(Icons.image_not_supported, color: Colors.grey))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.baslik, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text('${t('by')}${widget.kullaniciAdi}', style: const TextStyle(color: Colors.grey, fontSize: 10), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                InkWell(
                  onTap: _alevTikla,
                  borderRadius: BorderRadius.circular(12),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: begenildi ? Colors.deepOrange.withOpacity(0.2) : Colors.deepOrange.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: begenildi ? Colors.deepOrangeAccent : Colors.deepOrange.withOpacity(0.5)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('🔥', style: TextStyle(fontSize: 14)),
                        const SizedBox(width: 4),
                        Text(alevSayisi.toString(), style: premiumNumberStyle.copyWith(color: begenildi ? Colors.white : Colors.deepOrange, fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}