// BU SAYFADA SERVİSE POST ATIYORUZ
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:service_hardware_andro/service/post_model.dart';

class ServicePostLearn extends StatefulWidget {
  const ServicePostLearn({Key? key}) : super(key: key);

  @override
  State<ServicePostLearn> createState() => _ServiceLearnViewState();
}

class _ServiceLearnViewState extends State<ServicePostLearn> {
  bool _isLoading = false;
  String? kontrol;
  late final Dio _dio;
  final _baseUrl = 'https://jsonplaceholder.typicode.com/';
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  TextEditingController _userIdController = TextEditingController();

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dio = Dio(BaseOptions(baseUrl: _baseUrl));
  }

  Future<void> _addItemToService(PostModel model) async {
    _changeLoading();
    try{
final response= await  _dio.post('posts',
    data: model
    );
    if(response.statusCode==HttpStatus.ok){
kontrol="basarili";
    }
    } catch(_){
      return null;
    }
     
    _changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("a"),
          actions: [
            _isLoading
                ? CircularProgressIndicator.adaptive()
                : SizedBox.shrink()
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                controller: _titleController,
                decoration: InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: _bodyController,
                decoration: InputDecoration(labelText: "Body"),
              ),
              TextField(
                controller: _userIdController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "UserId"),
              ),
              TextButton(
                  onPressed:  _isLoading ? null : () {



                    if (_titleController.text.isNotEmpty &&
                        _bodyController.text.isNotEmpty &&
                        _userIdController.text.isNotEmpty) {
                      final model = PostModel(
                          body: _bodyController.text,
                          title: _titleController.text,
                          userId: int.tryParse(_userIdController.text));
                          _addItemToService(model);
                    }
                  },
                  child: Text("Send")),
            ],
          ),
        ));
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({
    Key? key,
    required PostModel? model,
  })  : _model = model,
        super(key: key);

  final PostModel? _model;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text(_model?.title ?? ' '),
        subtitle: Text(_model?.body ?? ' '),
      ),
    );
  }
}
