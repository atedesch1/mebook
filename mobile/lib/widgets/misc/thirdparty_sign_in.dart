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
    return Material(
      borderRadius: BorderRadius.circular(100),
      elevation: 8,
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: signIn,
        child: Padding(
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
      ),
    );
  }
}
