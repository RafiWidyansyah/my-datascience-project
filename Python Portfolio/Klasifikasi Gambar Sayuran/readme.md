# Dokumentasi Proyek: Klasifikasi Gambar Sayuran (Vegetable Images)

Dokumentasi ini disusun untuk memberikan penjelasan menyeluruh mengenai alur kerja pengembangan model pembelajaran mendalam (*deep learning*) untuk mendeteksi dan mengklasifikasikan berbagai jenis sayuran.

---

## 📌 Informasi Proyek
* **Nama Pengembang:** Rafi Widyansyah
* **Email:** dompetakun@gmail.com
* **ID Dicoding:** rafiwidyansyah
* **Dataset:** Vegetable Images Dataset (15 Kelas Sayuran)
* **Framework Utama:** TensorFlow 2.19.0 & Keras

---

## 🚀 Ringkasan Eksekutif
Proyek ini bertujuan untuk membangun model *Convolutional Neural Network* (CNN) yang mampu mengenali 15 jenis sayuran dengan akurasi tinggi. Berkat penerapan augmentasi data yang tepat, regularisasi L2, dan pemanfaatan callback adaptif, model berhasil mencapai **Akurasi Uji sebesar 97.94%**. Model ini juga telah dikonversi ke format **TFLite** dan **TensorFlow.js** agar siap digunakan di perangkat mobile maupun aplikasi berbasis web.

---

## 🛠️ Alur Kerja Proyek (*Project Workflow*)

### 1. Prasyarat & Pustaka (*Libraries*)
Proyek ini memanfaatkan ekosistem Python modern untuk pengolahan citra dan machine learning:
* **Manipulasi Data & File:** Menggunakan pustaka `os`, `shutil`, `zipfile`, `pandas`, dan `numpy`.
* **Pengolahan Citra:** Menggunakan `cv2` (OpenCV), `PIL` (Pillow), dan `skimage` (Scikit-Image).
* **Visualisasi:** Menggunakan `matplotlib` dan `seaborn`.
* **Core Machine Learning:** Menggunakan `tensorflow`, `keras`, dan `sklearn`.
* **Deployment:** Menggunakan `tensorflowjs`.

### 2. Persiapan & Pembagian Data (*Data Splitting*)
Dataset diunduh langsung dari Kaggle menggunakan Kaggle API. Data awal yang terpisah antara folder *train* dan *validation* digabungkan terlebih dahulu untuk kemudian dibagi ulang secara bersih menggunakan pustaka `splitfolders` dengan rasio **80:10:10**.

| Distribusi Data | Persentase | Jumlah Sampel | Tujuan |
| :--- | :---: | :---: | :--- |
| **Train Set** | 80% | 14,400 gambar | Digunakan untuk melatih parameter model. |
| **Validation Set** | 10% | 1,800 gambar | Digunakan untuk mengevaluasi model saat proses latihan (*tuning*). |
| **Test Set** | 10% | 1,800 gambar | Digunakan untuk menguji performa akhir model pada data baru. |

### 3. Pra-pemrosesan & Augmentasi Gambar
Untuk mencegah model dari *overfitting* (hanya menghafal data latihan), teknik augmentasi gambar diterapkan secara real-time pada komponen `ImageDataGenerator`:
* **Dimensi Gambar:** Diubah menjadi **64x64 piksel** dengan format warna **RGB** (3 channel).
* **Ukuran Batch (Batch Size):** Ditentukan sebesar 32 gambar per iterasi.
* **Augmentasi Latihan:** Proses ini melibatkan normalisasi piksel (`rescale=1./255`), rotasi acak hingga 15 derajat (`rotation_range=15`), perbesaran acak skala 0.1 (`zoom_range=0.1`), dan pembalikan gambar horizontal (`horizontal_flip=True`).
* **Data Validasi & Uji:** Hanya melewati proses normalisasi piksel (`rescale=1./255`) tanpa augmentasi tambahan untuk menjaga keaslian data uji.

---

## 🧠 Arsitektur Model CNN

Model dibangun menggunakan struktur *Sequential* dengan kombinasi lapisan konvolusi untuk ekstraksi fitur dan lapisan padat (*dense*) untuk klasifikasi akhir. Seluruh lapisan konvolusi dan dense dilengkapi dengan **Regularisasi L2 (0.01)** untuk menjaga stabilitas bobot model.

[Input: 64x64x3 RGB]
│
┌───────┴───────┐
│ 4x (Conv2D + BatchNormalization + MaxPooling2D)
└───────┬───────┘
│ [Ekstraksi Fitur Gambar]
[Flatten]
│
┌───────┴───────┐
│ 3x Dense Layers (1024 ➔ 512 ➔ 256 unit dengan aktivasi ReLU)
└───────┬───────┘
│ [Proses Klasifikasi]
[Output: Dense 15 unit + Softmax]

Tentu, ini adalah seluruh isi dokumentasi yang telah dikonversi ke dalam format Markdown (`.md`). Anda bisa langsung menyalin seluruh teks di bawah ini dan menyimpannya menjadi file dengan ekstensi `.md` (misalnya: `README.md` atau `Dokumentasi_Proyek.md`).

```markdown
# Dokumentasi Proyek: Klasifikasi Gambar Sayuran (Vegetable Images)

Dokumentasi ini disusun untuk memberikan penjelasan menyeluruh mengenai alur kerja pengembangan model pembelajaran mendalam (*deep learning*) untuk mendeteksi dan mengklasifikasikan berbagai jenis sayuran.

---

## 📌 Informasi Proyek
* **Nama Pengembang:** Rafi Widyansyah
* **Email:** dompetakun@gmail.com
* **ID Dicoding:** rafiwidyansyah
* **Dataset:** Vegetable Images Dataset (15 Kelas Sayuran)
* **Framework Utama:** TensorFlow 2.19.0 & Keras

---

## 🚀 Ringkasan Eksekutif
Proyek ini bertujuan untuk membangun model *Convolutional Neural Network* (CNN) yang mampu mengenali 15 jenis sayuran dengan akurasi tinggi. Berkat penerapan augmentasi data yang tepat, regularisasi L2, dan pemanfaatan callback adaptif, model berhasil mencapai **Akurasi Uji sebesar 97.94%**. Model ini juga telah dikonversi ke format **TFLite** dan **TensorFlow.js** agar siap digunakan di perangkat mobile maupun aplikasi berbasis web.

---

## 🛠️ Alur Kerja Proyek (*Project Workflow*)

### 1. Prasyarat & Pustaka (*Libraries*)
Proyek ini memanfaatkan ekosistem Python modern untuk pengolahan citra dan machine learning:
* **Manipulasi Data & File:** Menggunakan pustaka `os`, `shutil`, `zipfile`, `pandas`, dan `numpy`.
* **Pengolahan Citra:** Menggunakan `cv2` (OpenCV), `PIL` (Pillow), dan `skimage` (Scikit-Image).
* **Visualisasi:** Menggunakan `matplotlib` dan `seaborn`.
* **Core Machine Learning:** Menggunakan `tensorflow`, `keras`, dan `sklearn`.
* **Deployment:** Menggunakan `tensorflowjs`.

### 2. Persiapan & Pembagian Data (*Data Splitting*)
Dataset diunduh langsung dari Kaggle menggunakan Kaggle API. Data awal yang terpisah antara folder *train* dan *validation* digabungkan terlebih dahulu untuk kemudian dibagi ulang secara bersih menggunakan pustaka `splitfolders` dengan rasio **80:10:10**.

| Distribusi Data | Persentase | Jumlah Sampel | Tujuan |
| :--- | :---: | :---: | :--- |
| **Train Set** | 80% | 14,400 gambar | Digunakan untuk melatih parameter model. |
| **Validation Set** | 10% | 1,800 gambar | Digunakan untuk mengevaluasi model saat proses latihan (*tuning*). |
| **Test Set** | 10% | 1,800 gambar | Digunakan untuk menguji performa akhir model pada data baru. |

### 3. Pra-pemrosesan & Augmentasi Gambar
Untuk mencegah model dari *overfitting* (hanya menghafal data latihan), teknik augmentasi gambar diterapkan secara real-time pada komponen `ImageDataGenerator`:
* **Dimensi Gambar:** Diubah menjadi **64x64 piksel** dengan format warna **RGB** (3 channel).
* **Ukuran Batch (Batch Size):** Ditentukan sebesar 32 gambar per iterasi.
* **Augmentasi Latihan:** Proses ini melibatkan normalisasi piksel (`rescale=1./255`), rotasi acak hingga 15 derajat (`rotation_range=15`), perbesaran acak skala 0.1 (`zoom_range=0.1`), dan pembalikan gambar horizontal (`horizontal_flip=True`).
* **Data Validasi & Uji:** Hanya melewati proses normalisasi piksel (`rescale=1./255`) tanpa augmentasi tambahan untuk menjaga keaslian data uji.

---

## 🧠 Arsitektur Model CNN

Model dibangun menggunakan struktur *Sequential* dengan kombinasi lapisan konvolusi untuk ekstraksi fitur dan lapisan padat (*dense*) untuk klasifikasi akhir. Seluruh lapisan konvolusi dan dense dilengkapi dengan **Regularisasi L2 (0.01)** untuk menjaga stabilitas bobot model.


```

[Input: 64x64x3 RGB]
│
┌───────┴───────┐
│ 4x (Conv2D + BatchNormalization + MaxPooling2D)
└───────┬───────┘
│ [Ekstraksi Fitur Gambar]
[Flatten]
│
┌───────┴───────┐
│ 3x Dense Layers (1024 ➔ 512 ➔ 256 unit dengan aktivasi ReLU)
└───────┬───────┘
│ [Proses Klasifikasi]
[Output: Dense 15 unit + Softmax]

```

### Detail Parameter Kompilasi:
* **Fungsi Kerugian (Loss Function):** `categorical_crossentropy` digunakan karena target merupakan klasifikasi multi-kelas.
* **Pengoptimasi (Optimizer):** Menggunakan `Adam` optimizer untuk kestabilan adaptif selama pelatihan.
* **Metrik Evaluasi:** Menggunakan metrik `accuracy`.

---

## 📉 Proses Pelatihan Model

Proyek ini menggunakan dua mekanisme *Callback* cerdas untuk mengoptimalkan durasi dan kualitas latihan:
1. **ReduceLROnPlateau:** Menurunkan *learning rate* secara otomatis sebesar 50% jika akurasi validasi tidak meningkat selama 2 epoch berturut-turut.
2. **EarlyStopping:** Menghentikan latihan secara otomatis jika nilai *validation loss* tidak membaik selama 10 epoch untuk menghemat waktu komputasi.

### Tren Hasil Pelatihan (Epoch Pilihan):
* **Epoch 1:** Akurasi Latihan: 65.44% | Akurasi Validasi: 27.33%
* **Epoch 11:** Akurasi Latihan: 97.40% | Akurasi Validasi: 93.00%
* **Epoch 24:** Akurasi Latihan: 99.76% | Akurasi Validasi: 98.67%
* **Epoch 30 (Final):** Akurasi Latihan: **99.90%** | Akurasi Validasi: **96.72%**

> **Catatan Analisis:** Penurunan *learning rate* secara bertahap terbukti berhasil merapatkan jarak antara akurasi training dan validasi di fase akhir latihan, sehingga mencegah terjadinya overfitting yang parah.

---

## 📊 Evaluasi Performa Akhir

Setelah proses latihan selesai, model dievaluasi secara objektif menggunakan **Test Set** yang sepenuhnya belum pernah dilihat oleh model sebelumnya.

* **Akurasi Uji (Test Accuracy):** `97.94%`
* **Kerugian Uji (Test Loss):** `0.2988`

Hasil ini menandakan bahwa model memiliki kemampuan generalisasi yang luar biasa tinggi dan siap digunakan pada kondisi riil untuk mengenali 15 jenis sayuran berbeda.

---

## 💾 Konversi & Deployment Model

Untuk memastikan model ini dapat diintegrasikan ke berbagai platform aplikasi, model akhir diekspor ke dalam tiga format berbeda:

1. **TensorFlow SavedModel**
   * **Direktori:** `vegetable_image_classification_savedmodel`
   * **Kegunaan:** Format standar TensorFlow untuk deployment di server atau *backend cloud*.
2. **TensorFlow Lite (TFLite)**
   * **Direktori:** `tflite_models/vegetable_image_classification.tflite`
   * **Kegunaan:** Format kompresi yang sangat ringan, dioptimalkan untuk aplikasi Mobile (Android/iOS) dan perangkat Edge IoT.
3. **TensorFlow.js (TFJS)**
   * **Direktori:** `vegetable_image_classification_tfjs`
   * **Kegunaan:** Format model berbasis web, memungkinkan inferensi gambar langsung di sisi klien (*client-side browser*) tanpa membebani server.

---

## 💡 Kesimpulan
Proyek ini berhasil mendemonstrasikan pembuatan sistem klasifikasi gambar *end-to-end* yang kokoh. Dari penanganan data awal yang digabungkan, proses augmentasi untuk memperkaya variasi data, pembuatan arsitektur CNN dengan *Batch Normalization*, hingga tahap akhir ekspor model siap pakai ke berbagai platform. Akurasi akhir sebesar **97.94%** membuktikan kualitas pipa pemrograman (*pipeline*) data dan pemodelan yang dirancang telah memenuhi standar klasifikasi yang andal.

```
