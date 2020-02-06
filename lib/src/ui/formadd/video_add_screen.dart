import 'package:aram_management/src/api/domain_api.dart';
import 'package:aram_management/src/api/video_api.dart';
import 'package:aram_management/src/api/video_type_api.dart';
import 'package:aram_management/src/model/domain.dart';
import 'package:aram_management/src/model/video.dart';
import 'package:aram_management/src/model/video_type.dart';
import 'package:aram_management/src/provaiders/public_provaider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class VideoAddScreen extends StatefulWidget {
  final Video video;

  VideoAddScreen({this.video});

  @override
  _VideoAddScreenState createState() => _VideoAddScreenState();
}

class _VideoAddScreenState extends State<VideoAddScreen> {
  bool isVideoStatusSelected = false;
  bool _isLoading = false;
  VideoApi _videoApi = VideoApi();
  VideoTypeApi _videoTypeApi;
  DomainApi _domainApi;
  bool _isFieldvideoTitleValid;
  bool _isFieldVideoTypeValid;
  bool _isFieldDomainValid;
  TextEditingController _controllervideoTitle = TextEditingController();
  SelectedVideoTypeProvider _controllerVideoType = SelectedVideoTypeProvider();
  SelectedDomainProvider _controllerDomain = SelectedDomainProvider();

  getLoginUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int intValue = prefs.getInt('userid');
    userID = intValue;
    return intValue;
  }

  int userID = 0;
  @override
  void initState() {
    if (widget.video != null) {
      _isFieldvideoTitleValid = true;
      _controllervideoTitle.text = widget.video.videoTitle;
      _controllerVideoType.index = int.parse(widget.video.videoTypeId);
      _controllerDomain.index = int.parse(widget.video.domainId);
      _isFieldVideoTypeValid = true;
      _isFieldDomainValid = true;
    }

    _videoTypeApi = VideoTypeApi();
    _domainApi = DomainApi();
    getLoginUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SelectedVideoTypeProvider videoTypeSelected =
        Provider.of<SelectedVideoTypeProvider>(context, listen: false);
    videoTypeSelected.selectedTypeId = _controllerVideoType.index;

    SelectedDomainProvider domainSelected =
        Provider.of<SelectedDomainProvider>(context, listen: false);
    domainSelected.selectedDomainId = _controllerDomain.index;

    return Hero(
      tag: 'addVideo',
      child: Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            widget.video == null ? "إضافة مادة" : "تعديل البيانات",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildTextFieldvideoTitle(),
                    _buildVideoType(),
                    _buildDomain(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        width: double.infinity,
                        child: RaisedButton(
                          child: Text(
                            widget.video == null
                                ? "حفظ".toUpperCase()
                                : "تعديل".toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            print(_controllervideoTitle.text.toString());

                            if (_isFieldvideoTitleValid == null ||
                                    // _isFieldVideoTypeValid == null ||
                                    // _isFieldDomainValid == null ||
                                    !_isFieldvideoTitleValid
                                // || !_isFieldVideoTypeValid ||
                                // !_isFieldDomainValid
                                ) {
                              _scaffoldState.currentState.showSnackBar(
                                SnackBar(
                                  content: Text(" الرجاء تعبئة جميع الحقول"),
                                ),
                              );
                              return;
                            }
                            setState(() => _isLoading = true);
                            String title =
                                _controllervideoTitle.text.toString();
                            String vt =
                                videoTypeSelected.selectedTypeId.toString();
                            String vd =
                                domainSelected.selectedDomainId.toString();
                            String vs = '1';
                            String vui = userID.toString();

                            DateTime vcreated = DateTime.now();
                            DateTime vupdate = DateTime.now();

                            Video video = Video(
                              videoTitle: title,
                              videoTypeId: vt,
                              domainId: vd,
                              videoStatusId: vs,
                              videoUserId: vui,
                              videoEditBy: '0',
                              videoProducedBy: '0',
                              videoPublishedBy: '0',
                              videoVoiceOverBy: '0',
                              createdAt: vcreated,
                              updatedAt: vupdate,
                            );
                            if (widget.video == null) {
                              try {
                                _videoApi.createVideo(video).then((isSuccess) {
                                  setState(() => _isLoading = false);
                                  if (isSuccess) {
                                    Navigator.pop(
                                        _scaffoldState.currentState.context);
                                  } else {
                                    _scaffoldState.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text("فشل حفظ البيانات"),
                                    ));
                                  }
                                });
                              } catch (e) {
                                print(e.toString());
                              }
                            } else {
                              video.videoId = widget.video.videoId;
                              video.createdAt = widget.video.createdAt;
                              _videoApi.updateVideo(video).then((isSuccess) {
                                setState(() => _isLoading = false);
                                if (isSuccess) {
                                  Navigator.pop(
                                      _scaffoldState.currentState.context);
                                } else {
                                  _scaffoldState.currentState
                                      .showSnackBar(SnackBar(
                                    content: Text("فشل تعديل البيانات"),
                                  ));
                                }
                              });
                            }
                          },
                          color: Colors.orange[600],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              _isLoading
                  ? Stack(
                      children: <Widget>[
                        Opacity(
                          opacity: 0.3,
                          child: ModalBarrier(
                            dismissible: false,
                            color: Colors.grey,
                          ),
                        ),
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildTextFieldvideoTitle() {
    return TextField(
      controller: _controllervideoTitle,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "العنوان",
        errorText: _isFieldvideoTitleValid == null || _isFieldvideoTitleValid
            ? null
            : "العنوان مطلوب",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldvideoTitleValid) {
          setState(() => _isFieldvideoTitleValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildVideoType() {
    return FutureBuilder(
      future: _videoTypeApi.getVideoTypes(),
      builder: (BuildContext context, AsyncSnapshot<List<VideoType>> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
                "Something wrong with message: ${snapshot.error.toString()}"),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          List<VideoType> videoTypes = snapshot.data;
          return _buildListViewVideoType(videoTypes);
        } else {
          return SizedBox(
              height: 60, child: Center(child: Text('جاري تحميل المعلومات')));
        }
      },
    );
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
              height: 60, child: Center(child: Text('جاري تحميل المعلومات')));
        }
      },
    );
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildListViewVideoType(List<VideoType> videoTypes) {
    return Container(
      height: 100,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: videoTypes.length,
        itemBuilder: (BuildContext context, int index) {
          VideoType _videoType = videoTypes[index];
          // print(_videoType.videoStatusName);
          return Consumer<SelectedVideoTypeProvider>(
            builder: (ctx, videoTypeSelected, _) => Container(
              margin: EdgeInsets.only(top: 10, left: 8),
              child: GestureDetector(
                child: Chip(
                  label: Text(_videoType.videoTypeName),
                  backgroundColor: videoTypeSelected.index ==
                          int.parse(_videoType.videoTypeId)
                      ? Colors.lime
                      : Colors.grey[300],
                ),
                onTap: () =>
                    videoTypeSelected.index = int.parse(_videoType.videoTypeId),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildListViewDomains(List<Domains> domain) {
    return Container(
      height: 80,
      child: ListView.builder(
        // shrinkWrap: true,
        scrollDirection: Axis.horizontal,

        itemCount: domain.length,
        itemBuilder: (BuildContext context, int index) {
          Domains _domain = domain[index];

          return Consumer<SelectedDomainProvider>(
            builder: (ctx, domainSelected, _) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  child: Stack(children: <Widget>[
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 200),
                      opacity:
                          domainSelected.index == int.parse(_domain.domainId)
                              ? 1
                              : .2,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(_domain.domainImageUrl),
                      ),
                    ),
                  ]),
                  onTap: () =>
                      domainSelected.index = int.parse(_domain.domainId),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
