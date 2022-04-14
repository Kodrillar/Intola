

module.exports = function(){

    process.on("uncaughtException", (err)=>{
        console.log(`==><== Hello!  'uncaughtException' Error occured ==><== `);
        console.log(err);
        process.exit(1)
    })


    process.on("unhandledRejection", (err)=>{
        console.log(`==><== Hello! 'unhandledRejection' Error occured ==><==`);
        console.log(err);
        process.exit(1)
    })
}