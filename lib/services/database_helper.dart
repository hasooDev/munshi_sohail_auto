// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// import '../models/admin/category_model.dart'; // ✅ Add this (create the model file too)
// import '../models/admin/company_model.dart';
// import '../models/admin/product _model.dart';
// import '../models/user/user_model.dart';

// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper._internal();
//   factory DatabaseHelper() => _instance;
//   DatabaseHelper._internal();

//   static Database? _database;

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDB("Munshi_sohail_auto.db");
//     return _database!;
//   }

//   Future<Database> _initDB(String filePath) async {
//     final path = await getDatabasesPath();
//     final dbPath = join(path, filePath);

//     return await openDatabase(
//       dbPath,
//       version: 5,
//       onCreate: _onCreate,
//       onUpgrade: _onUpgrade,
//     );
//   }

//   Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
//     print('Upgrading DB from version $oldVersion to $newVersion');

//     if (oldVersion < 2) {
//       await db.execute('ALTER TABLE companies ADD COLUMN description TEXT');
//     }

//     if (oldVersion < 3) {
//       await db.execute('''
//         CREATE TABLE categories (
//           id INTEGER PRIMARY KEY AUTOINCREMENT,
//           name TEXT NOT NULL,
//           imagePath TEXT,
//           companyId INTEGER NOT NULL,
//           FOREIGN KEY (companyId) REFERENCES companies(id)
//         )
//       ''');
//     }
//     if (oldVersion < 4) {
//       await db.execute('''
//     CREATE TABLE categories (
//       id INTEGER PRIMARY KEY AUTOINCREMENT,
//       name TEXT NOT NULL,
//       imagePath TEXT,
//       companyId INTEGER NOT NULL,
//       FOREIGN KEY (companyId) REFERENCES companies(id)
//     )
//   ''');
//     }
//     if (oldVersion < 5) {
//       // Drop and recreate products table without type
//       await db.execute("DROP TABLE IF EXISTS products");
//       await db.execute('''
//       CREATE TABLE products (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         name TEXT NOT NULL,
//         imagePath TEXT,
//         unit TEXT,
//         pricePerUnit REAL NOT NULL,
//         quantityInStock REAL NOT NULL,
//         categoryId INTEGER NOT NULL,
//         companyId INTEGER NOT NULL,
//         FOREIGN KEY (categoryId) REFERENCES categories(id),
//         FOREIGN KEY (companyId) REFERENCES companies(id)
//       )
//     ''');
//     }

//   }

//   Future<void> _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE companies (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         name TEXT NOT NULL,
//         imagePath TEXT
//       )
//     ''');

//     await db.execute('''
//   CREATE TABLE products (
//     id INTEGER PRIMARY KEY AUTOINCREMENT,
//     name TEXT NOT NULL,
//     imagePath TEXT,
//     pricePerUnit REAL NOT NULL,
//     quantityInStock REAL NOT NULL,
//     unit TEXT NOT NULL,
//     companyId INTEGER NOT NULL,
//     categoryId INTEGER NOT NULL,
//     FOREIGN KEY (companyId) REFERENCES companies(id),
//     FOREIGN KEY (categoryId) REFERENCES categories(id)
//   )
// ''');

//     await db.execute('''
//       CREATE TABLE users (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         email TEXT NOT NULL,
//         password TEXT NOT NULL,
//         role INTEGER NOT NULL
//       )
//     ''');

//     await db.execute('''
//       CREATE TABLE categories (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         name TEXT NOT NULL,
//         imagePath TEXT,
//         companyId INTEGER NOT NULL,
//         FOREIGN KEY (companyId) REFERENCES companies(id)
//       )
//     ''');

//     // Default users
//     await db.insert('users', {
//       'email': 'admin@gmail.com',
//       'password': 'admin123',
//       'role': 1,
//     });

//     await db.insert('users', {
//       'email': 'user@gmail.com',
//       'password': 'user123',
//       'role': 0,
//     });
//   }

//   // ---------------- User Auth ----------------
//   Future<UserModel?> authenticateUserByRole({
//     required String email,
//     required String password,
//     required int role,
//   }) async {
//     final db = await database;
//     List<Map<String, dynamic>> result = await db.query(
//       'users',
//       where: 'email = ? AND password = ? AND role = ?',
//       whereArgs: [email, password, role],
//     );

//     if (result.isNotEmpty) {
//       return UserModel.fromMap(result.first);
//     }
//     return null;
//   }

//   // ---------------- Company ----------------
//   Future<int> insertCompany(CompanyModel company) async {
//     final db = await database;
//     return await db.insert('companies', company.toMap());
//   }

//   Future<List<CompanyModel>> getCompanies() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('companies');
//     return maps.map((map) => CompanyModel.fromMap(map)).toList();
//   }

//   Future<int> updateCompany(CompanyModel company) async {
//     final db = await database;
//     return await db.update(
//       'companies',
//       company.toMap(),
//       where: 'id = ?',
//       whereArgs: [company.id],
//     );
//   }

//   Future<int> deleteCompany(int id) async {
//     final db = await database;
//     return await db.delete(
//       'companies',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }

//   // ---------------- Category ----------------
//   Future<int> insertCategory(CategoryModel category) async {
//     final db = await database;
//     return await db.insert('categories', category.toMap());
//   }

//   Future<List<CategoryModel>> getCategories() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('categories');
//     return maps.map((map) => CategoryModel.fromMap(map)).toList();
//   }

//   Future<int> updateCategory(CategoryModel category) async {
//     final db = await database;
//     return await db.update(
//       'categories',
//       category.toMap(),
//       where: 'id = ?',
//       whereArgs: [category.id],
//     );
//   }

//   Future<int> deleteCategory(int id) async {
//     final db = await database;
//     return await db.delete(
//       'categories',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }
//   // ---------------- Product ----------------
//   Future<int> insertProduct(ProductModel product) async {
//     final db = await database;
//     return await db.insert('products', product.toMap());
//   }

//   Future<List<ProductModel>> getProducts() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('products');
//     return maps.map((map) => ProductModel.fromMap(map)).toList();
//   }

//   Future<int> updateProduct(ProductModel product) async {
//     final db = await database;
//     return await db.update(
//       'products',
//       product.toMap(),
//       where: 'id = ?',
//       whereArgs: [product.id],
//     );
//   }

//   Future<int> deleteProduct(int id) async {
//     final db = await database;
//     return await db.delete(
//       'products',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }

// }
import 'package:path/path.dart';
import 'package:sohail_auto/models/admin/consumer_data_model.dart';
import 'package:sqflite/sqflite.dart';

import '../models/admin/category_model.dart';
import '../models/admin/company_model.dart';
import '../models/admin/product _model.dart';
import '../models/user/customer_model.dart';
import '../models/user/user_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("Munshi_sohail_auto.db");
    return _database!;
  }
Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
  Future<Database> _initDB(String filePath) async {
    final path = await getDatabasesPath();
    final dbPath = join(path, filePath);

    return await openDatabase(
      dbPath,
      version: 7, // 🔼 bump version
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('Upgrading DB from version $oldVersion to $newVersion');

    if (oldVersion < 2) {
      await db.execute('ALTER TABLE companies ADD COLUMN description TEXT');
    }

    if (oldVersion < 3) {
      await db.execute('''
        CREATE TABLE categories (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          imagePath TEXT,
          companyId INTEGER NOT NULL,
          FOREIGN KEY (companyId) REFERENCES companies(id)
        )
      ''');
    }

    if (oldVersion < 4) {
      await db.execute('''
        CREATE TABLE categories (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          imagePath TEXT,
          companyId INTEGER NOT NULL,
          FOREIGN KEY (companyId) REFERENCES companies(id)
        )
      ''');
    }

    if (oldVersion < 5) {
      await db.execute("DROP TABLE IF EXISTS products");
      await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        imagePath TEXT,
        unit TEXT,
        pricePerUnit REAL NOT NULL,
        quantityInStock REAL NOT NULL,
        categoryId INTEGER NOT NULL,
        companyId INTEGER NOT NULL,
        FOREIGN KEY (categoryId) REFERENCES categories(id),
        FOREIGN KEY (companyId) REFERENCES companies(id)
      )
    ''');
    }
if (oldVersion < 6) {
  await db.execute(
    'ALTER TABLE consumers ADD COLUMN shopName TEXT'
  );
}

    // if (oldVersion < 2) {
    //     await db.execute("DROP TABLE IF EXISTS consumers");
    //     await _onCreate(db, newVersion);
    //   }
    if (oldVersion < 6) {
      // ✅ Add consumers table
      await db.execute('''
    CREATE TABLE consumers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    phone TEXT,
    shopName TEXT,   -- ✅ fix spelling
    totalPrice REAL,
    paidAmount REAL,
    remainingAmount REAL,
    billImagePath TEXT,
    date TEXT
)      
    ''');
    }
    if (oldVersion < 7) { // bump DB version to 7
      await db.execute('''
    CREATE TABLE customers (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      phone TEXT,
      date TEXT
    )
  ''');
    }

  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE companies (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        imagePath TEXT
      )
    ''');

    await db.execute('''
  CREATE TABLE products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    imagePath TEXT,
    pricePerUnit REAL NOT NULL,
    quantityInStock REAL NOT NULL,
    unit TEXT NOT NULL,
    companyId INTEGER NOT NULL,
    categoryId INTEGER NOT NULL,
    FOREIGN KEY (companyId) REFERENCES companies(id),
    FOREIGN KEY (categoryId) REFERENCES categories(id)
  )
''');

    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL,
        password TEXT NOT NULL,
        role INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        imagePath TEXT,
        companyId INTEGER NOT NULL,
        FOREIGN KEY (companyId) REFERENCES companies(id)
      )
    ''');

    await db.execute('''
CREATE TABLE consumers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    phone TEXT,
    shopName TEXT,   -- ✅ fix spelling
    totalPrice REAL,
    paidAmount REAL,
    remainingAmount REAL,
    billImagePath TEXT,
    date TEXT
)

''');
    await db.execute('''
  CREATE TABLE customers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    phone TEXT,
    date TEXT
  )
''');



    // Default users
    await db.insert('users', {
      'email': 'admin@gmail.com',
      'password': 'admin123',
      'role': 1,
    });

    await db.insert('users', {
      'email': 'user@gmail.com',
      'password': 'user123',
      'role': 0,
    });
  }

  // ---------------- User Auth ----------------
  Future<UserModel?> authenticateUserByRole({
    required String email,
    required String password,
    required int role,
  }) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ? AND password = ? AND role = ?',
      whereArgs: [email, password, role],
    );

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }
    return null;
  }

  // ---------------- Company ----------------
  Future<int> insertCompany(CompanyModel company) async {
    final db = await database;
    return await db.insert('companies', company.toMap());
  }

  Future<List<CompanyModel>> getCompanies() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('companies');
    return maps.map((map) => CompanyModel.fromMap(map)).toList();
  }

  Future<int> updateCompany(CompanyModel company) async {
    final db = await database;
    return await db.update(
      'companies',
      company.toMap(),
      where: 'id = ?',
      whereArgs: [company.id],
    );
  }

  Future<int> deleteCompany(int id) async {
    final db = await database;
    return await db.delete('companies', where: 'id = ?', whereArgs: [id]);
  }

  // ---------------- Category ----------------
  Future<int> insertCategory(CategoryModel category) async {
    final db = await database;
    return await db.insert('categories', category.toMap());
  }

  Future<List<CategoryModel>> getCategories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('categories');
    return maps.map((map) => CategoryModel.fromMap(map)).toList();
  }

  Future<int> updateCategory(CategoryModel category) async {
    final db = await database;
    return await db.update(
      'categories',
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  Future<int> deleteCategory(int id) async {
    final db = await database;
    return await db.delete('categories', where: 'id = ?', whereArgs: [id]);
  }

  // ---------------- Product ----------------
  Future<int> insertProduct(ProductModel product) async {
    final db = await database;
    return await db.insert('products', product.toMap());
  }

  Future<List<ProductModel>> getProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('products');
    return maps.map((map) => ProductModel.fromMap(map)).toList();
  }

  Future<int> updateProduct(ProductModel product) async {
    final db = await database;
    return await db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> deleteProduct(int id) async {
    final db = await database;
    return await db.delete('products', where: 'id = ?', whereArgs: [id]);
  }

  // ---------------- Consumer ----------------
  Future<int> insertConsumer(ConsumerModel consumer) async {
    final db = await database;
    return await db.insert('consumers', consumer.toMap());
  }

  Future<List<ConsumerModel>> getConsumers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('consumers');
    return maps.map((map) => ConsumerModel.fromMap(map)).toList();
  }

  Future<int> updateConsumer(ConsumerModel consumer) async {
    final db = await database;
    return await db.update(
      'consumers',
      consumer.toMap(),
      where: 'id = ?',
      whereArgs: [consumer.id],
    );
  }

  Future<int> deleteConsumer(int id) async {
    final db = await database;
    return await db.delete('consumers', where: 'id = ?', whereArgs: [id]);
  }
  // ---------------- Customer ----------------
  Future<int> insertCustomer(Customermodel customer) async {
    final db = await database;
    return await db.insert('customers', customer.toMap());
  }

  Future<List<Customermodel>> getCustomers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('customers');
    return maps.map((map) => Customermodel.fromMap(map)).toList();
  }

  Future<int> updateCustomer(Customermodel customer) async {
    final db = await database;
    return await db.update(
      'customers',
      customer.toMap(),
      where: 'id = ?',
      whereArgs: [customer.id],
    );
  }

  Future<int> deleteCustomer(int id) async {
    final db = await database;
    return await db.delete('customers', where: 'id = ?', whereArgs: [id]);
  }

}
