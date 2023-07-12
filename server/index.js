const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const authRouter = require("./routes/auth");

const PORT = process.env.PORT|3001;
const app = express();
app.use(cors());
app.use(express.json());
app.use(authRouter);
const DB = "mongodb+srv://<username:password>@clustereditor.ys4b9ae.mongodb.net/?retryWrites=true&w=majority";

mongoose.connect(DB).then(()=>{
    console.log("Connection successful");
}).catch((err)=>{
    console.log(err);
});
app.listen(PORT,"0.0.0.0",() => {
    console.log(`Connected to port ${PORT}`);
    
});