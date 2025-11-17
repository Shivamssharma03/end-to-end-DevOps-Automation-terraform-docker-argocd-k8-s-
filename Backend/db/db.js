const express = require('express')
const mongoose = require('mongoose');
require('dotenv').config({ path: './config/.env' });
const mongoURI = process.env.MONGO_URI

const mongoDB = async () => {
    // mongoose.set('strictQuery', false);
    await mongoose.connect(process.env.MONGO_URI, { 
        useNewUrlParser : true ,
        // dbName:"CAFEEASE DB",
    } , async(err,result) =>{
        if(err){
            console.log("--- not connnected",err)
        }
        else{
            console.log("connected")
            const fetched_data = await mongoose.connection.db.collection("food_items")
            fetched_data.find({}).toArray(function(err , data){
                if(err) console.log(err);
                // else console.log(data)
                
            })
        }
    })
}


module.exports = mongoDB