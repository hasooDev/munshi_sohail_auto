//
// import 'dart:io';
//
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// import '../models/company_model.dart';
//
// class SupabaseService {
//   final supabase = Supabase.instance.client;
//
//   /// Add company
//   Future<void> addCompany(Company company) async {
//     await supabase.from('companies').insert(company.toJson());
//   }
//
//   /// Get all companies
//   Future<List<Company>> fetchCompanies() async {
//     final response = await supabase.from('companies').select();
//     return (response as List).map((json) => Company.fromJson(json)).toList();
//   }
//
//   /// Delete company by ID
//   Future<void> deleteCompany(String id) async {
//     await supabase.from('companies').delete().eq('id', id);
//   }
//
//   /// Upload image to Supabase storage
//   Future<String> uploadImage(String path, String fileName) async {
//     final fileBytes = await File(path).readAsBytes();
//     final response = await supabase.storage
//         .from('company_images')
//         .uploadBinary(fileName, fileBytes);
//
//     final publicUrl = supabase.storage
//         .from('company_images')
//         .getPublicUrl(fileName);
//
//     return publicUrl;
//   }
// }
