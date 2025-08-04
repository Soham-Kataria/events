const jwt = require('jsonwebtoken');
const User = require('../models/user.model.js');

exports.auth = async (req, res, next) => {
  const authHeader = req.headers.authorization;

  if (!authHeader || !authHeader.startsWith("Bearer ")) {
    return res.status(401).json({ message: "No token was found." });
  }

  try {
    const token = authHeader.split(' ')[1];
    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    const user = await User.findById(decoded.id).select('-password');

    if (!user) {
      return res.status(400).json({ message: "User not found." });
    }

    req.user = user;
    next();
  } catch (error) {
    return res.status(401).json({ message: "Invalid token", error: error.message });
  }
};

exports.hasRole = (roles = []) => {
  return (req, res, next) => {
    if (!req.user || !roles.includes(req.user.role)) {
      return res.status(403).json({ message: 'Access denied: insufficient role' });
    }
    next();
  };
};









// const jwt = require('jsonwebtoken');
// const User = require('../models/user.model.js');

// exports.auth = async (req,res,next) => {
//     const authHeader = req.headers.authorization;
//     if(!authHeader || !authHeader.startsWith("Bearer ")) {
//         return res.status(401).res.json({message: "No Token was found."});
//     }
//     try {
//         const token = authHeader.split(' ')[1];
//         const decoded = await jwt.verify(token, process.env.JWT_SECRET);

//         const user = await User.findById(decoded.id).select('-password');
//         if(user) return res.status(400).json({message: "User not found."});

//         next();

//     } catch (error) {
//         next(error)
//     }
// }

// exports.isAdmin = (req, res, next) => {
//   const user = req.user;

//   if (user.role === "admin") {
//     next();
//   } else {
//     return res.status(403).json({ message: "Access Denied: Admin only." });
//   }
// };

// exports.isManager = (req, res, next) => {
//   const user = req.user;

//   if (user.role === "manager") {
//     next();
//   } else {
//     return res.status(403).json({ message: "Manager Denied: Manager only." });
//   }
// };