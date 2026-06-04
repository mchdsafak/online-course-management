import streamlit as st
import mysql.connector
import pandas as pd

# 1. MySQL Veritabanı Bağlantısı
def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="Selman.2013", 
        database="OnlineKursDB"
    )

st.set_page_config(page_title="Online Kurs Yönetim Sistemi", layout="wide")
st.title("📚 Online Kurs ve Yönetim Sistemi Paneli")

# Sol menü (Sidebar) navigasyonu
menu = ["Kurs Listesi (VIEW)", "Öğrenci Kayıtları (VIEW)", "Yeni Kurs Ekle (PROCEDURE)"]
choice = st.sidebar.selectbox("Sistem Menüsü", menu)

# --- 1. SEÇENEK: KURS DETAYLARI (VIEW KULLANIMI) ---
if choice == "Kurs Listesi (VIEW)":
    st.subheader("📋 Mevcut Kurs Detayları")
    st.info("Bu veriler veritabanındaki 'View_KursDetaylari' yapısı kullanılarak anlık çekilmektedir.")
    
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM View_KursDetaylari")
        rows = cursor.fetchall()
        columns = [desc[0] for desc in cursor.description]
        
        df = pd.DataFrame(rows, columns=columns)
        st.dataframe(df, use_container_width=True)
        
        cursor.close()
        conn.close()
    except Exception as e:
        st.error(f"Bağlantı Hatası: {e}")

# --- 2. SEÇENEK: ÖĞRENCİ KAYITLARI (VIEW KULLANIMI) ---
elif choice == "Öğrenci Kayıtları (VIEW)":
    st.subheader("👥 Öğrenci Kayıt Raporları")
    st.info("Bu rapor veritabanındaki 'View_OgrenciKayitlari' yapısı kullanılarak anlık çekilmektedir.")
    
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM View_OgrenciKayitlari")
        rows = cursor.fetchall()
        columns = [desc[0] for desc in cursor.description]
        
        df = pd.DataFrame(rows, columns=columns)
        st.dataframe(df, use_container_width=True)
        
        cursor.close()
        conn.close()
    except Exception as e:
        st.error(f"Bağlantı Hatası: {e}")

# --- 3. SEÇENEK: YENİ KURS EKLE (STORED PROCEDURE KULLANIMI) ---
elif choice == "Yeni Kurs Ekle (PROCEDURE)":
    st.subheader("➕ Sisteme Yeni Kurs Tanımla")
    st.info("Bu form, veritabanındaki 'Sp_KursEkle' isimli Stored Procedure yapısını tetikler.")
    
    # Form alanları
    kurs_adi = st.text_input("Kurs Adı")
    aciklama = st.text_area("Kurs Açıklaması")
    fiyat = st.number_input("Kurs Fiyatı (TL)", min_value=0.0, step=50.0)
    kontenjan = st.number_input("Kurs Kontenjanı", min_value=1, step=5)
    
    # Gerçek veri bütünlüğü için ID'leri basitçe seçtiriyoruz
    egitmen_id = st.selectbox("Eğitmen seçin (ID)", [1, 2, 3])
    kategori_id = st.selectbox("Kategori seçin (ID)", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
    
    if st.button("Kursu Kaydet"):
        if kurs_adi and aciklama:
            try:
                conn = get_db_connection()
                cursor = conn.cursor()
                
                # Stored Procedure Çağırma
                cursor.callproc("Sp_KursEkle", [kurs_adi, aciklama, fiyat, kontenjan, egitmen_id, kategori_id])
                conn.commit()
                
                st.success(f"'{kurs_adi}' başarıyla sisteme eklendi!")
                cursor.close()
                conn.close()
            except Exception as e:
                st.error(f"Veritabanı Hatası: {e}")
        else:
            st.warning("Lütfen kurs adı ve açıklama alanlarını boş bırakmayın.")