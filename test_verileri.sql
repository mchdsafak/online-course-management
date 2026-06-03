INSERT INTO Kategoriler (KategoriAdi) VALUES 
('Yazılım Geliştirme'), ('Veri Bilimi'), ('Siber Güvenlik'), ('Grafik Tasarım'), 
('Dijital Pazarlama'), ('Finans & Muhasebe'), ('Kişisel Gelişim'), ('Dil Eğitimi'), 
('Fotoğrafçılık'), ('Müzik');

INSERT INTO Kullanicilar (AdSoyad, Email, Sifre, Rol) VALUES 
('Asım Yılmaz', 'asim.yilmaz@egitim.com', 'sifre123', 'Eğitmen'),
('Berna Çetin', 'berna.cetin@egitim.com', 'sifre123', 'Eğitmen'),
('Caner Demir', 'caner.demir@egitim.com', 'sifre123', 'Eğitmen'),
('Deniz Kaya', 'deniz.kaya@ogrenci.com', 'stud123', 'Öğrenci'),
('Emre Yıldız', 'emre.yildiz@ogrenci.com', 'stud123', 'Öğrenci'),
('Füsun Aydın', 'fusun.aydin@ogrenci.com', 'stud123', 'Öğrenci'),
('Gökhan Avcı', 'gokhan.avci@ogrenci.com', 'stud123', 'Öğrenci'),
('Hande Arslan', 'hande.arslan@ogrenci.com', 'stud123', 'Öğrenci'),
('Ilgın Öztürk', 'ilgin.ozturk@ogrenci.com', 'stud123', 'Öğrenci'),
('Kaan Yurt', 'kaan.yurt@ogrenci.com', 'stud123', 'Öğrenci');

INSERT INTO Kurslar (KursAdi, Aciklama, Fiyat, Kontenjan, EgitmenID, KategoriID) VALUES 
('Python ile Sıfırdan Veri Bilimi', 'Pandas ve NumPy kütüphaneleri içerir.', 450.00, 30, 1, 2),
('C# ve .NET Microservices', 'Kurumsal mimari ve Docker entegrasyonu.', 600.00, 25, 2, 1),
('Siber Güvenliğe Giriş', 'Temel ağ güvenliği ve sızma testleri.', 350.00, 50, 3, 3),
('Photoshop ile Dijital Tasarım', 'Sıfırdan ileri seviye görsel tasarım.', 299.00, 40, 1, 4),
('Sosyal Medya Yönetimi', 'Reklam optimizasyonu ve marka stratejisi.', 199.00, 100, 2, 5),
('Borsa ve Yatırım Teknikleri', 'Temel ve teknik analiz yöntemleri.', 500.00, 20, 3, 6),
('Zaman Yönetimi ve Verimlilik', 'Hayatınızı planlama kılavuzu.', 99.00, 150, 1, 7),
('İleri Seviye İngilizce Konuşma', 'Akıcı konuşma ve iş İngilizcesi.', 400.00, 15, 2, 8),
('DSLR Fotoğrafçılık Eğitimi', 'Işık, kompozisyon ve çekim teknikleri.', 250.00, 35, 3, 9),
('Sıfırdan Klasik Gitar', 'Temel akorlar ve popüler şarkılar.', 150.00, 30, 1, 10);

INSERT INTO Dersler (KursID, DersBasligi, IcerikSuresiDakika) VALUES 
(1, 'Python Kurulumu ve Geliştirme Ortamı', 15),
(1, 'NumPy Array Yapıları', 45),
(2, 'Microservices Nedir?', 20),
(2, 'Docker Compose ile Dağıtım', 60),
(3, 'Nmap ile Port Tarama', 35),
(4, 'Katman (Layer) Mantığı', 25),
(5, 'Meta Reklam Paneli Kullanımı', 50),
(6, 'Mum Grafikleri Nasıl Okunur?', 40),
(8, 'İş Mülakatı Pratikleri', 30),
(10, 'Temel Akor Geçişleri', 45);

INSERT INTO Kayitlar (OgrenciID, KursID, OdemeDurumu) VALUES 
(4, 1, 'Ödendi'),
(4, 2, 'Ödendi'),
(5, 1, 'Ödendi'),
(6, 3, 'Beklemede'),
(7, 4, 'Ödendi'),
(8, 5, 'Ödendi'),
(9, 6, 'İptal'),
(10, 8, 'Ödendi'),
(5, 10, 'Ödendi'),
(7, 2, 'Beklemede');