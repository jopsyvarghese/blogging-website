const express = require('express');
const basicAuth = require('express-basic-auth');

const app = express();

// admin
// user
// super-user

app.use('/admin', authorization, AdminPath);
app.use('/user', UserPath);

app.listen(3000, () => {
    console.log("Server running on port 3000");
})