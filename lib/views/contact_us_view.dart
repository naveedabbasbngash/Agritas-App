import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0), // Add left padding
          child: Text(
         'Crops'
          ),
        ),
        backgroundColor: Color(0xFF0fa065),
        titleTextStyle: TextStyle(
          color: Colors.white, // Set the title color to white
          fontSize: 20, // Adjust the font size as needed
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Set the back button color to white
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_contact_us.png'),
                // Ensure image path is correct
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    children: [
                      // Get In Touch Section
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.white,
                            // Ensure a perfectly white background
                            padding: const EdgeInsets.fromLTRB(20,15,20,15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Get In Touch',
                                  style: GoogleFonts.poppins(
                                    color: Color(0xFF7C7B7B), // You can replace 'Poppins' with any Google Font
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                )
                                ,SizedBox(height: 12),
                                Text(
                                  'If you have any inquiries get in touch with us.',
                                  style: GoogleFonts.poppins(
                                      color: Color(0xFF8F8F8F),

                                      fontWeight:FontWeight.normal,
                                    fontSize: 16
                                  ),
                                ),
                                SizedBox(height: 12),
                                Row(
                                  children: [

                                    Image.asset('assets/images/emailicon.png',
                                      width: 32.0,
                                      // Set the desired width and height for the icon
                                      height: 32.0,),
                                    SizedBox(width: 10),
                                    Text('Info@agritas.com.pk',
                                        style: GoogleFonts.poppins(
                                            color: Color(0xFF8F8F8F),

                                            fontWeight:FontWeight.normal,
                                            fontSize: 16
                                        )
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Data Privacy Officer Section
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Data Privacy Officer',
                                  style: GoogleFonts.poppins(
                                    color: Color(0xFF7C7B7B),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22, // Adjusted to match the title size
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/name_icon.png',
                                      width: 32.0,
                                      height: 32.0,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Salman Nazir',
                                      style: GoogleFonts.poppins(
                                        color: Color(0xFF8F8F8F),

                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Image.asset(

                                      "assets/images/emailicon.png",
                                      width: 32.0,
                                      height: 32.0,
                                    ),
                                    SizedBox(width: 10),
                                    Text(

                                      'Info@agritas.com.pk',
                                      style: GoogleFonts.poppins(
                                        color: Color(0xFF8F8F8F),

                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Published by Section

                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0,40,20,0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Published by',
                                style: GoogleFonts.poppins(
                                  color: Color(0xFF7C7B7B),

                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                            )
                    ,
                            SizedBox(height: 10),
                            Text(
                              style: GoogleFonts.poppins(
                                color: Color(0xFF7C7B7B)
                                    ,
                                fontSize: 12
                              ),
                              'Agritas Pakistan Private Limited Block no 1, Four Star Market, Tangi Road, Kosar Abad, Charsada, Pakistan Charsada, Pakistan',
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
