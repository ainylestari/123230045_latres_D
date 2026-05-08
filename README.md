# latres_tpm

## Aplikasi Online Shop Flutter

Aplikasi ini merupakan latihan responsi Flutter dengan tema toko online menggunakan API eksternal dari DummyJSON.

## Fitur Utama

### Login
- Username bebas input user
- Password wajib menggunakan NIM
- Session disimpan menggunakan SharedPreferences

### Auto Login
- Jika user belum logout, saat aplikasi dibuka kembali akan langsung masuk ke halaman utama

### Home
- Menampilkan username yang sedang login
- Menampilkan list produk dari API eksternal
- Tombol menuju Cart
- Klik produk menuju Detail Product

### Detail Product
- Menampilkan detail lengkap produk
- Fitur tambah dan kurang quantity
- Tombol Add to Cart

### Cart
- Data cart disimpan menggunakan Hive
- Cart berbeda untuk setiap username
- Terdapat fitur hapus item cart

### Profile
- Menampilkan username
- Deskripsi bebas
- Tombol logout

## Package yang Digunakan

- http
- shared_preferences
- hive
- hive_flutter