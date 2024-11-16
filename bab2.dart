enum KategoriProduk { DataManagement, NetworkAutomation }
enum Role { Developer, NetworkEngineer, Manager }
enum FaseProyek { Perencanaan, Pengembangan, Evaluasi }

mixin Kinerja {
  int produktivitas = 100;

  void perbaruiProduktivitas(int nilai, Role role) {
    produktivitas += nilai;
    produktivitas = produktivitas.clamp(0, 100);
    if (role == Role.Manager && produktivitas < 85) {
      produktivitas = 85;  // Minimum produktivitas untuk Manager adalah 85
    }
  }
}

class ProdukDigital {
  final String namaProduk;
  double harga;
  final KategoriProduk kategori;
  int jumlahTerjual;

  ProdukDigital(this.namaProduk, this.harga, this.kategori, {this.jumlahTerjual = 0}) {
    if (kategori == KategoriProduk.NetworkAutomation && harga < 200000) {
      throw Exception('Harga NetworkAutomation harus minimal 200.000');
    } else if (kategori == KategoriProduk.DataManagement && harga >= 200000) {
      throw Exception('Harga DataManagement harus di bawah 200.000');
    }
  }

  void terapkanDiskon() {
    if (kategori == KategoriProduk.NetworkAutomation && jumlahTerjual > 50) {
      harga *= 0.85;  // Diskon 15%
      if (harga < 200000) {
        harga = 200000; // Harga minimum setelah diskon
      }
    }
  }
}

abstract class Karyawan {
  String nama;
  int umur;
  Role role;

  Karyawan(this.nama, {required this.umur, required this.role});

  void bekerja();
}

class KaryawanTetap extends Karyawan with Kinerja {
  KaryawanTetap(String nama, {required int umur, required Role role})
      : super(nama, umur: umur, role: role);

  @override
  void bekerja() {
    print('$nama (Karyawan Tetap) sedang bekerja.');
  }
}

class KaryawanKontrak extends Karyawan with Kinerja {
  KaryawanKontrak(String nama, {required int umur, required Role role})
      : super(nama, umur: umur, role: role);

  @override
  void bekerja() {
    print('$nama (Karyawan Kontrak) sedang bekerja pada proyek.');
  }
}

class Proyek {
  FaseProyek faseSaatIni = FaseProyek.Perencanaan;
  int hariDikerjakan = 0;
  List<Karyawan> timProyek = [];

  void tambahKaryawan(Karyawan karyawan) {
    timProyek.add(karyawan);
  }

  void lanjutKeFaseBerikutnya() {
    if (faseSaatIni == FaseProyek.Perencanaan && timProyek.length >= 5) {
      faseSaatIni = FaseProyek.Pengembangan;
    } else if (faseSaatIni == FaseProyek.Pengembangan && hariDikerjakan > 45) {
      faseSaatIni = FaseProyek.Evaluasi;
    } else {
      print('Syarat belum terpenuhi untuk melanjutkan ke fase berikutnya.');
    }
  }
}

class Perusahaan {
  List<Karyawan> daftarKaryawanAktif = [];
  List<Karyawan> daftarKaryawanNonAktif = [];
  static const int batasKaryawanAktif = 20;

  void tambahKaryawan(Karyawan karyawan) {
    if (daftarKaryawanAktif.length < batasKaryawanAktif) {
      daftarKaryawanAktif.add(karyawan);
    } else {
      print('Batas maksimum karyawan aktif tercapai.');
    }
  }

  void karyawanResign(Karyawan karyawan) {
    daftarKaryawanAktif.remove(karyawan);
    daftarKaryawanNonAktif.add(karyawan);
  }
}

void main() {
  // Produk Digital
  var produk1 = ProdukDigital("Sistem Manajemen Data", 150000, KategoriProduk.DataManagement, jumlahTerjual: 10);
  var produk2 = ProdukDigital("Sistem Otomasi Jaringan", 250000, KategoriProduk.NetworkAutomation, jumlahTerjual: 60);
  
  produk2.terapkanDiskon();
  print("Harga setelah diskon produk2: ${produk1.harga}");

  // Karyawan
  var karyawan1 = KaryawanTetap("Natan", umur: 26, role: Role.Manager);
  var karyawan2 = KaryawanKontrak("Rafa", umur: 23, role: Role.NetworkEngineer);

  karyawan1.perbaruiProduktivitas(-10, karyawan1.role); // Update produktivitas untuk karyawan1
  print("Produktivitas Natan setelah penurunan: ${karyawan1.produktivitas}");


  // Perusahaan
  var perusahaan = Perusahaan();
  perusahaan.tambahKaryawan(karyawan1);
  perusahaan.tambahKaryawan(karyawan2);
  perusahaan.karyawanResign(karyawan1);
  print("Total Karyawan Aktif: ${perusahaan.daftarKaryawanAktif.length}");
  print("Total Karyawan Non-Aktif: ${perusahaan.daftarKaryawanNonAktif.length}");

  // Proyek
  var proyek = Proyek();
  proyek.tambahKaryawan(karyawan2);
  proyek.hariDikerjakan = 50;
  proyek.lanjutKeFaseBerikutnya();
  print("Fase proyek saat ini: ${proyek.faseSaatIni}");
}


