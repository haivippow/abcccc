import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:qlcv/src/model/user_id.dart';
import 'package:qlcv/src/resources/widgets/home_danhmuc.dart';
import 'package:qlcv/src/resources/widgets/ngaycuatoi.dart';

import '../blocs/auth_bloc.dart';
class HomePage extends StatefulWidget {
  final String userId;

  const HomePage({super.key,required this.userId});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  TextEditingController _infoController = TextEditingController();
  AuthBloc authBloc = new AuthBloc();



  DatabaseReference db_Ref =
  FirebaseDatabase.instance.ref().child('danhmuc');
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
               authBloc.createDanhMuc(widget.userId, _infoController.text);
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Nguyễn Đình Hải",style: TextStyle(color: Colors.white,fontSize: 26),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => NgayCuaToi(),
                                ),
                              );
                              // Xử lý khi nút được nhấn
                              print('Ngày của Tôi');
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(16.0),
                              primary: Colors.black, // Màu nền của nút
                            ),
                            icon: Icon(
                              Icons.sunny, // Chọn biểu tượng mong muốn
                              size: 24.0,color: Colors.yellow[300],
                            ),
                            label:  const  Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Ngày của Tôi',
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
                              print('Quan Trọng');
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(16.0),
                              primary: Colors.black, // Màu nền của nút
                            ),
                            icon: Icon(
                              Icons.star_border, // Chọn biểu tượng mong muốn
                              size: 24.0,color: Colors.pink[400],
                            ),
                            label: const  Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Quan Trọng',
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
                              print('Đã Lập Kế Hoạch');
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(16.0),
                              primary: Colors.black, // Màu nền của nút
                            ),
                            icon: Icon(
                              Icons.calendar_today_outlined, // Chọn biểu tượng mong muốn
                              size: 24.0,color: Colors.green[300],
                            ),
                            label: const  Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Đã lập kế hoạch',
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
                              Icons.check_box_outlined, // Chọn biểu tượng mong muốn
                              size: 24.0,color: Colors.blue[200],
                            ),

                            label: const  Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Tác vụ',
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
                              authBloc.LogOut();
                              print('Tác vụ');
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(16.0),
                              primary: Colors.black, // Màu nền của nút
                            ),
                            icon: Icon(
                              Icons.logout, // Chọn biểu tượng mong muốn
                              size: 24.0,color: Colors.blue[200],
                            ),

                            label: const  Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Log out',
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
                    FirebaseAnimatedList(
                      
                        query: db_Ref.child(widget.userId),
                        shrinkWrap: true,
                        itemBuilder: (context,snapshot,animation, index){
                      Map Contact = snapshot.value as Map;
                      Contact['key'] = snapshot.key;
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => HomeDanhMuc(
                                            Contact_Key: Contact['key'],Contact_name: Contact['name'],
                                          ),
                                        ),
                                    );
                                    // Xử lý khi nút được nhấn
                                    print(  Contact['name']);
                                    print(  Contact['key']);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(16.0),
                                    primary: Colors.black, // Màu nền của nút
                                  ),
                                  icon: Icon(
                                    Icons.receipt_long, // Chọn biểu tượng mong muốn
                                    size: 24.0,color: Colors.red[300],
                                  ),
                                  label:    Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(Contact['name'].toString(),
                                      style: TextStyle(fontSize: 18.0,color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
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
                      'Thêm Danh Mục',
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
