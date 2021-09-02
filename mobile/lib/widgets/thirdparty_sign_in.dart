import 'package:flutter/material.dart';

class ThirdPartySignIn extends StatelessWidget {
  final AssetImage logo;
  final String serviceName;
  final Function signIn;

  ThirdPartySignIn({
    AssetImage this.logo,
    String this.serviceName,
    Function this.signIn,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: signIn,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.all(14),
        child: Row(
          children: [
            Image(
              image: logo,
              height: 20,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                'Continue with $serviceName',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_sharp),
          ],
        ),
      ),
    );
  }
}
