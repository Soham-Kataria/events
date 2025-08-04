const express = require("express");
const router = express.Router();
const { auth, hasRole } = require("../middlewares/auth.middleware.js");
const upload = require("../middlewares/formParser");


const {
  register,
  login,
  updateUser,
  getUsers,
  deleteUser,
  getUserProfile,
} = require("../controller/user.controller.js");


router.post("/register", upload, register);
router.post("/login", login);
router.get("/profile", auth, hasRole(['admin']), getUsers);
router.get("/profile/:id", auth,hasRole(['admin','manager']), getUserProfile);
router.patch("/updateUser/:id", auth, updateUser);
router.delete("/deleteUser/:id", auth, deleteUser);

module.exports = router;

//  eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4N2RjYWUxZGIxYTA2NjMwNTFiZDdlOCIsImlhdCI6MTc1MzA3NDQzOSwiZXhwIjoxNzUzNjc5MjM5fQ.OpVfvijOdd79uQsZdCAwIv_PL3HP61t3iAkWU6jYZ_A
