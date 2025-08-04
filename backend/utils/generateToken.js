// utils/generateToken.js
const jwt = require('jsonwebtoken');

const generateToken = (userId) => {
  return jwt.sign({ id: userId }, process.env.JWT_SECRET, {
    expiresIn: '7d', // Token expiry (you can change this)
  });
};

module.exports = generateToken;
