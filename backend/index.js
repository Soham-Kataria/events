const { connectDB } = require('./db/connect.js');
const dotenv = require('dotenv');
dotenv.config();
const app = require('./App.js');
const PORT = process.env.PORT;
connectDB();

// app.use('/user', app);

app.listen(PORT,()=>{
    console.log(`Server is running on ${PORT}`)
})