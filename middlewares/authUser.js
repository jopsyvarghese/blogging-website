const express = require('express');
function isLoggedIn(req, res, next) {
    if(req.session.userId) {
        next();
    } else {
        res.redirect('/login')
    }
}
module.exports = isLoggedIn;