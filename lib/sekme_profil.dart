import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'sistem_ve_dil.dart';

class SekmeProfil extends StatelessWidget {
  final String aktifProfilFoto;
  final int toplamAraba;
  final Map<String, dynamic> rankDetails;
  final VoidCallback onAvatarTap;
  final VoidCallback onRanksTap;
  final VoidCallback onTopUpTap;
  final VoidCallback onLangTap;

  const SekmeProfil({
    super.key,
    required this.aktifProfilFoto,
    required this.toplamAraba,
    required this.rankDetails,
    required this.onAvatarTap,
    required this.onRanksTap,
    required this.onTopUpTap,
    required this.onLangTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color anaRenk = const Color(0xFF257bf4);
    final Color koyuYuzey = const Color(0xFF182434);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const SizedBox(height: 80),
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: onAvatarTap,
                  child: Stack(
                    children: [
                      Container(width: 100, height: 100, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: anaRenk, width: 3), image: DecorationImage(image: NetworkImage(aktifProfilFoto), fit: BoxFit.cover))),
                      Positioned(bottom: 0, right: 0, child: Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: anaRenk, shape: BoxShape.circle), child: const Icon(Icons.edit, color: Colors.white, size: 16)))
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Tevfik', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: onRanksTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(color: rankDetails['color'].withOpacity(0.1), border: Border.all(color: rankDetails['color']), borderRadius: BorderRadius.circular(20)),
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(rankDetails['icon'], style: const TextStyle(fontSize: 18)),
                          const SizedBox(width: 8),
                          Text('${rankDetails['level']}. ${t('level')} ${rankDetails['name']}', style: TextStyle(color: rankDetails['color'], fontWeight: FontWeight.bold, fontSize: 16))
                        ]
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 220,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${t('total_renders')}$toplamAraba', style: premiumNumberStyle.copyWith(color: Colors.grey, fontSize: 12)),
                          Text(rankDetails['level'] == 5 ? t('max_level') : '${rankDetails['next']} ${t('target')}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: rankDetails['progress'],
                          minHeight: 8,
                          backgroundColor: Colors.white.withOpacity(0.05),
                          valueColor: AlwaysStoppedAnimation<Color>(rankDetails['color']),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: anaRenk.withOpacity(0.1), borderRadius: BorderRadius.circular(16), border: Border.all(color: anaRenk.withOpacity(0.3))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t('active_balance'), style: const TextStyle(color: Colors.grey, fontSize: 14)),
                    const SizedBox(height: 4),
                    Row(children: [const Icon(Icons.diamond, color: Colors.blueAccent, size: 24), const SizedBox(width: 8),
                      Text('850', style: premiumNumberStyle.copyWith(color: Colors.white, fontSize: 32)),
                      Text(' ${t('credit')}', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 16))]),
                  ],
                ),
                ElevatedButton(
                  onPressed: onTopUpTap,
                  style: ElevatedButton.styleFrom(backgroundColor: anaRenk, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  child: Text(t('top_up'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
          const SizedBox(height: 32),
          Align(alignment: Alignment.centerLeft, child: Text(t('settings'), style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
          const SizedBox(height: 12),
          _profilMenuElemani(koyuYuzey, t('lang_select'), onTap: onLangTap),
          const SizedBox(height: 12),
          _profilMenuElemani(koyuYuzey, t('theme_color')),
          const SizedBox(height: 12),
          _profilMenuElemani(koyuYuzey, t('edit_user')),
          const SizedBox(height: 12),
          _profilMenuElemani(koyuYuzey, t('history')),
          const SizedBox(height: 12),
          _profilMenuElemani(koyuYuzey, t('logout'), isDestructive: true),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _profilMenuElemani(Color koyuYuzey, String baslik, {bool isDestructive = false, VoidCallback? onTap}) {
    return Container(
      decoration: BoxDecoration(color: koyuYuzey, borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(baslik, style: TextStyle(color: isDestructive ? Colors.redAccent : Colors.white, fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap ?? () { HapticFeedback.lightImpact(); },
      ),
    );
  }
}