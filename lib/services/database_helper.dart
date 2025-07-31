import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/admin/category_model.dart'; // ✅ Add this (create the model file too)
import '../models/admin/company_model.dart';
import '../models/admin/product _model.dart';
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

  Future<Database> _initDB(String filePath) async {
    final path = await getDatabasesPath();
    final dbPath = join(path, filePath);

    return await openDatabase(
      dbPath,
      version: 5,
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
      // Drop and recreate products table without type
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
    return await db.delete(
      'companies',
      where: 'id = ?',
      whereArgs: [id],
    );
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
    return await db.delete(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
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
    return await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}
