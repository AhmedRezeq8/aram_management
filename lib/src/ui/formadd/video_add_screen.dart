import 'package:aram_management/src/api/domain_api.dart';
import 'package:aram_management/src/api/video_api.dart';
import 'package:aram_management/src/api/video_status_api.dart';
import 'package:aram_management/src/model/domain.dart';
import 'package:aram_management/src/model/video.dart';
import 'package:aram_management/src/model/video_status.dart';
import 'package:aram_management/src/provaiders/public_provaider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class VideoAddScreen extends StatefulWidget {
  Video video;

  VideoAddScreen({this.video});

  @override
  _VideoAddScreenState createState() => _VideoAddScreenState();
}

class _VideoAddScreenState extends State<VideoAddScreen> {
  bool isVideoStatusSelected = false;
  bool _isLoading = false;
  VideoApi _videoApi = VideoApi();
  VideoStatusApi _videoStatusApi;
  DomainApi _domainApi;
  bool _isFieldvideoTitleValid;
  bool _isFieldEmailValid;
  bool _isFieldAgeValid;
  TextEditingController _controllervideoTitle = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerAge = TextEditingController();

  @override
  void initState() {
    if (widget.video != null) {
      _isFieldvideoTitleValid = true;
      _controllervideoTitle.text = widget.video.videoTitle;

      // _isFieldEmailValid = true;
      // _controllerEmail.text = widget.video.email;
      // _isFieldAgeValid = true;
      // _controllerAge.text = widget.video.age.toString();
    }
    _videoStatusApi = VideoStatusApi();
    _domainApi = DomainApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final statusSelected =
    //     Provider.of<SelectedStatusProvider>(context, listen: false);

    return Scaffold(
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _buildTextFieldvideoTitle(),
                  _buildVideoStatus(),
                  _buildDomain(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
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
                        if (_isFieldvideoTitleValid == null ||
                            _isFieldEmailValid == null ||
                            _isFieldAgeValid == null ||
                            !_isFieldvideoTitleValid ||
                            !_isFieldEmailValid ||
                            !_isFieldAgeValid) {
                          _scaffoldState.currentState.showSnackBar(
                            SnackBar(
                              content: Text("Please fill all field"),
                            ),
                          );
                          return;
                        }
                        setState(() => _isLoading = true);
                        String name = _controllervideoTitle.text.toString();
                        // String email = _controllerEmail.text.toString();
                        // int age = int.parse(_controllerAge.text.toString());
                        Video video = Video(
                          videoTitle: name, /* email: email, age: age*/
                        );
                        if (widget.video == null) {
                          _videoApi.createVideo(video).then((isSuccess) {
                            setState(() => _isLoading = false);
                            if (isSuccess) {
                              Navigator.pop(_scaffoldState.currentState.context);
                            } else {
                              _scaffoldState.currentState.showSnackBar(SnackBar(
                                content: Text("Submit data failed"),
                              ));
                            }
                          });
                        } else {
                          video.videoId = widget.video.videoId;
                          _videoApi.updateVideo(video).then((isSuccess) {
                            setState(() => _isLoading = false);
                            if (isSuccess) {
                              Navigator.pop(_scaffoldState.currentState.context);
                            } else {
                              _scaffoldState.currentState.showSnackBar(SnackBar(
                                content: Text("Update data failed"),
                              ));
                            }
                          });
                        }
                      },
                      color: Colors.orange[600],
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
    );
  }

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
          List<VideoStatus> videoStatuses = snapshot.data;
          return _buildListViewVideoStatus(videoStatuses);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
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
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildListViewVideoStatus(List<VideoStatus> videoStatuses) {
    return Container(
      height: 100,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          childAspectRatio: 2.5 / 5,
          mainAxisSpacing: 0,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: videoStatuses.length,
        itemBuilder: (BuildContext context, int index) {
          VideoStatus _videoStatus = videoStatuses[index];
          print(_videoStatus.videoStatusName);
          return Consumer<SelectedStatusProvider>(
            builder: (ctx, statusSelected, _) => Container(
              margin: EdgeInsets.only(top: 10),
              child: GestureDetector(
                child: Chip(
                  label: Text(_videoStatus.videoStatusName),
                  backgroundColor: statusSelected.index ==
                          int.parse(_videoStatus.videoStatusId)
                      ? Color(int.parse(_videoStatus.videoStatusColor))
                      : Colors.grey[300],
                ),
                onTap: () {
                  statusSelected.index = int.parse(_videoStatus.videoStatusId);
                },
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
                  child: Container(
                    width: 70,
                    height: 70,
                    
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(_domain.domainImageUrl),
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  onTap: () {
                    print(domainSelected.index);
                    domainSelected.index=int.parse( _domain.domainId);
                  },
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
