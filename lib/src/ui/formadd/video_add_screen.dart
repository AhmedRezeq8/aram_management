import 'package:aram_management/src/api/video_api.dart';
import 'package:aram_management/src/api/video_status_api.dart';
import 'package:aram_management/src/model/video.dart';
import 'package:aram_management/src/model/video_status.dart';
import 'package:flutter/material.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.video == null ? "إضافة مادة" : "تعديل البيانات",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldvideoTitle(),
                _buildTextFieldEmail(),
                _buildTextFieldAge(),
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
                      String email = _controllerEmail.text.toString();
                      int age = int.parse(_controllerAge.text.toString());
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

  Widget _buildTextFieldEmail() {
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
          return _buildListView(videoStatuses);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
    // return TextField(
    //   controller: _controllerEmail,
    //   keyboardType: TextInputType.emailAddress,
    //   decoration: InputDecoration(
    //     labelText: "Email",
    //     errorText: _isFieldEmailValid == null || _isFieldEmailValid
    //         ? null
    //         : "Email is required",
    //   ),
    //   onChanged: (value) {
    //     bool isFieldValid = value.trim().isNotEmpty;
    //     if (isFieldValid != _isFieldEmailValid) {
    //       setState(() => _isFieldEmailValid = isFieldValid);
    //     }
    //   },
    // );
  }

  Widget _buildTextFieldAge() {
    return TextField(
      controller: _controllerAge,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Age",
        errorText: _isFieldAgeValid == null || _isFieldAgeValid
            ? null
            : "Age is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldAgeValid) {
          setState(() => _isFieldAgeValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildListView(List<VideoStatus> videoStatuses) {
    return Container(
      height: 100,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          childAspectRatio: 2 / 5,
          mainAxisSpacing: 0,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: videoStatuses.length,
        itemBuilder: (BuildContext context, int index) {
          VideoStatus _videoStatus = videoStatuses[index];
          print(_videoStatus.videoStatusName);
          return Container(
              margin: EdgeInsets.only(top: 10),
              child: Radio(
                groupValue: _videoStatus.videoStatusName,
                onChanged:(va){

                },
                value: Chip(
                  label: Text(_videoStatus.videoStatusName),
                  backgroundColor: isVideoStatusSelected == true
                      ? Color(int.parse(_videoStatus.videoStatusColor))
                      : Colors.grey[300],
                ),
              ));
        },
      ),
    );
  }
}
