import 'package:aram_management/src/api/domain_api.dart';
import 'package:aram_management/src/api/user_api.dart';
import 'package:aram_management/src/api/video_api.dart';
import 'package:aram_management/src/api/video_status_api.dart';
// import 'package:aram_management/src/api/video_api.dart';
import 'package:aram_management/src/model/domain.dart';
import 'package:aram_management/src/model/user.dart';
import 'package:aram_management/src/model/video.dart';
import 'package:aram_management/src/model/video_status.dart';
import 'package:aram_management/src/provaiders/public_provaider.dart';
import 'package:aram_management/src/ui/formadd/video_add_screen.dart';
import 'package:aram_management/src/ui/home/home_screen.dart';
import 'package:aram_management/src/ui/profileScreen/profile_screen.dart';
import 'package:badges/badges.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

GlobalKey _keyRed = GlobalKey();

class HomeMain extends StatefulWidget {
  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  UserApi _userApi;
  DomainApi _domainApi;
  VideoApi _videoApi;
  VideoStatusApi _videoStatusApi;

  SelectedVideoStatusProvider _selectedVideoStatus =
      SelectedVideoStatusProvider();

  @override
  void initState() {
    _userApi = UserApi();
    _videoApi = VideoApi();
    _domainApi = DomainApi();
    _videoStatusApi = VideoStatusApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SelectedVideoStatusProvider videoStatusSelected =
        Provider.of<SelectedVideoStatusProvider>(context, listen: false);

    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   leading: GestureDetector(
      //     child: Padding(
      //       padding: const EdgeInsets.all(2),
      //       child: CircleAvatar(
      //         backgroundImage: NetworkImage(
      //             'https://scontent.fbtz1-4.fna.fbcdn.net/v/t1.0-9/39467861_1974066275972645_1391056009283239936_n.jpg?_nc_cat=102&_nc_ohc=rtuEl8w7iAkAX9lDBXI&_nc_ht=scontent.fbtz1-4.fna&oh=8c8f7b71562e1e3c36dd33e49e48b228&oe=5EC625AC',
      //             scale: 1),
      //         radius: 20,
      //       ),
      //     ),
      //     onTap: () {},
      //   ),
      //   title: Text('إدارة آرام'),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * .1,
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://scontent.fbtz1-4.fna.fbcdn.net/v/t1.0-9/39467861_1974066275972645_1391056009283239936_n.jpg?_nc_cat=102&_nc_ohc=rtuEl8w7iAkAX9lDBXI&_nc_ht=scontent.fbtz1-4.fna&oh=8c8f7b71562e1e3c36dd33e49e48b228&oe=5EC625AC',
                            scale: 1),
                        radius: 23,
                      ),
                      onTap: () {
                        Route route = MaterialPageRoute(
                            builder: (context) => ProfileScreen());

                        Navigator.push(context, route);
                      },
                    ),
                    Center(
                      child: Text(
                        'الصفحة الرئيسية',
                        style: TextStyle(
                            color: Color(0xffE73355),
                            fontWeight: FontWeight.w700,
                            fontSize: 22),
                      ),
                    ),
                    Container()
                  ],
                ),
              ),

              Parent(
                  style: ParentStyle()
                    ..height(MediaQuery.of(context).size.height * .2)
                    ..width(MediaQuery.of(context).size.width)
                    ..elevation(5, color: Color(0xff1F54C3), opacity: .3),
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Txt(
                              'قيد التحرير',
                              style: TxtStyle()
                                ..fontSize(18)
                                ..fontWeight(FontWeight.w500),
                            ),
                            Txt(
                              '900',
                              style: TxtStyle()
                                ..fontSize(18)
                                ..fontWeight(FontWeight.w500)
                                ..textColor(Color(0xff2ED573)),
                            ),
                          ],
                        ),
                        // Divider(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Txt(
                              'جاهز للمونتاج',
                              style: TxtStyle()
                                ..fontSize(18)
                                ..fontWeight(FontWeight.w500),
                            ),
                            Txt(
                              '4',
                              style: TxtStyle()
                                ..fontSize(18)
                                ..fontWeight(FontWeight.w500)
                                ..textColor(Color(0xffE73355)),
                            ),
                          ],
                        ),
                        // Divider(thickness: 10,color: Color(0xff707070),),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Txt(
                              'قيد المونتاج',
                              style: TxtStyle()
                                ..fontSize(18)
                                ..fontWeight(FontWeight.w500),
                            ),
                            Txt(
                              '4',
                              style: TxtStyle()
                                ..fontSize(18)
                                ..fontWeight(FontWeight.w500)
                                ..textColor(Color(0xffE73355)),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Txt(
                              'جاهز للنشر',
                              style: TxtStyle()
                                ..fontSize(18)
                                ..fontWeight(FontWeight.w500),
                            ),
                            Txt(
                              '4',
                              style: TxtStyle()
                                ..fontSize(18)
                                ..fontWeight(FontWeight.w500)
                                ..textColor(Color(0xffE73355)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),

              // Text('الأعضاء'),
              SizedBox(
                height: 5,
              ),
              _buildVideoStatus(),
              // _buildUser(),
              SizedBox(
                height: 10,
              ),
              // Text('المنصات'),
              _buildVideo(),
              SizedBox(
                height: 5,
              ),
              // _buildDomain(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoStatus() {
    return FutureBuilder(
      future: _videoStatusApi.getVideoStatuss(),
      builder:
          (BuildContext context, AsyncSnapshot<List<VideoStatus>> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
                "Something wrong with message: ${snapshot.error.toString()}"),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          List<VideoStatus> videoStatus = snapshot.data;
          return _buildListViewVideoStatus(videoStatus);
        } else {
          return SizedBox(
              height: 90, child: Center(child: Text('جاري تحميل المعلومات')));
        }
      },
    );
  }

  Widget _buildListViewVideoStatus(List<VideoStatus> videoStatus) {
    return Consumer<SelectedVideoStatusProvider>(
        builder: (ctx, videoTypeSelected, _) => Container(
              height: 50,
              // color: Colors.white30,
              child: ListView.builder(
                itemCount: videoStatus.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  VideoStatus _videoStatus = videoStatus[index];
                  return Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          videoTypeSelected.index =
                              int.parse(_videoStatus.videoStatusId);
                        },
                        child: Parent(
                          style: ParentStyle()
                            ..border(
                                all: 1,
                                color: int.parse(_videoStatus.videoStatusId) ==
                                        videoTypeSelected.index
                                    ? Color(0xff1F54C3)
                                    : Color(0xffE93354))
                            ..borderRadius(all: 100)
                            ..padding(horizontal: 10)
                            ..margin(all: 5)
                            ..scale(int.parse(_videoStatus.videoStatusId) ==
                                    videoTypeSelected.index
                                ? 1.1
                                : 1),
                          child: Txt(
                            _videoStatus.videoStatusName,
                            style: TxtStyle()
                              ..textColor(
                                  int.parse(_videoStatus.videoStatusId) ==
                                          videoTypeSelected.index
                                      ? Color(0xff1F54C3)
                                      : Color(0xffE93354)),
                          ),
                        ),
                      ),
                      // Chip(label: Text(_videoStatus.videoStatusName),backgroundColor: Colors.white,),
                    ],
                  );
                },
              ),
            ));
  }

  Widget _buildVideo() {
    return FutureBuilder(
      future: _videoApi.getVideos(),
      builder: (BuildContext context, AsyncSnapshot<List<Video>> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
                "Something wrong with message: ${snapshot.error.toString()}"),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          List<Video> videos = snapshot.data;
          return _buildListViewVideo(videos);
        } else {
          return SizedBox(
              height: 90, child: Center(child: Text('جاري تحميل المعلومات')));
        }
      },
    );
  }

  Widget _buildListViewVideo(List<Video> video) {
    return Container(
      key: _keyRed,
      height: 600,
      width: MediaQuery.of(context).size.width * .8,

      // color: Colors.white30,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: video.length,
        itemBuilder: (BuildContext context, int index) {
          Video _video = video[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Parent(
                  style: ParentStyle()
                    ..border(all: 1, color: Colors.grey)
                    ..borderRadius(all: 10)
                    ..padding(horizontal: 15, vertical: 15)
                    ..margin(all: 5)
                    ..width(MediaQuery.of(context).size.width)
                    ..height(150),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              strutStyle: StrutStyle(fontSize: 12.0),
                              text: TextSpan(
                                  style: TextStyle(
                                      color: Color(0xffE73355),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                  text: _video.videoTitle),
                            ),
                          ),
                          // Flexible(
                          //   child: Txt(_video.videoTitle),
                          // ),
                          Row(
                            children: <Widget>[
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * .38,
                                child: Stack(
                                  children: <Widget>[
                                    // Placeholder(),
                                    Positioned(
                                      left: 2,
                                      child: Parent(
                                        style: ParentStyle()
                                          ..border(all: 3, color: Colors.white)
                                          ..borderRadius(all: 100)
                                          ..height(35)
                                          ..width(35),
                                        child: CircleAvatar(
                                          child: Image.asset(
                                              'assets/images/profile.png'),
                                          radius: 18,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 25,
                                      child: Parent(
                                        style: ParentStyle()
                                          ..border(all: 3, color: Colors.white)
                                          ..borderRadius(all: 100)
                                          ..height(35)
                                          ..width(35),
                                        child: CircleAvatar(
                                          child: Image.asset(
                                              'assets/images/login.png'),
                                          radius: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                _video.videoTypeName,
                                style: TextStyle(
                                    color: Color(0xff1F54C3),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10),
                              ),
                              Text(
                                _video.videoStatusName,
                                style: TextStyle(
                                    color: Color(0xff1F54C3),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10),
                              ),
                              Text(
                                DateFormat("dd/MM/yyyy")
                                    .format(_video.createdAt),
                                style: TextStyle(
                                    color: Color(0xff1F54C3),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10),
                              ),
                            ],
                          ),
                          CircleAvatar(
                            child: Image.asset('assets/images/login.png'),
                            radius: 18,
                          ),
                        ],
                      )
                    ],
                  )),
            ],
          );
        },
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
