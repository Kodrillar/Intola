# What is Intola?
Intola is an E-commerce mobile application for shopping, delivering and donating to people in need. It is written in <a href='https://dart.dev/'>Dart</a> using <a href='https://flutter.dev/'>Flutter</a>, Google's multi-platform application framework.


# Requirements

To run this server, you'll need the most recent version of <a href='https://nodejs.org/en/'>Node.js</a>.

- <a href='https://nodejs.org/en/' target="_blank">Click here</a> to install Node.js.
- <a href='http://siberiancmscustomization.blogspot.com/2020/10/how-to-get-imgur-client-id.html'>Follow this guide</a> to get your Imgur client ID. 
- <a href='https://astra.datastax.com/register/U2FsdGVkX19TSSHomrpXLuW0Q6IdPugGkUx6MMTAKdGyos1L2a3S4hA3KuU4bWwKKE0VsT5GzqGeofcDRk0yfHup1L2u3Sn1mfKAe1Q2u3A4le1Q2u3A4l'>Create an Astra DB account</a> to get your database client Id and secret.
- In the project directory, run, ``` npm install ```
- Configure environment variables. In the root directory create a ```.env ```  file and add the following;

    ``` 
    CLIENT_ID =<YOUR_CLIENT_ID>
    CLIENT_SECRET =<YOUR_CLIENT_SECRET>
    IMGUR_CLIENT_ID =<YOUR_IMGUR_CLIENT_ID>
    JWT_KEY =<YOUR_DESIRED_JWT_KEY/PASSWORD>
    
     ```
    You can also configure environment variables by setting/exporting these values through your terminal;

    ``` 
   export CLIENT_ID =<YOUR_CLIENT_ID>
   export CLIENT_SECRET =<YOUR_CLIENT_SECRET>
   export IMGUR_CLIENT_ID =<YOUR_IMGUR_CLIENT_ID>
   export JWT_KEY =<YOUR_JWT_KEY/PASSWORD>
    
     ```

