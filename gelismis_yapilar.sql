CREATE INDEX idx_KursAdi ON Kurslar(KursAdi);
CREATE INDEX idx_KullaniciEmail ON Kullanicilar(Email);

CREATE VIEW View_KursDetaylari AS
SELECT 
    k.KursID,
    k.KursAdi,
    k.Fiyat,
    k.Kontenjan,
    kat.KategoriAdi,
    kul.AdSoyad AS EgitmenAdi
FROM Kurslar k
JOIN Kategoriler kat ON k.KategoriID = kat.KategoriID
LEFT JOIN Kullanicilar kul ON k.EgitmenID = kul.KullaniciID;

CREATE VIEW View_OgrenciKayitlari AS
SELECT 
    ka.KayitID,
    kul.AdSoyad AS OgrenciAdi,
    kul.Email AS OgrenciEmail,
    k.KursAdi,
    ka.KayitTarihi,
    ka.OdemeDurumu
FROM Kayitlar ka
JOIN Kullanicilar kul ON ka.OgrenciID = kul.KullaniciID
JOIN Kurslar k ON ka.KursID = k.KursID;

DELIMITER //
CREATE PROCEDURE Sp_KursEkle(
    IN p_KursAdi VARCHAR(200),
    IN p_Aciklama TEXT,
    IN p_Fiyat DECIMAL(10,2),
    IN p_Kontenjan INT,
    IN p_EgitmenID INT,
    IN p_KategoriID INT
)
BEGIN
    INSERT INTO Kurslar (KursAdi, Aciklama, Fiyat, Kontenjan, EgitmenID, KategoriID)
    VALUES (p_KursAdi, p_Aciklama, p_Fiyat, p_Kontenjan, p_EgitmenID, p_KategoriID);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Sp_OdemeGuncelle(
    IN p_KayitID INT,
    IN p_YeniDurum ENUM('Ödendi', 'Beklemede', 'İptal')
)
BEGIN
    UPDATE Kayitlar 
    SET OdemeDurumu = p_YeniDurum 
    WHERE KayitID = p_KayitID;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER Before_KayitEkle
BEFORE INSERT ON Kayitlar
FOR EACH ROW
BEGIN
    DECLARE v_MevcutKayit INT;
    DECLARE v_Kontenjan INT;
    
    SELECT Kontenjan INTO v_Kontenjan FROM Kurslar WHERE KursID = NEW.KursID;
    SELECT COUNT(*) INTO v_MevcutKayit FROM Kayitlar WHERE KursID = NEW.KursID AND OdemeDurumu != 'İptal';
    
    IF v_MevcutKayit >= v_Kontenjan THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Hata: Bu kursun kontenjanı tamamen dolmuştur!';
    END IF;
END //
DELIMITER ;