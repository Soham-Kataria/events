const multer = require('multer');

// No file storage needed, just form fields
const storage = multer.memoryStorage();
const upload = multer({ storage });

module.exports = upload.none();  // Parse only text fields
