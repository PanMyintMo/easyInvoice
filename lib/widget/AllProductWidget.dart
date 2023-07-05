import 'package:flutter/material.dart';

import '../common/CustomButtom.dart';

class AllProductWidget extends StatefulWidget {
  const AllProductWidget({Key? key}) : super(key: key);

  @override
  State<AllProductWidget> createState() => _AllProductWidgetState();
}

class _AllProductWidgetState extends State<AllProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.redAccent,
            ),
            onPressed: () {},
          ),
          title: const Text(
            'All Product',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xff000000),
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.red,
                  size: 20,
                ))
          ],
        ),
        body: Container(
          color: Colors.white,
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.production_quantity_limits_outlined,color: Colors.grey.shade300, size: 50.0,),
               Container(
                 padding: EdgeInsets.only(left: 10,top: 10),
                 child: const Column(
                children: [
                 Expanded(child: Text('Product name')),
                 Expanded(child: Text('Category name:')),
                 Expanded(child: Text('Stock')),
                  Expanded(child: Text('Id : 1'))
                ],
              ),
               ),
              Expanded(child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
              Text('06/6/2023') ,
                  Expanded(child: Center(
                    child: CustomButton(
                      label: 'View Detail Product',
                      onPressed: () async {
                      /*  var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ,
                          ),
                        );
                        if (result != null) {
                          context.read<GetAllUserRoleCubit>().getAllUserRole();
                        }*/
                      },
                    ),
                  ),

                  )
                ],
              ))
            ],
          ),
        ));
  }
}
