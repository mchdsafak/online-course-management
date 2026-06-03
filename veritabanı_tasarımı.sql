CREATE DATABASE IF NOT EXISTS OnlineKursDB;
USE OnlineKursDB;

CREATE TABLE Kategoriler (
    KategoriID INT AUTO_INCREMENT PRIMARY KEY,
    KategoriAdi VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Kullanicilar (
    KullaniciID INT AUTO_INCREMENT PRIMARY KEY,
    AdSoyad VARCHAR(150) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Sifre VARCHAR(255) NOT NULL,
    Rol ENUM('Eğitmen', 'Öğrenci', 'Yönetici') NOT NULL DEFAULT 'Öğrenci',
    KayitTarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Kurslar (
    KursID INT AUTO_INCREMENT PRIMARY KEY,
    KursAdi VARCHAR(200) NOT NULL,
    Aciklama TEXT,
    Fiyat DECIMAL(10, 2) NOT NULL CHECK (Fiyat >= 0),
    Kontenjan INT NOT NULL CHECK (Kontenjan > 0),
    EgitmenID INT,
    KategoriID INT,
    FOREIGN KEY (EgitmenID) REFERENCES Kullanicilar(KullaniciID) ON DELETE SET NULL,
    FOREIGN KEY (KategoriID) REFERENCES Kategoriler(KategoriID) ON DELETE CASCADE
);

CREATE TABLE Dersler (
    DersID INT AUTO_INCREMENT PRIMARY KEY,
    KursID INT NOT NULL,
    DersBasligi VARCHAR(200) NOT NULL,
    IcerikSuresiDakika INT NOT NULL CHECK (IcerikSuresiDakika > 0),
    FOREIGN KEY (KursID) REFERENCES Kurslar(KursID) ON DELETE CASCADE
);

CREATE TABLE Kayitlar (
    KayitID INT AUTO_INCREMENT PRIMARY KEY,
    OgrenciID INT NOT NULL,
    KursID INT NOT NULL,
    KayitTarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    OdemeDurumu ENUM('Ödendi', 'Beklemede', 'İptal') DEFAULT 'Beklemede',
    UNIQUE(OgrenciID, KursID),
    FOREIGN KEY (OgrenciID) REFERENCES Kullanicilar(KullaniciID) ON DELETE CASCADE,
    FOREIGN KEY (KursID) REFERENCES Kurslar(KursID) ON DELETE CASCADE
);