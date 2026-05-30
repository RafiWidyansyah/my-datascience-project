# Dokumentasi Projek: Analisis Sentimen Ulasan Game Roblox

Projek ini berfokus pada pemrosesan teks (*Natural Language Processing*) dan pembangunan model *Machine Learning* untuk mengklasifikasikan sentimen pengguna berdasarkan data ulasan aplikasi game Roblox dari Google Play Store. Sentimen dibagi menjadi tiga kategori utama: **Positif**, **Netral**, dan **Negatif**.

---

## 🚀 Alur Kerja Projek (Workflow)

Projek ini dibangun secara sistematis melalui 6 tahapan utama:
1. **Persiapan Lingkungan (Setup & Libraries)**
2. **Memuat Data & Pembersihan Awal**
3. **Pelabelan Otomatis (Labelling)**
4. **Pra-pemrosesan Teks (Text Preprocessing Pipeline)**
5. **Ekstraksi Fitur & Penanganan Data Imbalance**
6. **Pelatihan Model & Evaluasi Performa**

---

## 1. Persiapan Lingkungan & Pustaka (Libraries)

Beberapa pustaka digunakan untuk menangani pemrosesan bahasa alami (NLP) khas Indonesia serta mengatasi ketidakseimbangan kelas ulasan:

* **Sastrawi**: Pustaka khusus untuk *stemming* dan *stopword removal* bahasa Indonesia.
* **Imbalanced-learn (imblearn)**: Menyediakan algoritma SMOTE untuk menyeimbangkan jumlah sampel ulasan.
* **NLTK**: Diperlukan untuk proses tokenisasi kata (`punkt_tab`).
* **Pandas & NumPy**: Fondasi utama untuk manipulasi data tabel dan komputasi numerik.

---

## 2. Memuat Data & Penanganan Nilai Kosong

Dataset awal yang dimuat adalah `ulasan_game_roblox_cleaned.csv` yang berisi **10.000 baris data ulasan** dengan 8 kolom informasi default. 

Terdeteksi terdapat 2 baris data ulasan pada kolom `content` yang bernilai kosong (`null`). Nilai kosong ini langsung diatasi dengan mengubahnya menjadi string pengganti `"gak ada"` agar tidak menghentikan proses *preprocessing* teks di tahap berikutnya.

---

## 3. Pelabelan Sentimen (Labelling)

Ulasan dikategorikan secara otomatis menjadi 3 kelas sentimen menggunakan batas skor *rating* bintang (`score`) dari pengguna:

| Skor Bintang (`score`) | Nilai Label (`label_num`) | Polarity (Kategori) |
| :--- | :---: | :--- |
| **Bintang 4 & 5** | `1` | **Positive** (Puas/Bagus) |
| **Bintang 3** | `0` | **Neutral** (Biasa saja) |
| **Bintang 1 & 2** | `-1` | **Negative** (Kecewa/Jelek) |

---

## 4. Pra-pemrosesan Teks (Text Preprocessing Pipeline)

Tahap ini adalah kunci untuk mengubah teks ulasan mentah yang penuh dengan singkatan, kata gaul (*slang*), dan karakter tidak penting menjadi teks bersih yang siap dipahami oleh model:

* **Cleaning (`cleaningText`)**: Menghapus *mentions* (`@`), *hashtags* (`#`), tanda *Retweet* (`RT`), URL, angka, serta membersihkan semua simbol tanda baca.
* **Case Folding (`casefoldingText`)**: Mengubah seluruh huruf menjadi huruf kecil (*lowercase*).
* **Slang Word Fixer (`fix_slangwords`)**: Memetakan dan mengubah kata-kata tidak baku/singkatan (misal: *gw*, *ngelag*, *bgs*) menjadi kata baku bahasa Indonesia dengan bantuan kamus eksternal `kamuskatabaku.xlsx`.
* **Tokenizing (`tokenizingText`)**: Memecah kalimat panjang menjadi potongan kata tunggal (*token*).
* **Filtering/Stopword Removal (`filteringText`)**: Menghapus kata umum yang tidak membawa makna sentimen berarti (*stopwords*) menggunakan daftar bawaan NLTK ditambah kata gaul tambahan seperti "sih", "loh", "woi", "nya", "gak".
* **To Sentence (`toSentence`)**: Menggabungkan kembali potongan kata yang sudah bersih menjadi satu kalimat utuh di kolom akhir bernama `text_akhir`.

---

## 5. Ekstraksi Fitur & Penanganan Ketidakseimbangan Data

Sebelum masuk ke tahap permodelan, teks bersih dikonversi ke bentuk angka:
1. **TF-IDF Vectorizer**: Mengubah kalimat ulasan menjadi matriks angka berdasarkan bobot kepentingan kata unik di dalam dokumen.
2. **SMOTE (Synthetic Minority Over-sampling Technique)**: Digunakan untuk menduplikasi data kelas minoritas secara sintetis sehingga model dapat belajar secara adil pada setiap kategori sentimen (mencegah bias pada kelas mayoritas).

---

## 6. Eksperimen Model Machine Learning & Hasil Evaluasi

Projek ini menguji 4 algoritma populer dengan skenario pembagian data latih (*Training Set*) dan data uji (*Test Set*) yang berbeda:

### Skenario 1: Skenario 70% Data Latih & 30% Data Uji

| Algoritma Model | Akurasi Data Latih (Train Accuracy) | Akurasi Data Uji (Test Accuracy) |
| :--- | :---: | :---: |
| **Random Forest Classifier** | **97.8%** | **85.6%** |
| **Support Vector Classifier (SVC)** | 91.3% | 84.0% |
| **Decision Tree Classifier** | 97.8% | 78.2% |
| **Logistic Regression** | 81.6% | 74.8% |

### Skenario 2: Skenario 75% Data Latih & 25% Data Uji

Pada skenario kedua, model terbaik diuji kembali dengan porsi data latih yang lebih besar:
* **Random Forest Classifier**: Menghasilkan akurasi data latih sebesar **97.0%** dan akurasi data uji sebesar **85.7%** (mengalami kenaikan tipis sebesar 0.1%).

---

## 📌 Kesimpulan Akhir

1. Model **Random Forest Classifier** terbukti menjadi algoritma paling optimal untuk melakukan analisis sentimen ulasan Roblox pada dataset ini, dengan tingkat akurasi konsisten di kisaran **85.6% - 85.7%** pada data uji.
2. Model berbasis *tree* (Random Forest & Decision Tree) menunjukkan kecenderungan *overfitting* yang cukup tinggi (akurasi train mencapai 97.8%). Untuk pengembangan ke depan, disarankan melakukan *Hyperparameter Tuning* (seperti membatasi `max_depth` atau mengatur `min_samples_split`).
3. Proses penanganan kata baku dengan berkas `kamuskatabaku.xlsx` memegang peranan krusial mengingat ulasan pengguna game didominasi oleh bahasa informal dan kasual.
