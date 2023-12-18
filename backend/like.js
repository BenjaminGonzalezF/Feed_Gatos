const mongoose = require('mongoose');

const LikeSchema = new mongoose.Schema({
    url: {
        type: String,
        required: true
    },
});

const Like = mongoose.model('Like', LikeSchema);

module.exports = Like;
