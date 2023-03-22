import 'package:flutter/material.dart';

class VendorFilterWidget extends StatelessWidget {
  const VendorFilterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ActionChip(
              elevation: 3,
              backgroundColor: Colors.black45,
              onPressed: () {},
              label: const Text(
                "All Vendors",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            ActionChip(
              elevation: 3,
              backgroundColor: Colors.black45,
              onPressed: () {},
              label: const Text(
                "Active",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            ActionChip(
              elevation: 3,
              backgroundColor: Colors.black45,
              onPressed: () {},
              label: const Text(
                "Inactive",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            ActionChip(
              elevation: 3,
              backgroundColor: Colors.black45,
              onPressed: () {},
              label: const Text(
                "Top Picked",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            ActionChip(
              elevation: 3,
              backgroundColor: Colors.black45,
              onPressed: () {},
              label: const Text(
                "Top Rated",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
