import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:qlcv/src/resources/widgets/ngaycuatoi.dart';

import '../../blocs/auth_bloc.dart';

class HomeChitiet extends StatefulWidget {
  String Contact_Key;
  String Contact_KeyDanhMuc;
  String Contact_name;
  String Contact_trangthai;
  HomeChitiet({required this.Contact_Key,required this.Contact_name,required this.Contact_KeyDanhMuc,required this.Contact_trangthai});

  @override
  State<HomeChitiet> createState() => _HomeChitietState();
}


class _HomeChitietState extends State<HomeChitiet> {
  TextEditingController _infoController = TextEditingController();
  AuthBloc authBloc = new AuthBloc();
  String userId ="S4unFZXcAvXSjeSUhb4ZkueN7Oi2";


  //DatabaseReference db_Ref = FirebaseDatabase.instance.ref();
  void _showInputDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Nhập thông tin'),
          content: TextField(
            controller: _infoController,
            decoration: InputDecoration(labelText: 'Thông tin'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Đóng dialog
              },
              child: Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_infoController.text.isNotEmpty) {
                  // Kiểm tra trường thông tin không trống
                  authBloc.createchitietCV(userId, widget.Contact_Key, _infoController.text);
                  _infoController.text = "";
                  Navigator.pop(context);
                } else {
                  // Hiển thị thông báo nếu trường thông tin trống
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Lỗi'),
                        content: Text('Vui lòng nhập thông tin trước khi lưu.'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Lưu'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:
      SafeArea(

        child: Container(
          height: double.infinity,
          color: Colors.black,
          padding: const  EdgeInsets.only(top: 30,left: 10,right: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Canh giữa theo chiều ngang

                  children: [
                    Text( "Chi Tiết Công Việc: ${widget.Contact_name}",style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),)
                  ],),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back,color: Colors.white,),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text('Quay lại', style: TextStyle(
                      color: Colors.white, // Màu sắc cho văn bản
                    ),),
                  ],
                ),


                FirebaseAnimatedList(

                    query: authBloc.db_Ref.child('chitietcv').child(userId).child(widget.Contact_Key),
                    shrinkWrap: true,
                    itemBuilder: (context,snapshot,animation, index){
                      Map Contact = snapshot.value as Map;
                      Contact['key'] = snapshot.key;
                      bool trangThai = authBloc.convertToBool(Contact['trangthai']);

                      print(Contact['congviec']);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child:  ElevatedButton.icon(
                                    onPressed: () {
                                      // Xử lý khi nút được nhấn
                                      print(  Contact['name']);
                                      print(  Contact['key']);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(3.0),
                                      primary: Colors.blueGrey, // Màu nền của nút
                                    ),
                                    icon: Icon(
                                      Icons.border_color, // Chọn biểu tượng mong muốn
                                      size: 24.0,color: Colors.blue[200],
                                    ),
                                    label:Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(Contact['congviec'].toString(),
                                            style: TextStyle(fontSize: 18.0,color: Colors.white),
                                          ),
                                        ),

                                            IconButton(onPressed: (){
                                              authBloc.XoaDuLieu(userId, widget.Contact_Key, Contact['key']);
                                             // db_Ref?.child(userId).child(widget.Contact_Key).child(Contact['key']).remove();
                                            },
                                                icon: Icon(Icons.delete_forever)),


                                      ],
                                    )
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      );
                    }
                ),
                const Divider(
                  thickness: 0.5,
                  color: Colors.white,
                  height: 9,
                ),
                Row(
                  children: [

                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          authBloc.createNgayCuaToi(userId,widget.Contact_KeyDanhMuc,widget.Contact_Key,widget.Contact_name,widget.Contact_trangthai);

                          // Xử lý khi nút được nhấn
                          print('Tác vụ');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(16.0),
                          primary: Colors.black, // Màu nền của nút
                        ),
                        icon: Icon(
                          Icons.sunny, // Chọn biểu tượng mong muốn
                          size: 24.0,color: Colors.blue[200],
                        ),

                        label: const  Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Thêm vào Ngày của Tôi',
                            style: TextStyle(fontSize: 18.0,color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const Divider(
                  thickness: 0.5,
                  color: Colors.white,
                  height: 9,
                ),
                Row(
                  children: [

                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Xử lý khi nút được nhấn
                          print('Tác vụ');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(16.0),
                          primary: Colors.black, // Màu nền của nút
                        ),
                        icon: Icon(
                          Icons.notifications, // Chọn biểu tượng mong muốn
                          size: 24.0,color: Colors.blue[200],
                        ),

                        label: const  Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Nhắc tôi',
                            style: TextStyle(fontSize: 18.0,color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [

                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Xử lý khi nút được nhấn
                          print('Tác vụ');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(16.0),
                          primary: Colors.black, // Màu nền của nút
                        ),
                        icon: Icon(
                          Icons.date_range, // Chọn biểu tượng mong muốn
                          size: 24.0,color: Colors.blue[200],
                        ),

                        label: const  Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Thêm ngày đến hạng',
                            style: TextStyle(fontSize: 18.0,color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 0.5,
                  color: Colors.white,
                  height: 9,
                ),
                Row(
                  children: [

                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Xử lý khi nút được nhấn
                          print('Tác vụ');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(16.0),
                          primary: Colors.black, // Màu nền của nút
                        ),
                        icon: Icon(
                          Icons.edit_calendar_rounded, // Chọn biểu tượng mong muốn
                          size: 24.0,color: Colors.blue[200],
                        ),

                        label: const  Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Ghi chú',
                            style: TextStyle(fontSize: 18.0,color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              ],

            ),
          ),
        ),

      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  _showInputDialog();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigo[400], // Set the background color
                ),
                child:const  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add, // Replace with your desired icon
                      color: Colors.white,
                    ),
                    SizedBox(width: 8), // Adjust the spacing between icon and text
                    Text(
                      'Thêm Từng Công Việc',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            // Add more IconButton or ElevatedButton widgets as needed
          ],
        ),
      ),







    );
  }
}
