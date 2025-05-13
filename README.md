# 🎬 Movie Task V2

**Movie Task V2**, SwiftUI ile geliştirilmiş, **MVVM mimarisi** kullanan ve **The Movie Database (TMDB) API** ile entegre çalışan bir film keşif uygulamasıdır. Uygulama, trend olan, en çok oy alan ve popüler filmleri listeler, detaylarını gösterir ve favorilere kaydetme özelliği sunar.

---

## 🧱 Mimari Yapı

- **MVVM (Model-View-ViewModel)** tasarım deseni
- **Combine** ile reaktif veri işleme
- **SwiftUI** ile modern kullanıcı arayüzü
- **UserDefaults** ile favori verilerini kalıcı olarak saklama

---

## 📱 Özellikler

### 🔍 Ana Sayfa
- **Trend**, **Top Rated** ve **Popüler** filmleri gösterir
- Trend filmler otomatik kayan slider şeklindedir
- Her film afişi ve başlığıyla birlikte gösterilir

### ❤️ Favoriler Sistemi
- Filmleri favorilere ekleyip çıkarabilirsiniz
- Favoriler `UserDefaults` ile kalıcı olarak saklanır
- Uygulama kapansa bile favori listeniz kaybolmaz

### 📄 Film Detay Sayfası
- Film afişi, adı ve açıklaması detaylı gösterilir
- Buradan da favoriye ekleme/çıkarma yapılabilir

### 🛰 API Entegrasyonu
- Veriler [The Movie Database (TMDB)](https://www.themoviedb.org/) üzerinden çekilir
- Tüm API işlemleri Combine ve `URLSession` ile yapılır

### 🎬 Gif
![Movie-Task-V2](https://github.com/user-attachments/assets/96622ae2-6029-4640-b533-649142b5328a)

### 📸 Ekran Görüntüsü

<table>
  <tr>
    <td><strong>Ana Sayfa</strong></td>
    <td><strong>Detay</strong></td>
    <td><strong>Favoriler-Boş</strong></td>
    <td><strong>Favoriler</strong></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/4b9b4b43-bf54-4ac0-ac0c-d1cb5f245cd2" width="250"/></td>
    <td><img src="https://github.com/user-attachments/assets/a45e6e1a-65de-445f-bee4-76be390e8d08" width="250"/></td>
    <td><img src="https://github.com/user-attachments/assets/d122dd13-e951-4311-975e-1737f545895b" width="250"/></td>
    <td><img src="https://github.com/user-attachments/assets/a473f63e-e552-4744-88f5-ec361e45f7ed" width="250"/></td>
  </tr>
</table>



---

## 🔧 Teknoloji Yığını

| Katman        | Teknoloji          |
|---------------|--------------------|
| Arayüz        | SwiftUI            |
| Mimari        | MVVM               |
| Ağ Katmanı    | Combine, URLSession |
| Veri Kaynağı  | TMDB API           |
| Veritabanı    | UserDefaults       |

---

## 🚀 Kurulum Talimatları

1. Depoyu klonlayın:
   ```bash
   git clone https://github.com/kullanici-adi/Movie-Task-V2.git
   cd Movie-Task-V2
