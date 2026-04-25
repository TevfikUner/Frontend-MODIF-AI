import 'dart:convert';
import 'package:http/http.dart' as http;
import '../modeller/araba_model.dart';

class ApiServisi {
  // DİKKAT: Aradaki boşluk silindi, tam bitişik!
  final String baseUrl = "http://192.168.1.194:8000";

  // --- 1. METOT: GARAJI GETİR ---
  Future<List<Araba>> garajiGetir() async {
    try {
      final cevap = await http.get(Uri.parse('$baseUrl/arabalar'));

      if (cevap.statusCode == 200) {
        List<dynamic> gelenJson = json.decode(cevap.body);
        return gelenJson.map((veri) => Araba.fromJson(veri)).toList();
      } else {
        throw Exception("Sunucu Hatası: Kod ${cevap.statusCode}");
      }
    } catch (e) {
      throw Exception("Bağlantı Hatası: $e");
    }
  }

  // --- 2. METOT: GİRİŞ YAP ---
  Future<String> girisYap(String email, String sifre) async {
    try {
      final cevap = await http.post(
        Uri.parse('$baseUrl/users/login'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'username': email,
          'password': sifre,
        },
      ).timeout(
        // Sonsuz döngüyü çözen sihirli 10 saniye kuralı
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception("Sunucuya ulaşılamadı (Zaman aşımı). Bağlantıyı kontrol et!");
        },
      );

      if (cevap.statusCode == 200) {
        final Map<String, dynamic> gelenVeri = json.decode(cevap.body);
        return gelenVeri['access_token'];
      } else if (cevap.statusCode == 401) {
        throw Exception("E-posta veya şifre hatalı kanki!");
      } else {
        throw Exception("Sunucu Hatası: Kod ${cevap.statusCode}");
      }
    } catch (e) {
      throw Exception("$e");
    }
  }
} // Sınıfı kapatan son parantez paşalar gibi en altta!