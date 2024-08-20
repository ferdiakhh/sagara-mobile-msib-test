# WeatherWise

**WeatherWise** adalah aplikasi mobile sederhana yang dibangun menggunakan Flutter. Aplikasi ini memungkinkan pengguna untuk melihat kondisi cuaca saat ini, prakiraan cuaca 3 hari ke depan, cuaca di beberapa kota besar dunia, dan mencari cuaca di lokasi tertentu. Aplikasi ini juga menyediakan fitur untuk menyimpan lokasi favorit sehingga pengguna dapat memantau cuaca di lokasi tersebut dengan mudah.

# Fitur Utama

- **Kondisi Cuaca Saat Ini**: Menampilkan suhu, kelembapan, kecepatan angin, dan kondisi cuaca lainnya berdasarkan lokasi pengguna atau lokasi yang dicari.
- **Prakiraan Cuaca 3 Hari Ke Depan**: Menampilkan prakiraan cuaca untuk 3 hari mendatang di lokasi yang dipilih.
- **Cuaca di Kota-Kota Besar Dunia**: Menampilkan informasi cuaca di beberapa kota besar dunia, seperti Mekkah, Manchester, Rio de Janeiro, Munich, dan Sydney.
- **Pencarian Lokasi**: Pengguna dapat mencari cuaca di kota atau lokasi tertentu dengan menggunakan fitur pencarian.
- **Favorit**: Pengguna dapat menambahkan lokasi favorit untuk memantau cuaca di lokasi tersebut dengan cepat.
- **Error Handling**: Aplikasi ini menangani kesalahan seperti koneksi internet yang hilang dengan menampilkan dialog peringatan kepada pengguna.

# Teknologi yang Digunakan

- **Flutter**: Framework utama untuk membangun antarmuka pengguna.
- **Provider**: State management untuk mengelola data aplikasi.
- **Geolocator & Geocoding**: Untuk mendapatkan lokasi pengguna dan mengubah nama kota menjadi koordinat.
- **SharedPreferences**: Menyimpan data favorit secara lokal pada perangkat.


# Struktur Proyek


lib/
│
├── models/                   # Model data aplikasi (Weather, WeatherForecast)
├── providers/                # Provider untuk state management
├── screens/                  # Layar utama aplikasi (SplashScreen, HomeScreen, DetailScreen, FavoriteScreen)
├── services/                 # Layanan untuk API cuaca, lokasi, dll.
├── widgets/                  # Widget khusus seperti WeatherCard, SearchCityDialog
└── main.dart                 # Titik masuk aplikasi

# Cara Menggunakan

- **Splash Screen**: Saat pertama kali membuka aplikasi, pengguna akan disambut dengan splash screen. Klik tombol "Discover the weather" untuk masuk ke home screen.
- **Home Screen**: Menampilkan informasi cuaca berdasarkan lokasi pengguna saat ini, cuaca di kota-kota besar dunia, serta prakiraan cuaca 3 hari ke depan.
- **Pencarian Lokasi**: Gunakan ikon pencarian di home screen untuk mencari cuaca di kota atau lokasi tertentu. Masukkan nama kota atau lokasi, dan aplikasi akan menampilkan cuaca di lokasi tersebut.
- **Detail Screen**: Ketika pengguna memilih lokasi tertentu, mereka akan diarahkan ke detail screen yang menunjukkan informasi cuaca lebih rinci.
- **Favorites**: Pengguna dapat menambahkan lokasi ke daftar favorit dengan menekan tombol "Add to Favorites" pada detail screen.

## Error Handling

Aplikasi ini telah dilengkapi dengan penanganan kesalahan. Jika terjadi masalah seperti hilangnya koneksi internet, aplikasi akan menampilkan dialog peringatan kepada pengguna dan tidak akan crash.

## UI/UX

Desain antarmuka aplikasi ini dibuat dengan fokus pada kesederhanaan dan kemudahan penggunaan. Warna-warna yang digunakan serta tata letak yang bersih memastikan pengalaman pengguna yang menyenangkan.
