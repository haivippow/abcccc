import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirAuth {
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;


  // final user = FirebaseAuth.instance.currentUser!;

  void signUp(String email, String pass, String name, String phone,
      Function onSuccess, Function(String) onRegisterError) {
    _fireBaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((user) {

      _createUser(user.user!.uid, name, phone, email,pass,onSuccess, onRegisterError);
    }).catchError((err) {
      print("err: " + err.toString());
      _onSignUpErr(err.code, onRegisterError);
    });
  }

  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) {
    _fireBaseAuth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      onSuccess();
    }).catchError((err) {
      print("err: " + err.toString());
      onSignInError("Sign-In fail, please try again");
    });
  }

  _createUser(String userId, String name, String phone, String email,String pass ,Function onSuccess,
      Function(String) onRegisterError) {
    var user = Map<String, String>();
    user["name"] = name;
    user["phone"] = phone;
    user["email"] = email;
    user['pass'] = pass;

    var ref = FirebaseDatabase.instance.reference().child("users");
    ref.child(userId).set(user).then((vl) {
      print("on value: SUCCESSED");
      onSuccess();
    }).catchError((err) {
      print("err: " + err.toString());
      onRegisterError("SignUp fail, please try again");
    }).whenComplete(() {
      print("completed");
    });
  }

  void createDanhMuc(String userId,String nameDanhmuc ){
    var user = Map<String, String>();
    user["name"] = nameDanhmuc;
    var ref = FirebaseDatabase.instance.reference().child("danhmuc").child(userId);
    ref.push().set(user).then((vl) {
      print("on value: SUCCESSED");
      
    }).catchError((err) {
      print("err: " + err.toString());
    
    }).whenComplete(() {
      print("completed");
    });
  }
  void createCV(String userId,String keyDanhmuc ,String nameCV){
    var user = Map<String, String>();
    user["name"] = nameCV;
    user["trangthai"] = "false";
    var ref = FirebaseDatabase.instance.reference().child("congviec").child(userId).child(keyDanhmuc);
    ref.push().set(user).then((vl) {
      print("on value: SUCCESSED");

    }).catchError((err) {
      print("err: " + err.toString());

    }).whenComplete(() {
      print("completed");
    });
  }

  void capnhapTrangthaiCV(String userId,String keyDanhmuc ,String keyCV,String trangthai ){
    var ref = FirebaseDatabase.instance.reference().child("congviec").child(userId).child(keyDanhmuc);
    ref.child(keyCV).update({
      "trangthai":trangthai,
    });
  }

  void createchitietCV(String userId,String keyCV,String chitietCV){
    var user = Map<String, String>();
    user["congviec"] = chitietCV;

    var ref = FirebaseDatabase.instance.reference().child("chitietcv").child(userId).child(keyCV);
    ref.push().set(user).then((vl) {
      print("on value: SUCCESSED");

    }).catchError((err) {
      print("err: " + err.toString());

    }).whenComplete(() {
      print("completed");
    });
  }


  void XoaDuLieuCongviec(String userId, String Key, String Key1) {
   var ref = FirebaseDatabase.instance.reference().child('chitietcv');
    ref.child(userId).child(Key).child(Key1).remove().then((_) {
      print("Xoá dữ liệu thành công");
    }).catchError((error) {
      print("Lỗi khi xoá dữ liệu: $error");
    });
  }
  void XoaDulieuDanhmuc(String userId,String Key,String Key1){
    var ref = FirebaseDatabase.instance.reference().child('congviec');
    ref.child(userId).child(Key).child(Key1).remove().then((_) {
      print("Xoá dữ liệu thành công");
    }).catchError((error) {
      print("Lỗi khi xoá dữ liệu: $error");
    });
  }

  void createNgayCuaToi(String userId,String key_danhmuc,String key_congviec,String nameCV,String trangthai){
    var user = Map<String, String>();
    user["key_danhmuc"] = key_danhmuc;
    user["key_congviec"] = key_congviec;
    user["name_congviec"] = nameCV;
    user["trangthai"] = trangthai;

    var ref = FirebaseDatabase.instance.reference().child("ngaycuatoi").child(userId);
    ref.child(key_congviec).set(user).then((vl) {
      print("on value: SUCCESSED");

    }).catchError((err) {
      print("err: " + err.toString());

    }).whenComplete(() {
      print("completed");
    });
  }

  void CapnhaptrangthaiNgayCuaToi(String userId,String Key ,String trangthai ){
    var ref = FirebaseDatabase.instance.reference().child("ngaycuatoi").child(userId);
    ref.child(Key).update({
      "trangthai":trangthai,
    });
  }





  ///

  void _onSignUpErr(String code, Function(String) onRegisterError) {
    print(code);
    switch (code) {
      case "ERROR_INVALID_EMAIL":
      case "ERROR_INVALID_CREDENTIAL":
        onRegisterError("Invalid email");
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        onRegisterError("Email has existed");
        break;
      case "ERROR_WEAK_PASSWORD":
        onRegisterError("The password is not strong enough");
        break;
      default:
        onRegisterError("SignUp fail, please try again");
        break;
    }
  }

  Future<void> signOut() async {
    print("signOut");
    return _fireBaseAuth.signOut();
  }


}
