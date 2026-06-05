# 📚 Online Kurs Yönetim Sistemi Paneli

Bu proje, modern bir online eğitim platformunun arka plan veritabanı mimarisini ve bu mimariyi dinamik olarak yöneten bir web arayüzünü kapsaktadır. İlişkisel veritabanı tasarımı **MySQL** ile kurulmuş, kullanıcı paneli ise **Python (Streamlit)** kullanılarak geliştirilmiştir.

---

## 🛠️ Kullanılan Teknolojiler
* **Veritabanı:** MySQL Server (İlişkisel Mimari, İndeksleme, Kayıt Kontrolleri)
* **Arayüz (Frontend/Backend):** Python 3.12, Streamlit, Pandas
* **Sürücü:** mysql-connector-python

---

## 📐 Veritabanı Mimarisi ve Tablo Yapıları

Veritabanı, veri bütünlüğünü ve ilişkisel bütünlük kurallarını (Foreign Key, Cascade, Check Constraints) tam anlamıyla karşılayacak şekilde tasarlanmıştır.

* **Kurslar:** Platformdaki eğitimlerin temel bilgilerini tutar.
* **Kategoriler:** Kursların sınıflandırılmasını sağlar.
* **Eğitmenler:** Kursu veren eğitmenlerin bilgilerini barındırır.
* **Öğrenciler:** Sisteme kayıtlı kullanıcıların bilgilerini tutar.
* **Kayıtlar:** Öğrencilerin hangi kurslara, ne zaman kaydolduğunu yönetir.

---

## ⚡ Gelişmiş Veritabanı Yapıları (Zorunlu Gereksinimler)

Projede veritabanı performansını artırmak ve iş mantığını otomatikleştirmek adına aşağıdaki gelişmiş SQL nesneleri kullanılmıştır:

### 1. VIEW (Gelişmiş Raporlama)
* **`View_KursDetaylari`:** Kurs adını, fiyatını, kontenjanını, ait olduğu kategoriyi ve eğitmen adını tek bir sanal tabloda birleştirerek arayüze sunar.
* **`View_OgrenciKayitlari`:** Hangi öğrencinin hangi kursa ne zaman kaydolduğunu listeleyen detaylı kayıt raporudur.

### 2. STORED PROCEDURE (İş Mantığı ve Güvenlik)
* **`Sp_KursEkle`:** Parametrik olarak yeni bir kursun adını, açıklamasını, fiyatını, kontenjanını ve ilişkili ID'lerini alarak güvenli bir şekilde sisteme dahil eder.

### 3. TRIGGER (Veri Bütünlüğü ve Kontrol)
* **`Trg_KontenjanKontrol`:** Bir öğrenci kursa kayıt olmaya çalıştığında, ilgili kursun mevcut kontenjanını kontrol eder. Kontenjan dolmuşsa kaydı otomatik olarak engeller ve hata fırlatır.

### 4. INDEX (Performans Optimize)
* Sık sorgulanan metinsel alanlar (KursAdı, ÖğrenciEposta) ve Foreign Key sütunları üzerinde arama performansını katlamak amacıyla özel indeksleme yapıları kurulmuştur.

---

## 🚀 Projeyi Yerelde Çalıştırma

### 1. Veritabanının Kurulması
MySQL Workbench üzerinden aşağıdaki dosyaları **sırasıyla** çalıştırın:
1. `veritabanı_tasarımı.sql`
2. `test_verileri.sql`
3. `gelismis_yapilar.sql`

### 2. Gerekli Kütüphanelerin Yüklenmesi
Terminal üzerinden gerekli bağımlılıkları yükleyin:
```bash
pip install streamlit mysql-connector-python pandas