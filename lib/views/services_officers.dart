import 'package:flutter/material.dart';

class ServicesOfficers extends StatelessWidget {
  final String image;
  final String title;
  final List<Map<String, String>> officers;

  ServicesOfficers({
    required this.image,
    required this.title,
    required this.officers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/serivesdealers_bg.png', // Replace with your background image path
              fit: BoxFit.cover,
            ),
          ),

          // Content Overlay
          Column(
            children: [
              // Header Section with Image, Title, and Dropdown
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                color: Colors.green,
                child:
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16), // Adjust padding as needed
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            image,
                            width: 60,
                            height: 60,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.image, color: Colors.white, size: 60);
                            },
                          ),
                          SizedBox(height: 8),
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.green),
                            SizedBox(width: 8),
                            Text(
                              'Peshawar', // This can be replaced with the selected location
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(Icons.arrow_drop_down, color: Colors.grey),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Custom ListView Section
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: officers.length,
                  itemBuilder: (context, index) {
                    final officer = officers[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        title: Text(
                          officer['name'] ?? '',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(officer['description'] ?? ''),
                        trailing: Icon(Icons.arrow_forward, color: Colors.green),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}