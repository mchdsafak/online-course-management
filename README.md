# 📚 Online Kurs Yönetim Sistemi Paneli

Kocaeli Üniversitesi Bilişim Sistemleri Mühendisliği Bölümü - TBL331 Veritabanı Yönetim Sistemleri Dönem Projesi

---

## 📝 Problem Tanımı
Geleneksel eğitim süreçlerinin dijitalleşmesiyle birlikte, online eğitim platformlarında dinamik veri yönetimi, eş zamanlı kayıt süreçleri, kontrolsüz kontenjan aşımları ve verimsiz raporlama süreçleri büyük birer problem haline gelmiştir [1]. Bu proje; kursların, eğitmenlerin, öğrencilerin ve mali kayıtların ilişkisel bir veritabanı mimarisi altında, veri bütünlüğü kurallarına tam uyumlu şekilde yönetilmesini ve son kullanıcıya performanslı bir web arayüzü üzerinden sunulmasını amaçlamaktadır [1].

---

## 🔍 Yapılan Araştırmalar
* **Veri Tabanı Normalizasyonu:** Tablolar arasındaki veri tekrarlarını önlemek ve anomalileri gidermek amacıyla 5N (Normalizasyon) kuralları ve ilişkisel bütünlük kısıtlayıcıları araştırılmıştır [1].
* **İş Mantığı Güvenliği:** Kontenjan kontrolleri gibi kritik işlemlerin uygulama katmanında gecikmelere sebep olmaması için doğrudan veritabanı motorunda çalışan tetikleyici (Trigger) mekanizmaları incelenmiştir [1].
* **Sorgu Performansı:** Veri setleri büyüdüğünde arama ve listeleme işlemlerinin yavaşlamasını engellemek adına indeksleme (Index) algoritmaları analiz edilmiştir [1].

---

## 💻 Geliştirme Ortamı
* **Veritabanı Katmanı:** MySQL Server 8.0 & MySQL Workbench
* **Uygulama Katmanı:** Python 3.12 & Streamlit Framework
* **Veri Yönetimi ve Sürücüler:** Pandas, mysql-connector-python

---

## 🔄 Akış Şeması (Flowchart)
Sistemin kullanıcı arayüzü ile veritabanı katmanları arasındaki veri işleme ve kontrol adımlarını gösteren algoritma akışı aşağıdadır:

```mermaid
graph TD
    A([Başla]) --> B[Streamlit Arayüzü Açılır]
    B --> C{Sistem Menüsü Seçimi}
    C -->|Kurs Listesi / Öğrenci Raporu| D[View Sorgulanır: SELECT * FROM View...]
    D --> E[Veriler Tablo Olarak Listelenir]
    C -->|Yeni Kurs Ekle| F[Form Alanları Doldurulur]
    F --> G[Kursu Kaydet Butonuna Basılır]
    G --> H[Stored Procedure Tetiklenir: Sp_KursEkle]
    H --> I[Trigger Devreye Girer: Trg_KontenjanKontrol]
    I --> J{Kontenjan Dolu mu?}
    J -->|Evet| K[Hata Fırlatılır ve Kayıt İptal Edilir]
    J -->|Hayır| L[Veritabanına Yeni Kurs Kaydedilir]
    K --> M([Bitir])
    L --> M
    E --> M

---

## 📐 Yazılım Mimarisi
Proje, iki katmanlı (Two-Tier) bir mimari yapı üzerine kurulmuştur [2]:
1. **Veri Katmanı (Data Layer):** MySQL üzerinde çalışan ilişkisel tablolar, kısıtlayıcılar (Constraints), View'lar, Stored Procedure'ler ve Trigger'lar [1].
2. **Sunum ve İş Mantığı Katmanı (Presentation Layer):** Python ile yazılmış, veritabanına güvenli soket bağlantısı kurarak verileri işleyen ve Streamlit ile dinamik görselleştiren web arayüzü [2][3].

---

## 📊 Veri Tabanı Diyagramı (ER Diyagramı)
Projede minimum 5 tablo mantıksal kurallarla (Primary Key, Foreign Key, Cascade, Check) birbirine bağlanmıştır [1]. Sistemin mimari şeması aşağıdadır:

```markdown
```mermaid
erDiagram
    KATEGORILER ||--o{ KURSLAR : "içerir"
    EGITMENLER ||--o{ KURSLAR : "verir"
    KURSLAR ||--o{ KAYITLAR : "sahiptir"
    OGRENCILER ||--o{ KAYITLAR : "yapar"
    
    KATEGORILER {
        int KategoriID PK
        varchar KategoriAdi
    }
    EGITMENLER {
        int EgitmenID PK
        varchar EgitmenAdi
        varchar UzmanlikAlani
    }
    KURSLAR {
        int KursID PK
        varchar KursAdi
        text Aciklama
        decimal Fiyat
        int Kontenjan
        int KategoriID FK
        int EgitmenID FK
    }
    OGRENCILER {
        int OgrenciID PK
        varchar OgrenciAdi
        varchar Eposta
    }
    KAYITLAR {
        int KayitID PK
        int OgrenciID FK
        int KursID FK
        datetime KayitTarihi
    }

---

## ⚡ Genel Yapı ve Gelişmiş Özellikler

### 1. Veri Tabanı Yapısı ve İlişkiler
* **Tablolar:** `Kurslar`, `Kategoriler`, `Eğitmenler`, `Öğrenciler` ve `Kayıtlar` olmak üzere 5 temel tablo mevcuttur [1].
* **Veri Bütünlüğü:** Her tabloda en az 10 adet gerçeği yansıtan anlamlı test verisi (dummy data) gömülüdür [1].

### 2. Entegre Edilen Gelişmiş SQL Nesneleri
* **VIEW (Birden Fazla):** * `View_KursDetaylari`: Kurs, kategori ve eğitmen bilgilerini birleştirerek sunar [1].
  * `View_OgrenciKayitlari`: Öğrencilerin kurs kayıt geçmişlerini anlık raporlar [1].
* **STORED PROCEDURE (Birden Fazla):**
  * `Sp_KursEkle`: Parametrik olarak veritabanına güvenli kurs eklemeyi sağlar [1].
  * `Sp_KursFiyatGuncelle`: Belirli bir kursun ücretini güncelleyen iş mantığıdır [1].
* **TRIGGER (Birden Fazla):**
  * `Trg_KontenjanKontrol`: Kurs kontenjanı dolduğunda yeni kaydı otomatik engeller ve hata fırlatır [1].
  * `Trg_KayitLogla`: Başarılı her kayıttan sonra sistem log tablosuna otomatik iz bırakır [1].
* **INDEX (Birden Fazla):**
  * `Idx_KursAdi`: Kurs aramalarını hızlandırmak amacıyla oluşturulmuştur [1].
  * `Idx_OgrenciEposta`: Öğrenci sorgulamalarında performans optimizasyonu sağlar [1].

---

## 🖥️ Geliştirilen Arayüzün Örnek Görseli
Sistemin tıkır tıkır çalışan canlı web yönetim panelinden bir ekran görüntüsü:

![Uygulama Arayüzü](arayüz.png)

---

## 🚀 Projenin Yüklenmesi ve Çalıştırılması

### 1. Veritabanı Kurulumu
MySQL Workbench üzerinde aşağıdaki scriptleri **sırasıyla** çalıştırın:
1. `veritabanı_tasarımı.sql`
2. `test_verileri.sql`
3. `gelismis_yapilar.sql`

### 2. Kütüphanelerin Yüklenmesi
Terminal veya komut istemi üzerinden bağımlılıkları indirin:
```bash
pip install streamlit mysql-connector-python pandas