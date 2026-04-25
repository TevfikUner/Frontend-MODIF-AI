import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'sistem_ve_dil.dart';
import 'ortak_widgetlar.dart';

class SekmeMagaza extends StatelessWidget {
  const SekmeMagaza({super.key});

  @override
  Widget build(BuildContext context) {
    final Color anaRenk = const Color(0xFF257bf4);
    final Color koyuArkaplan = const Color(0xFF0A1017);
    final Color koyuYuzey = const Color(0xFF182434);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlassHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t('store_title'), style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(t('store_desc'), style: const TextStyle(color: Colors.grey, fontSize: 14)),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(t('packages'), style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _paketKarti(koyuYuzey, baslik: '50 ${t('credit')}', fiyat: '29.99 ₺', aciklama: t('ideal_single'), renk: anaRenk, ikon: Icons.diamond_outlined),
                  const SizedBox(height: 24),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      _paketKarti(koyuYuzey, baslik: '250 ${t('credit')}', bonus: t('bonus_50'), fiyat: '99.99 ₺', aciklama: t('design_enthusiasts'), renk: Colors.purpleAccent, ikon: Icons.diamond),
                      Positioned(
                        top: -10, right: 0,
                        child: Transform.rotate(
                          angle: 0.1,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(color: Colors.deepOrange, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.deepOrange.withOpacity(0.5), blurRadius: 8)]),
                            child: Text(t('best_deal'), style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), gradient: const LinearGradient(colors: [Color(0xFFFFD700), Color(0xFFFFA500)]), boxShadow: [BoxShadow(color: const Color(0xFFFFD700).withOpacity(0.4), blurRadius: 20, spreadRadius: 3)]),
                    padding: const EdgeInsets.all(2),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: koyuArkaplan, borderRadius: BorderRadius.circular(18)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: const Color(0xFFFFD700).withOpacity(0.2), borderRadius: BorderRadius.circular(8)), child: Text(t('most_preferred'), style: const TextStyle(color: Color(0xFFFFD700), fontSize: 10, fontWeight: FontWeight.bold)))],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFFFFD700).withOpacity(0.1), shape: BoxShape.circle), child: const Icon(Icons.all_inclusive, color: Color(0xFFFFD700), size: 32)),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(t('weekly_unlimited'), style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 8),
                                    Text(t('fast_render'), style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                    Text(t('premium_wheels'), style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                    Text(t('unlimited_colors'), style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                  ],
                                ),
                              ),
                              Text('199.99 ₺', style: premiumNumberStyle.copyWith(color: const Color(0xFFFFD700), fontSize: 20)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  InkWell(
                    onTap: () { HapticFeedback.lightImpact(); },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.purple.shade800, Colors.pink]), borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.pink.withOpacity(0.4), blurRadius: 10, spreadRadius: 1)]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.group_add, color: Colors.white, size: 28),
                          const SizedBox(width: 12),
                          Text(t('invite_friend'), textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(child: TextButton.icon(onPressed: () { HapticFeedback.lightImpact(); }, icon: const Icon(Icons.help_outline, color: Colors.grey, size: 18), label: Text(t('faq'), style: const TextStyle(color: Colors.grey)))),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _paketKarti(Color koyuYuzey, {required String baslik, String? bonus, required String fiyat, required String aciklama, required Color renk, required IconData ikon}) {
    return InkWell(
      onTap: () { HapticFeedback.lightImpact(); },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: koyuYuzey, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withOpacity(0.05))),
        child: Row(
          children: [
            Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: renk.withOpacity(0.1), shape: BoxShape.circle), child: Icon(ikon, color: renk, size: 28)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(baslik, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      if (bonus != null) ...[const SizedBox(width: 8), Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(4)), child: Text(bonus, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))]
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(aciklama, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            Text(fiyat, style: premiumNumberStyle.copyWith(color: Colors.white, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}