# PingPong Sample Flutter Projesi

## Mimari
- Projenin temel mimarisi bana ait olup, **MVVM (Model-View-ViewModel)** yapısı kullanılmıştır.
- State management için **Provider** ve özel **ViewModelBuilder** kullanılmıştır.
- Ortak işlemler için **BaseViewModel** sınıfı bulunmaktadır.

## Makefile Kullanımı
Projede bazı işlemler Makefile ile kolayca yapılabilir. Temel komutlar:

```sh
make pubget         # Bağımlılıkları yükler
make gen_assets     # Varlık (assets) dosyalarını otomatik üretir
make gen_routes     # Route dosyalarını otomatik üretir
make gen_view       # View dosyalarını otomatik üretir
```

## Kod Jeneratörlerini Çalıştırmak
Aşağıdaki komutlarla ilgili scriptleri çalıştırabilirsiniz:

```sh
# Assets dosyası üretmek için
make gen_assets

# Route dosyası üretmek için
make gen_routes

# View dosyası üretmek için
make gen_view
```

Her komut, ilgili scripti `scripts/` klasöründen çalıştırır. Komutlar basit ve hızlıdır.

---

Proje mimarisi, sürdürülebilir ve test edilebilir bir yapı sunar. Tüm state yönetimi Provider ile yapılır ve ViewModelBuilder ile widget'lar ViewModel'lerine kolayca bağlanır. BaseViewModel ile ortak fonksiyonlar merkezi olarak yönetilir.

## Özellikler ve Testler

![Push Notification Testi](@push_notification_test.jpeg)

Yukarıda görüldüğü gibi push notification testi yapılmış ve başarıyla sonuç alınmıştır.

- Uygulama offline olduğunda, online olmayı bekler ve bu süreçte eski (önbellekteki) veriyi gösterir.
- Online veya offline durumu, ana sayfadaki bağlantı (connection) ikonundan yeşil (online) veya kırmızı (offline) olarak kolayca görüntülenebilir.
