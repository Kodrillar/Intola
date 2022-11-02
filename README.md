<a href="https://github.com/Kodrillar/Intola/actions"><img src="https://github.com/Kodrillar/Intola/workflows/intola-unit-tests/badge.svg" alt="Build Status"></a>

# What is Intola?
Intola is an E-commerce mobile application for shopping, delivering and donating to people in need. It is written in <a href='https://dart.dev/'>Dart</a> using <a href='https://flutter.dev/'>Flutter</a>, Google's multi-platform application framework.


<img width="1235" alt="intola-graphic" src="https://user-images.githubusercontent.com/67793558/196162506-cf866bda-385f-4551-abd6-a77f2928a6f2.png">

<p align="center"><a href='https://play.google.com/store/apps/details?id=com.kodrillar.intola'><img src="https://user-images.githubusercontent.com/67793558/196183359-76177ae7-ab4b-425b-85ab-1e9cf624f854.png" alt="playstore-badge" width="250"/> </a></p> 

<img src="https://user-images.githubusercontent.com/67793558/163425788-e396721f-6342-4792-b3ee-7bdd7a7d9e89.png" alt="sign up screen" width="200"/>   <img src="https://user-images.githubusercontent.com/67793558/163426258-e9cecb65-9894-4e0a-a18f-7ce9ce840b6d.png" alt="home screen" width="200"/>  <img src="https://user-images.githubusercontent.com/67793558/163426867-114db330-b1cf-423e-9f2f-e6253650b989.png" alt="home screen" width="200"/>

# Requirements
- Ensure that <a href='https://flutter.dev/'>Flutter</a> is installed on your machine. 

- **Environment variables:**
    Create a ``` .env ``` file in the project's ``` client/ ``` directory.

- **Flutterwave public key for payments:**
    This mobile application uses <a href='https://flutterwave.com/'>Flutterwave</a>, to process payments (in test mode). You'll need a public key to process payments successfully.

- <a href='https://app.flutterwave.com/register'>Create a Flutterwave account</a>.

- <a href='https://flutterwave.com/tz/support/my-account/getting-your-api-keys'>Follow this guide</a> to get your public key.                                         

- Add this line, ``` PUBLIC_KEY=<YOUR_FLUTTERWAVE_PUBLIC_KEY> ```, to the ```.env``` file created in step 1.

- Run ``` flutter pub get ```


# Server

The server powering Intola can be found <a href='https://github.com/Kodrillar/intola-server'>here</a> or in the project's ``` server/``` directory. It is written in Javascript using <a href='https://nodejs.org/en/'>Node.js</a>, <a href='https://expressjs.com/'>Express.js</a> and, <a href='https://www.datastax.com/products/datastax-astra'>Astra DB</a> (Datastax's Cassandra Database-as-a-service).


# Spotted a bug?  

Feel free to<a href='https://github.com/Kodrillar/Intola/issues'> file an issue</a> or <a href='https://www.kodrillar.com/p/contact-me.html'>contact me</a>.



