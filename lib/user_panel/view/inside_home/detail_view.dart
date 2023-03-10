import 'package:app_pengaduan_masyarakat_bna/shared/util/my_color.dart';
import 'package:flutter/material.dart';

class detail_view extends StatefulWidget {
  var detail;

  detail_view({this.detail, super.key});

  @override
  State<detail_view> createState() => _detail_viewState();
}

class _detail_viewState extends State<detail_view> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Detail Aduan',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: "#FF7F50".toColor(),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(16.0),
        color: "#FF7F50".toColor(),
        child: content(),
      ),
    );
  }

  Widget content() {
    return Center(
      child: PhysicalModel(
        borderRadius: BorderRadius.circular(30),
        elevation: 3,
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
          width: double.infinity,
          height: 600,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  widget.detail['username'],
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Image.network(widget.detail['image']).image)),
              ),
              Container(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  widget.detail['judul'],
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Container(
                child: Text(
                  widget.detail['deskripsi'],
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                ),
              ),
              Spacer(),
              Container(
                // margin: EdgeInsets.only(top: 40),
                // padding: EdgeInsets.only(top: 50),
                child: Text(
                  "Lokasi : ${widget.detail['lokasi']}",
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
