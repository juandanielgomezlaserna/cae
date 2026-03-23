import 'package:cae/Global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void assassinate (context, player) {
  showDialog(
    context: context,
    builder: (context){
      return Dialog(
        backgroundColor: Colors.transparent,
        child: SizedBox(
          height: 300,
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: 316,
                  height: 261,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(19),
                    color: Global.primary
                  ),
                ),
              ),
              Align(
                alignment: AlignmentGeometry.topRight,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(37),
                    onTap: (){
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 37,
                        width: 37,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Global.white,
                        ),
                        child: Icon(CupertinoIcons.xmark, color: Global.secondary,),
                      ),
                    ),
                  ),
                )
              )
            ],
          ),
        ),
      );
    }
  );
}