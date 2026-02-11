Berikut adalah terjemahan isi dokumen **User Manual Mobile SummitDocs** yang disusun ulang ke dalam format Markdown agar lebih mudah dibaca dan terstruktur:

## SummitDocs
---

**SummitDocs** adalah aplikasi berbasis digital yang dirancang untuk mempermudah manajemen dokumen dan data peserta pada konferensi ilmiah, khususnya untuk event **ICODSA** (International Conference on Data Science and Applications) dan **ICICYTA** (International Conference on Innovation in Cyber Technology and Applications) .

### Fungsi Utama

* **Administrasi:** Menangani alur kompleks seperti pengumpulan informasi paper, pengelolaan penulis, dan penerbitan dokumen resmi seperti *Letter of Acceptance* (LoA) .
* **Fitur Pengelolaan:** Menyediakan fitur pengelolaan LoA, Invoice, dan Receipt untuk mendukung administrasi acara .
* **Manajemen Data:** Pengguna dapat mengakses detail entri, menambahkan data baru, dan mengatur status penerimaan paper secara terpusat .

Dokumentasi ini disusun sebagai panduan lengkap bagi pengembang, administrator, dan pengguna terkait alur fitur dan antarmuka aplikasi .

---

## HALAMAN LOGIN

Pada aplikasi SummitDocs, terdapat halaman login dengan ketentuan sebagai berikut:

* **Tidak Ada Register:** Halaman pendaftaran (*register*) tidak tersedia untuk umum. Penambahan, pengeditan, atau penghapusan akun hanya dapat dilakukan melalui halaman **Super Admin** .
* **Fitur Login:**
* Terdapat dua kolom isian: *Username* dan *Password* .
* Fitur "Lihat Password" untuk memastikan kesesuaian penulisan sandi .


* **Role (Peran):** Terdapat 3 level akses, yaitu **Super Admin**, **Icicyta Admin**, dan **Icodsa Admin** .

---

## HALAMAN SUPER ADMIN

Halaman ini memiliki menu khusus untuk konfigurasi sistem yang hanya dapat diakses oleh Super Admin .

### Kelola Akun (Menu Admin)

* **Fungsi:** Menambah atau menghapus akun pengguna .
* **Tambah Akun:** Mengisi formulir yang mencakup Username, Email, Password, Role, dan Nama Lengkap .
* **Hapus Akun:** Dilengkapi dengan *pop-up* konfirmasi untuk memastikan tindakan penghapusan .

### Transfer / Virtual Account

* **Fungsi:** Menyimpan data bank atau *virtual account* .
* **Tambah Data Virtual Account:** Memerlukan input Nomor VA, Nama Pemilik Akun (*Account Holder Name*), Nama Bank, dan Cabang Bank .
* **Tambah Data Bank Transfer:** Memerlukan input Nama Bank, Swift Code, Nama Penerima, Rekening Bank Penerima (*Beneficiary Bank Account*), Cabang, Alamat, Kota, dan Negara Bank .
* **Fitur Lain:** Melihat detail penyimpanan bank dan menghapus data yang tidak relevan .

### Signature (Tanda Tangan)

* **Fungsi:** Melihat, menambah, dan menghapus tanda tangan digital .
* **Tambah Data:** Mengisi Nama Penandatangan, Jabatan, Tanggal Dibuat, dan mengunggah foto tanda tangan .
* **Hapus Foto:** Tekan foto selama 5 detik pada kolom *Upload Signature* untuk menghapus foto yang akan diunggah .
* **Hapus Data:** Geser (*scroll*) ke kanan pada daftar dan tekan tombol "Hapus" .

---

## HALAMAN ADMIN (ICODSA & ICICYTA)

Halaman ini menampilkan data peserta dan paper untuk event terkait. Tampilan dashboard ICODSA dan ICICYTA memiliki struktur serupa .

### Beranda (Dashboard)

* **History:** Menampilkan riwayat Invoice (status *Pending/Paid*), LoA (status *Rejected/Accepted*), dan Receipt .
* **Refresh:** Pengguna dapat melakukan *Swipe Refresh* untuk memuat ulang data .
* **Pagination:** Jika data mencapai 5 item, fitur halaman (*pagination*) otomatis aktif .

### Letter of Acceptance (LoA)

* **Tabel Data:** Menampilkan Judul Paper, Penulis, Waktu Pembuatan, Tanggal/Tempat, dan Status .
* **Tambah Data:** Mengisi Paper ID, Judul Paper, Judul Konferensi, Penulis, Tempat, Tanggal, Status (*Accepted/Rejected*), dan Tanda Tangan .
* **Tambah Penulis:** Bisa menambahkan lebih dari satu penulis .
* **Integrasi:** Data yang disimpan otomatis tampil di halaman Invoice .

### Invoice

* **Isi:** Menampilkan data LoA yang berstatus *Accepted* .
* **Edit Data:** Pengguna dapat menekan tombol Edit untuk mengubah ID Virtual Account, No. Invoice, Institusi, Email, Tanggal, Jumlah (*Amount*), Tipe Author, Status (*Paid/Pending*), Jenis Member, dan Jenis Presentasi .
* **Status Pembayaran:** Jika status diubah menjadi *Paid*, data akan diteruskan ke halaman Receipt .

### 4. Receipt

* **Isi:** Menampilkan data invoice yang sudah lunas (*Paid*) .
* **Detail:** Melihat detail dengan menekan tombol tanda seru atau menggeser (*swipe*) ke kiri .
* **Download:** Fitur unduh tersedia namun masih dalam tahap pengembangan .

---

## HALAMAN PENGATURAN

* **Ganti Password:** Tombol untuk mengubah kata sandi akun .
* **Logout:** Keluar dari aplikasi dengan konfirmasi melalui *Pop Up* .

---

## HALAMAN ERROR

* **Penyebab:** Muncul ketika tidak ada sinyal atau sinyal lemah .
* **Pemulihan:** Halaman otomatis kembali normal jika sinyal membaik .

---

## BAB VII: SOURCE CODE

* **Github:** `bit.ly/summit_docs` (Butuh akses developer) .
* **Build App:** `bit.ly/Aplikasi-summit-docs` .
