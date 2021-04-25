import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kVersion = '0.3';

const kInputPageBackgroundColor = Colors.black45;

const kMainContainerWidthPortrait = 600.0;
const kMainContainerWidthLandscape = 1000.0;


const kSettingsModalBackgroundColor = Colors.black45;

const kSettingsTextStyle_fontSize = 20.0;

const kSettingsTextStyle = TextStyle(
  fontSize: kSettingsTextStyle_fontSize,
  color: Colors.black45,
  fontWeight: FontWeight.normal,
);

const kSettingsTextEditStyle = TextStyle(
  fontSize: 20.0,
  color: Colors.black,
  fontWeight: FontWeight.normal,
);


//
// Choices for score_page fonts
//
// look at https://fonts.google.com/?preview.text=0123456&preview.text_type=custom&preview.size=113
//
enum FontTypes {
  system,
  lato,
  merriweather,
  montserrat,
  robotoMono,
  rockSalt,
}

const kLabelTextStyle_system = TextStyle(
  fontSize: 50.0,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);
const kNumberTextStyle_system = TextStyle(
  fontSize: 250.0,
  fontWeight: FontWeight.bold,
);

var kLabelTextStyle_lato = GoogleFonts.lato(
  fontSize: 50,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);
var kNumberTextStyle_lato = GoogleFonts.lato(
  fontSize: 250,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

var kLabelTextStyle_merriweather = GoogleFonts.merriweather(
  fontSize: 40,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);
var kNumberTextStyle_merriweather = GoogleFonts.merriweather(
  fontSize: 250,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

var kLabelTextStyle_montserrat = GoogleFonts.montserrat(
  fontSize: 50,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);
var kNumberTextStyle_montserrat = GoogleFonts.montserrat(
  fontSize: 250,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

var kLabelTextStyle_robotomono = GoogleFonts.robotoMono(
  fontSize: 30,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);
var kNumberTextStyle_robotomono = GoogleFonts.robotoMono(
  fontSize: 200,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

var kLabelTextStyle_rocksalt = GoogleFonts.rockSalt(
  fontSize: 30,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);
var kNumberTextStyle_rocksalt = GoogleFonts.rockSalt(
  fontSize: 120,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);
