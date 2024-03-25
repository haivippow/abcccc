import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:qlcv/src/resources/widgets/home_chitietcv.dart';

import '../../blocs/auth_bloc.dart';

class NgayCuaToi extends StatefulWidget {
  const NgayCuaToi({super.key});

  @override
  State<NgayCuaToi> createState() => _NgayCuaToiState();
}


class _NgayCuaToiState extends State<NgayCuaToi> {
  TextEditingController _infoController = TextEditingController();
  AuthBloc authBloc = new AuthBloc();
  String userId ="S4unFZXcAvXSjeSUhb4ZkueN7Oi2";





  DatabaseReference db_Ref =
  FirebaseDatabase.instance.ref().child('ngaycuatoi');

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
              onPressed: (){

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
                    Text( "Danh Mục: ",style: TextStyle(
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
                    query: db_Ref.child(userId),

                    shrinkWrap: true,
                    itemBuilder: (context,snapshot,animation, index){
                      Map Contact = snapshot.value as Map;
                      Contact['key'] = snapshot.key;
                      bool trangThai = authBloc.convertToBool(Contact['trangthai']);

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [

                                Expanded(
                                  child:  ElevatedButton.icon(
                                      onPressed: () {

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => HomeChitiet(
                                              Contact_Key: Contact['key'],Contact_name: Contact['name_congviec'], Contact_KeyDanhMuc: Contact['key_danhmuc'],Contact_trangthai:Contact['trangthai'] ,
                                            ),
                                          ),
                                        );
                                        // Xử lý khi nút được nhấn
                                        // print(  Contact['name']);
                                        // print(  Contact['key']);
                                        print(Contact['key_']);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(5.0),
                                        primary: Colors.blueGrey, // Màu nền của nút
                                      ),
                                      icon:      IconButton(
                                        icon: trangThai
                                            ? Icon(Icons.check_circle,color: Colors.white,)
                                            : Icon(Icons.circle,color: Colors.white,),
                                        onPressed: () {

                                          setState(() {
                                            String dungsai ="true";
                                            if(Contact['trangthai']=="true"){
                                              dungsai="false";
                                            }
                                            else{
                                              dungsai="true";
                                            }
                                            authBloc.CapnhaptrangthaiNgayCuaToi(userId,Contact['key'],dungsai);
                                            authBloc.capnhapTrangthaiCV(userId,Contact['key_danhmuc'],Contact['key_congviec'],dungsai);



                                          });

                                        },
                                      ),
                                      label:   Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(Contact['name_congviec'].toString(),
                                              style: TextStyle(fontSize: 18.0,color: Colors.white),
                                            ),
                                          ),
                                          IconButton(onPressed: (){

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
                      'Thêm Công Việc',
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
