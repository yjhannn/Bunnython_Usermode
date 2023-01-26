import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_booking/screens/smart.dart';
import 'package:hotel_booking/theme/color.dart';
import 'package:hotel_booking/utils/data.dart';
import 'package:hotel_booking/widgets/custom_image.dart';
import 'package:hotel_booking/widgets/icon_box.dart';
import 'package:hotel_booking/widgets/setting_item.dart';
import 'package:hotel_booking/screens/setting.dart';
import 'package:hotel_booking/screens/trip.dart';
import 'package:hotel_booking/utils/constant.dart';

class RemotePage extends StatefulWidget {
  const RemotePage({Key? key}) : super(key: key);

  @override
  _RemotePageState createState() => _RemotePageState();
}

class _RemotePageState extends State<RemotePage> with TickerProviderStateMixin {
  int activeTabIndex = 0;
  List barItems = [
    {
      "page": SmartPage(),
    },
  ];
  @override
  Widget build(BuildContext context) {
    //====== set animation=====
    late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: ANIMATED_BODY_MS),
      vsync: this,
    );
    late final Animation<double> _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );

    @override
    void initState() {
      super.initState();
      _controller.forward();
    }

    @override
    void dispose() {
      _controller.stop();
      _controller.dispose();
      super.dispose();
    }

    animatedPage(page) {
      return FadeTransition(child: page, opacity: _animation);
    }

    void onPageChanged(int index) {
      if (index == activeTabIndex) return;
      _controller.reset();
      setState(() {
        activeTabIndex = index;
      });
      _controller.forward();
    }

    // 화면에 보이는 영역
    return Scaffold(
      appBar: AppBar(
        elevation: 0, // 그림자 없애기
        backgroundColor: Colors.white, // 배경 색상
        centerTitle: false, // title 중앙 정렬
        iconTheme: IconThemeData(color: Colors.black), // app bar icon color
        title: Text(
          "Hotel On the Hands",
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          /// My Button
          IconButton(
            onPressed: () {
              print("go my page");
            },
            icon: Icon(
              Icons.person_outline,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          /// 검색
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "서비스를 검색해주세요.",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                // 돋보기 아이콘
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    print("돋보기 아이콘 클릭");
                  },
                ),
              ),
            ),
          ),
          Divider(height: 1),

          /// 카테고리 목록
          SingleChildScrollView(
            padding: EdgeInsets.only(right: 20, top: 10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Hilton, Gyeonju",
                        style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "1203호(디럭스 더블)",
                        style: TextStyle(
                          color: labelColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                SettingItem(
                    title: "스마트 키",
                    leadingIcon: Icons.key,
                    leadingIconColor: orange,
                    onTap: () {
                      onPageChanged(barItems[1]);
                    }),
                SizedBox(height: 10),
                SettingItem(
                    title: "객실 온도 조절",
                    leadingIcon: Icons.thermostat,
                    leadingIconColor: red,
                    onTap: () {}),
                SizedBox(height: 10),
                SettingItem(
                    title: "객실 조명 조절",
                    leadingIcon: Icons.light,
                    leadingIconColor: yellow,
                    onTap: () {}),
                SizedBox(height: 10),
                SettingItem(
                    title: "룸 서비스",
                    leadingIcon: Icons.account_circle,
                    leadingIconColor: green,
                    onTap: () {}),
                SizedBox(height: 10),
                SettingItem(
                  title: "시설 안내",
                  leadingIcon: Icons.store,
                  leadingIconColor: Colors.grey.shade400,
                  onTap: () {},
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),

      /// AppBar 왼쪽에 아이콘을 누를 때 왼쪽에서 오른쪽으로 나오는 위젯
      /// 해당 위젯을 추가하면 AppBar 왼쪽에 아이콘이 자동으로 추가됨
      drawer: Drawer(
        child: Column(
          children: [
            // Drawer 윗 부분
            DrawerHeader(
              margin: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
              ),
              child: SizedBox(
                width: double.infinity, // 가득 채우기
                child: Column(
                  children: [
                    /// 동그란 배경
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),

                        /// 이미지
                        child: Image.network(
                          "https://i.ibb.co/CwzHq4z/trans-logo-512.png",
                          width: 62,
                        ),
                      ),
                    ),

                    /// 닉네임 상단 여백
                    SizedBox(height: 16),

                    /// 닉네임
                    Text(
                      "yjhan",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    /// 이메일
                    Text(
                      "yjhan999@naver.com",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// 이벤트 배너
            // 특정 비율로 위젯을 보여주기
            AspectRatio(
              aspectRatio: 12 / 4, // 가로 : 세로 = 12 : 4 (이미지를 12:4로 준비했어요)
              /// 이벤트 배너 리스트
              /// 스크롤을 하는데, 특정 항목이 스냅이 걸리도록 만들고 싶은 경우 PageView를 사용해요.
              child: PageView(
                children: [
                  Image.network(
                    "https://i.ibb.co/Q97cmkg/sale-event-banner1.jpg",
                  ),
                  Image.network(
                    "https://i.ibb.co/GV78j68/sale-event-banner2.jpg",
                  ),
                  Image.network(
                    "https://i.ibb.co/R3P3RHw/sale-event-banner3.jpg",
                  ),
                  Image.network(
                    "https://i.ibb.co/LRb1VYs/sale-event-banner4.jpg",
                  ),
                ],
              ),
            ),

            /// 구매 내역
            ListTile(
              title: Text(
                '예약 내역',
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
              onTap: () {
                // 클릭시 drawer 닫기
                Navigator.pop(context);
              },
            ),

            /// 레시피 공유하기
            ListTile(
              title: Text(
                '최근 본 숙소 리스트',
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
              onTap: () {
                // 클릭시 drawer 닫기
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                '나의 객실 기능',
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
              onTap: () {
                // 클릭시 drawer 닫기
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
