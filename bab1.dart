import 'dart:async';

class User {
  String name;
  int age;
  late List<Product>? products; 
  Role? role;

  User(this.name, this.age);
}

class Product {
  final String productName;
  final double price;
  bool inStock;

  Product({required this.productName, required this.price, this.inStock = true});
}


enum Role { Admin, Customer } //menandai peran pengguna sehingga setiap pengguna dapat memiliki hak akses yang berbeda.

class AdminUser extends User {
  AdminUser(String name, int age) : super(name, age) {
    role = Role.Admin;
  }

  //menggunakan exception handling (`try`, `catch`) untuk menangani produk yang stoknya sudah habis
  void addProduct(Map<String, Product> productList, Product product) {
    try {
      if (!product.inStock) {
        throw Exception("Produk '${product.productName}' sudah tidak tersedia dalam stok.");
      }

      productList[product.productName] = product;
      products = productList.values.toSet().toList(); // Menggunakan Set untuk memastikan produk unik
      print("Produk '${product.productName}' berhasil ditambahkan.");
    } on Exception catch (e) {
      print("Gagal menambahkan produk: $e");
    }
  }

  void removeProduct(Map<String, Product> productList, String productName) {
    productList.remove(productName);
    products = productList.values.toSet().toList();
    print("Produk '$productName' berhasil dihapus.");
  }
}

class CustomerUser extends User {
  CustomerUser(String name, int age) : super(name, age) {
    role = Role.Customer;
  }

  void viewProducts() {
    print("Daftar Produk Tersedia:");
    //agar baru diinisialisasi setelah objek dibuat
    products?.forEach((product) {
      print("- ${product.productName}, Harga: Rp${product.price}, Stok: ${product.inStock ? "Tersedia" : "Tidak tersedia"}");
    });
  }
}

// Fungsi Asynchronous untuk Fetching Data Produk
Future<Product> fetchProductDetails(String productName, double price) async {
  await Future.delayed(Duration(seconds: 2)); // Simulasi pengambilan data dari server
  return Product(productName: productName, price: price);
}

void main() async {
  //Collection `Map` dan `Set`
  // Daftar Produk dalam Map
  Map<String, Product> productList = {};

  // Admin User
  var admin = AdminUser("Admin", 30);

  // Fetch data produk secara asinkron dan tambahkan ke dalam daftar
  Product fetchedProduct = await fetchProductDetails("Laptop", 15000000);
  admin.addProduct(productList, fetchedProduct);

  fetchedProduct = await fetchProductDetails("Smartphone", 5000000);
  admin.addProduct(productList, fetchedProduct);

  // Set up produk awal yang sudah out of stock
  var outOfStockProduct = Product(productName: "Headphones", price: 1000000, inStock: false);
  admin.addProduct(productList, outOfStockProduct); // Memicu exception karena produk tidak tersedia

  // Customer User
  var customer = CustomerUser("Customer", 25);
  customer.products = productList.values.toList(); // Inisialisasi produk untuk customer
  customer.viewProducts();

  // Admin menghapus produk
  admin.removeProduct(productList, "Headphones");

  // Tampilkan produk setelah penghapusan
  print("\nDaftar Produk Setelah Penghapusan oleh Admin:");
  customer.viewProducts();
}

