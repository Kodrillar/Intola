const {Client} = require("cassandra-driver");

module.exports = async function(){

    const client = new Client({
        cloud:{
            secureConnectBundle:"./secure-connect-forintola.zip"
        },
         credentials:{
          username: process.env.CLIENT_ID,
          password: process.env.CLIENT_SECRET      
      },
    
      keyspace:"intola"
    
    });
    
    await client.connect();

    return client;

}