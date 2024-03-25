import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:qlcv/src/resources/widgets/home_chitietcv.dart';

import '../../blocs/auth_bloc.dart';

class HomeDanhMuc extends StatefulWidget {
  String Contact_Key;
  String Contact_name;

  HomeDanhMuc({required this.Contact_Key,required this.Contact_name,});

  @override
  State<HomeDanhMuc> createState() => _HomeDanhMucState();
}


class _HomeDanhMucState extends State<HomeDanhMuc> {
  TextEditingController _infoController = TextEditingController();
  AuthBloc authBloc = new AuthBloc();
  String userId ="S4unFZXcAvXSjeSUhb4ZkueN7Oi2";





  DatabaseReference db_Ref =
  FirebaseDatabase.instance.ref().child('congviec');
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
                authBloc.createCV(userId,widget.Contact_Key ,_infoController.text);
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
                    Text( "Danh Mục: ${widget.Contact_name}",style: TextStyle(
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

                    query: db_Ref.child(userId).child(widget.Contact_Key),
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
                                            Contact_Key: Contact['key'],Contact_name: Contact['name'],Contact_KeyDanhMuc: widget.Contact_Key,Contact_trangthai:Contact['trangthai'] ,
                                          ),
                                        ),
                                      );
                                      // Xử lý khi nút được nhấn
                                      print(  Contact['name']);
                                      print(  Contact['key']);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(5.0),
                                      primary: Colors.blueGrey, // Màu nền của nút
                                    ),
                                    icon:      IconButton(
                                      icon: trangThai
                                          ? Icon(Icons.check_circle,color: Colors.blue,)
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

                                          authBloc.capnhapTrangthaiCV(userId, widget.Contact_Key, Contact['key'], dungsai);
                                          authBloc.CapnhaptrangthaiNgayCuaToi(userId,Contact['key'],dungsai);
                                        });
                                      },
                                    ),
                                    label:   Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(Contact['name'].toString(),
                                            style: TextStyle(fontSize: 18.0,color: Colors.white),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(onPressed: (){


                                            },
                                                icon: Icon(Icons.star_border)),
                                            IconButton(onPressed: (){
                                              authBloc.XoaDLDanhMuc(userId, widget.Contact_Key,Contact['key']);
                                              // db_Ref?.child(userId).child(widget.Contact_Key).child(Contact['key']).remove();
                                            },
                                                icon: Icon(Icons.delete_forever)),
                                          ],
                                        ),

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
