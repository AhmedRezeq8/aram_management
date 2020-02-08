import 'package:aram_management/src/api/domain_api.dart';
import 'package:aram_management/src/api/user_api.dart';
import 'package:aram_management/src/api/video_api.dart';
import 'package:aram_management/src/model/domain.dart';
import 'package:aram_management/src/model/user.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class HomeMain extends StatefulWidget {
  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  UserApi _userApi;
  DomainApi _domainApi;
  VideoApi _videoApi;

  @override
  void initState() {
    _userApi = UserApi();
    _videoApi = VideoApi();
    _domainApi = DomainApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://scontent.fbtz1-4.fna.fbcdn.net/v/t1.0-9/39467861_1974066275972645_1391056009283239936_n.jpg?_nc_cat=102&_nc_ohc=rtuEl8w7iAkAX9lDBXI&_nc_ht=scontent.fbtz1-4.fna&oh=8c8f7b71562e1e3c36dd33e49e48b228&oe=5EC625AC',
                  scale: 1),
              radius: 20,
            ),
          ),
          onTap: () {},
        ),
        title: Text('إدارة آرام'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('الأعضاء'),
              SizedBox(
                height: 5,
              ),
              _buildUser(),
              SizedBox(
                height: 10,
              ),
              Text('المنصات'),
              SizedBox(
                height: 5,
              ),
              _buildDomain(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUser() {
    return FutureBuilder(
      future: _userApi.getUsers(),
      builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
                "Something wrong with message: ${snapshot.error.toString()}"),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          List<User> users = snapshot.data;
          return _buildListViewUsers(users);
        } else {
          return SizedBox(
              height: 90, child: Center(child: Text('جاري تحميل المعلومات')));
        }
      },
    );
  }

  Widget _buildListViewUsers(List<User> user) {
    return Container(
        height: 200,
        // color: Colors.white30,
        child: GridView.builder(
            shrinkWrap: false,
            primary: false,
            itemCount: user.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              User _user = user[index];
              return GestureDetector(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      Badge(
                        badgeContent: Text(
                          '3',
                          style: TextStyle(color: Colors.white),
                        ),
                        badgeColor: Colors.purple,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(_user.userImage),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(_user.userName)
                    ],
                  ),
                  onTap: () {});
            }));
  }

  Widget _buildDomain() {
    return FutureBuilder(
      future: _domainApi.getDomains(),
      builder: (BuildContext context, AsyncSnapshot<List<Domains>> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
                "Something wrong with message: ${snapshot.error.toString()}"),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          List<Domains> domains = snapshot.data;
          return _buildListViewDomains(domains);
        } else {
          return SizedBox(
              height: 700, child: Center(child: Text('جاري تحميل المعلومات')));
        }
      },
    );
  }

  Widget _buildListViewDomains(List<Domains> domain) {
    return Container(
      height: 500,
      child: ListView.builder(
        primary: false,
        // shrinkWrap: true,
        shrinkWrap: false,
        itemCount: domain.length,
        itemBuilder: (BuildContext context, int index) {
          Domains _domain = domain[index];

          return Card(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                  borderRadius: BorderRadius.circular(6.0),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF6078ea).withOpacity(.3),
                        offset: Offset(0.0, 8.0),
                        blurRadius: 8.0)
                  ]),
              width: double.infinity,
              height: 200,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(_domain.domainImageUrl)),
                  Row(
                    children: <Widget>[
                      Text('قيد التحرير',
                          style: TextStyle(color: Colors.white)),
                      SizedBox(
                        width: 10,
                      ),
                      Text('15', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('قيد المونتاج',
                          style: TextStyle(color: Colors.white)),
                      SizedBox(
                        width: 10,
                      ),
                      Text('15', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('للنشر', style: TextStyle(color: Colors.white)),
                      SizedBox(
                        width: 10,
                      ),
                      Text('15', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
