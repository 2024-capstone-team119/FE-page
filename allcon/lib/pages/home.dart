import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

void main() => runApp(MyHome());

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _idx = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ALLCON',
          style: TextStyle(fontFamily: 'Cafe24Moyamoya'),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        elevation: 6.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.calendar_month),
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: HomePage(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _idx = index;
          });
        },
        currentIndex: _idx,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.black38,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: '마이페이지',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: '검색',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.speaker_notes),
            label: '커뮤니티',
          ),
        ],
      ),
    );
  }
}

final List<String> imgList = [
  '이미지1',
  '이미지2',
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _pageOfTop(),
        _pageOfMiddle(),
        _pageOfBottom(),
      ],
    );
  }
}

Widget _pageOfTop() {
  return Container(
    height: 250,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Padding(
      padding: EdgeInsets.all(15.0),
      child: Swiper(
        pagination: SwiperPagination(),
        itemCount: imgList.length,
        viewportFraction: 0.8,
        scale: 0.85,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            imgList[index],
            fit: BoxFit.fill,
          );
        },
      ),
    ),
  );
}

Widget _pageOfMiddle() {
  return Text('_pageOfMiddle');
}

Widget _pageOfBottom() {
  return Text('_pageOfBottom');
}
