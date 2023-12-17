const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const cors = require('cors');
const Like = require('./like.js');
const path = require('path');
const dotenv = require('dotenv');
dotenv.config({ path: path.resolve(__dirname, '.env') });

const MONGO_DB_URI = process.env.MONGO_DB_URI;
const app = express();
app.use(bodyParser.json());
app.use(cors());
let db;

const options = {
  useNewUrlParser: true,
  useUnifiedTopology: true,
};

mongoose.connect(MONGO_DB_URI, options).then(function() {
  console.log('MongoDB is connected');
  db = mongoose.connection.db; // Assign the db variable with the MongoDB database object
}).catch(function(err) {
  console.log(err);
});


app.post('/like', async (req, res) => {
  console.log('POST /like');
  const collection = db.collection('likes');
  const imageUrl = req.body.url;

  try {
    const existingLike = await Like.findOne({ url: imageUrl });
    if (existingLike) {
      await Like.deleteOne({ url: imageUrl });
      console.log('Like deleted:', existingLike);
    } else {
      const newLike = new Like({
        url: imageUrl
      });
      await newLike.save();
      console.log('New like created:', newLike);
    }

    res.sendStatus(200);
  } catch (error) {
    console.log(error);
    res.status(500).send('Internal Server Error');
  }
});

app.get('/likes', async (req, res) => {
  try {
    console.log('GET /likes');
    const collection = db.collection('likes');
    const likes = await Like.find({});
    const urls = likes.map(like => like.url);
    return res.send(urls);
  } catch (error) {
    console.log(error);
    return res.status(500).send('Internal Server Error');
  }
});


app.listen(3000, () => console.log('Server corriendo en el puerto 3000'));