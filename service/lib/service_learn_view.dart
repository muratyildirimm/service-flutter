


// BU SAYFADA SERVİSTEN VERİ CEKİYORUZ
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:service_hardware_andro/service/post_model.dart';

class ServiceLearnView extends StatefulWidget {
  const ServiceLearnView({Key? key}) : super(key: key);

  @override
  State<ServiceLearnView> createState() => _ServiceLearnViewState();
}

class _ServiceLearnViewState extends State<ServiceLearnView> {
  List<PostModel>? _items = [];
  bool _isLoading = false;
  late final  Dio _dio;
  final _baseUrl='https://jsonplaceholder.typicode.com/';

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPostItems();
    _dio=Dio(BaseOptions(baseUrl: _baseUrl));
  }


// şu void Future olabilirondan emin değilim
  Future<void> fetchPostItems() async {
    
    _changeLoading();

    try{
final response =
        await Dio().get('https://jsonplaceholder.typicode.com/posts');

    if (response.statusCode == HttpStatus.ok) {
      final _datas = response.data;
      if (_datas is List) {
        setState(() {
          _items = _datas.map((e) => PostModel.fromJson(e)).toList();
        });
      }
    }
    } catch(_){
      return null;
    }
    
    _changeLoading();
  }

  Future <void> fetchPostItemsAdvance() async {
    _changeLoading();
   
  Future.delayed(Duration(seconds: 5));
    final response =
        await _dio.get('posts');

    if (response.statusCode == HttpStatus.ok) {
      final _datas = response.data;
      if (_datas is List) {
        setState(() {
          _items = _datas.map((e) => PostModel.fromJson(e)).toList();
        });
      }
    }
    _changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("a"),
        actions: [
          
          _isLoading ? const  CircularProgressIndicator.adaptive( backgroundColor: Colors.amber,
            
          ) :  const SizedBox.shrink()
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: _items?.length ?? 4,
        itemBuilder: (context, index) {
          return _PostCard(model: _items?[index]);
        },
      ),
    );
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
