import 'package:aram_management/src/api/video_api.dart';
import 'package:aram_management/src/model/video.dart';
import 'package:aram_management/src/ui/formadd/video_add_screen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  BuildContext context;
  VideoApi videoApi;

  getLoginUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int intValue = prefs.getInt('userid');
    userID = intValue;
    return intValue;
  }

  int userID = 0;
  @override
  void initState() {
    super.initState();
    videoApi = VideoApi();
    getLoginUserId();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: "addVideo",
          onPressed: () {
            Route route =
                MaterialPageRoute(builder: (context) => VideoAddScreen());

            Navigator.push(context, route);
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: FutureBuilder(
          future: videoApi.getVideos(),
          builder: (BuildContext context, AsyncSnapshot<List<Video>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                    "Something wrong with message: ${snapshot.error.toString()}"),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<Video> videos = snapshot.data;
              return _buildListView(videos);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildListView(List<Video> videos) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          Video video = videos[index];
          // print(videos[1].videoTitle);
          return Dismissible(
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {
              //استلام المادة من المقترح
              String title = video.videoTitle.toString();
              String vt = video.videoTypeId;
              String vd = video.domainId;
              String vs = '2';
              String vui = video.videoUserId;
              String veb = userID.toString();
              String ii = '0';
              String vpbb = '0';
              String vco = '0';
              DateTime vcreated = DateTime.now();
              DateTime vupdate = DateTime.now();

              Video _video = Video(
                videoTitle: title,
                videoTypeId: vt,
                domainId: vd,
                videoStatusId: vs,
                videoUserId: vui,
                videoEditBy: veb,
                createdAt: vcreated,
                updatedAt: vupdate,
              );
              _video.videoId = video.videoId;
              _video.createdAt = video.createdAt;
              videoApi.updateVideo(_video).then((isSuccess) {
                if (isSuccess) {
                  BotToast.showSimpleNotification(
                    title: "تم إستلام المادة",
                    align: Alignment.bottomCenter,
                    hideCloseButton: true,
                  );
                } else {
                  BotToast.showSimpleNotification(
                    title: "فشل إستلام المادة",
                    align: Alignment.bottomCenter,
                    hideCloseButton: true,
                  );
                }
              });
            },
            key: ValueKey(video.videoId),
            background: Container(
              padding: EdgeInsets.only(right: 20),
              color: Theme.of(context).accentColor,
              child: Icon(
                Icons.assignment_turned_in,
                size: 60,
                color: Colors.white,
              ),
              alignment: Alignment.centerRight,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        video.videoTitle,
                        style: Theme.of(context).textTheme.title,
                      ),
                      Text(video.userName),
                      // Text(video.age.toString()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Warning"),
                                      content: Text(
                                          "Are you sure want to delete data video ${video.videoTitle}?"),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text("Yes"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            videoApi
                                                .deleteVideo(video.videoId)
                                                .then((isSuccess) {
                                              if (isSuccess) {
                                                setState(() {});
                                                Scaffold.of(this.context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            "Delete data success")));
                                              } else {
                                                Scaffold.of(this.context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            "Delete data failed")));
                                              }
                                            });
                                          },
                                        ),
                                        FlatButton(
                                          child: Text("No"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    );
                                  });
                            },
                            child: Text(
                              "حذف",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return VideoAddScreen(video: video);
                              }));
                            },
                            child: Text(
                              "تعديل",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: videos.length,
      ),
    );
  }
}
