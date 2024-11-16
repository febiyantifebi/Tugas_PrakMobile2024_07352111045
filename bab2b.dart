// Enum untuk Jabatan Karyawan
enum Jabatan { Developer, Manager, Admin }

// Abstract class Karyawan
abstract class Karyawan {
  String nama;
  int umur;
  double gaji;
  
  Karyawan(this.nama, this.umur, this.gaji);

  // Method abstrak yang harus diimplementasikan oleh subclass
  void bekerja();
  
  // Getter dan Setter untuk gaji
  double get getGaji => gaji;
  set setGaji(double gajiBaru) => gaji = gajiBaru;

}

// Subclass Developer
class Developer extends Karyawan {
  String bahasaPemrograman;
  
  Developer(String nama, int umur, double gaji, this.bahasaPemrograman)
      : super(nama, umur, gaji);

  @override
  void bekerja() {
    print('$nama bekerja sebagai Developer dengan bahasa pemrograman $bahasaPemrograman');
  }
}

// Subclass Manager
class Manager extends Karyawan {
  String tim;
  
  Manager(String nama, int umur, double gaji, this.tim)
      : super(nama, umur, gaji);

  @override
  void bekerja() {
    print('$nama bekerja sebagai Manager memimpin tim $tim');
  }
}

// Subclass Admin
class Admin extends Karyawan {
  Admin(String nama, int umur, double gaji) : super(nama, umur, gaji);

  @override
  void bekerja() {
    print('$nama bekerja sebagai Admin yang mengelola sistem');
  }
}


// Mixin untuk Kinerja
mixin Kinerja {
  int produktivitas = 100;

  // Method untuk meningkatkan produktivitas
  void tingkatkanProduktivitas() {
    if (produktivitas < 100) {
      produktivitas += 10;
      print('Produktivitas meningkat menjadi $produktivitas');
    } else {
      print('Produktivitas sudah maksimal!');
    }
  }
}

// Kelas Proyek
class Proyek {
  String namaProyek;
  int durasiHari;
  Jabatan peranKaryawan;
  
  Proyek(this.namaProyek, this.durasiHari, this.peranKaryawan);
  
  // Method untuk memastikan karyawan bisa bekerja di proyek
  void jalankanProyek() {
    print('Proyek $namaProyek dengan durasi $durasiHari hari dimulai');
  }
}

// Kelas untuk Manajemen Karyawan
class ManajemenKaryawan {
  List<Karyawan> daftarKaryawan = [];
  
  // Menambahkan karyawan
  void tambahKaryawan(Karyawan karyawan) {
    daftarKaryawan.add(karyawan);
  }

  // Menampilkan daftar karyawan
  void tampilkanKaryawan() {
    for (var karyawan in daftarKaryawan) {
      print('Nama: ${karyawan.nama}, Jabatan: ${karyawan.runtimeType}');
    }
  }
}

void main() {
  // Membuat karyawan
  var dev = Developer('Natan', 25, 8000000, 'Dart');
  var manager = Manager('Rafa', 35, 12000000, 'IT');
  var admin = Admin('Febi', 28, 6000000);

  // Menerapkan mixin Kinerja
  // dev.tingkatkanProduktivitas();
  // manager.tingkatkanProduktivitas();
  

  // Membuat proyek
  var proyek1 = Proyek('Proyek IT', 30, Jabatan.Developer);

  // Manajemen Karyawan
  var manajemen = ManajemenKaryawan();
  manajemen.tambahKaryawan(dev);
  manajemen.tambahKaryawan(manager);
  manajemen.tambahKaryawan(admin);

  // Menampilkan karyawan
  manajemen.tampilkanKaryawan();

  // Jalankan proyek
  proyek1.jalankanProyek();

  // Karyawan bekerja
  dev.bekerja();
  manager.bekerja();
  admin.bekerja();
}

