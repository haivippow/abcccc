import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../fire_base/fire_base_auth.dart';

class AuthBloc {
  var _firAuth = FirAuth();
  DatabaseReference db_Ref= FirebaseDatabase.instance.ref();

  var user = FirebaseAuth.instance.currentUser!;


  StreamController _nameController = new StreamController();
  StreamController _emailController = new StreamController();
  StreamController _passController = new StreamController();
  StreamController _phoneController = new StreamController();



  Stream get nameStream => _nameController.stream;
  Stream get emailStream => _emailController.stream;
  Stream get passStream => _passController.stream;
  Stream get phoneStream => _phoneController.stream;





  bool isValid(String name, String email, String pass, String phone) {
    if (name == null || name.length == 0) {
      _nameController.sink.addError("Nhập tên");
      return false;
    }
    _nameController.sink.add("");

    if (phone == null || phone.length == 0) {
      _phoneController.sink.addError("Nhập số điện thoại");
      return false;
    }
    _phoneController.sink.add("");

    if (email == null || email.length == 0) {
      _emailController.sink.addError("Nhập email");
      return false;
    }
    _emailController.sink.add("");

    if (pass == null || pass.length < 6) {
      _passController.sink.addError("Mật khẩu phải trên 5 ký tự");
      return false;
    }
    _passController.sink.add("");

    return true;
  }

  void signUp(String email, String pass, String phone, String name,
      Function onSuccess, Function(String) onError) {
    _firAuth.signUp(email, pass, name, phone, onSuccess, onError);
  }




  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) {
    _firAuth.signIn(email, pass, onSuccess, onSignInError);
  }

  void createDanhMuc(String userId,String nameDanhmuc ){
    _firAuth.createDanhMuc(userId, nameDanhmuc);
  }
  void createCV(String userId,String nameDanhmuc,String nameCV){
    _firAuth.createCV(userId, nameDanhmuc, nameCV);
  }

  bool convertToBool(dynamic value) {
    if (value is bool) {
      return value;
    } else if (value is String) {
      // Kiểm tra nếu là chuỗi "true" (không phân biệt hoa thường)
      return value.toLowerCase() == 'true';
    } else if (value is int) {
      // Kiểm tra nếu là số nguyên khác 0
      return value != 0;
    }
    // Trường hợp còn lại, trả về giá trị mặc định
    return false;
  }
  void capnhapTrangthaiCV(String userId,String keyDanhmuc ,String keyCV,String trangthai ){
    _firAuth.capnhapTrangthaiCV(userId, keyDanhmuc, keyCV, trangthai);
  }
  void createchitietCV(String userId,String keyCV,String chitietCV){
    _firAuth.createchitietCV(userId, keyCV, chitietCV );
  }
  void XoaDuLieu(String userId , String Key,String Key1){
    _firAuth.XoaDuLieuCongviec(userId, Key, Key1);
  }

  void XoaDLDanhMuc(String userId , String Key, String Key1){
    _firAuth.XoaDulieuDanhmuc(userId, Key,Key1);
  }

  void createNgayCuaToi(String userId,String key_danhmuc,String key_congviec,String nameCV,String trangthai){
    _firAuth.createNgayCuaToi(userId, key_danhmuc, key_congviec, nameCV, trangthai);
  }


  void CapnhaptrangthaiNgayCuaToi(String userId,String Key ,String trangthai ){
    _firAuth.CapnhaptrangthaiNgayCuaToi(userId, Key, trangthai);

  }
  void LogOut(){
    _firAuth.signOut();
  }

  void dispose() {
    _nameController.close();
    _emailController.close();
    _passController.close();
    _phoneController.close();


  }


}
