const express = require('express');
const router = express.Router();
const db = require('../db.js');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

router.post('/login', async (req, res) => {
    const {username, password} = req.body;
    const [rows] = await db.query("SELECT id, username, user_password FROM users WHERE username=?", [username]);
    if(!rows[0] || !rows[0].id) {
        res.json({message: 'Invalid username or password given'});
        return;
    }
    const isPasswordMatching = await bcrypt.compare(password, rows[0].user_password);
    if(!isPasswordMatching) {
        res.json({message: 'Invalid username or password given'});
        return;
    } else {
        /**
         * JSON Web Token (JWT)
         * Compact
         * Self contained
         * Secure
         * 
         * 
         * header.payload.signature
         * 
         * 
         * sub, exp, iat
         * 
         * secret key -- HMAC algorithm
         * private key -- RSA or ECDSA algorithm
         * 
         * 
         */
        const payload = {
            userId: rows[0].id,
            username: username,
        };

        const token = jwt.sign(payload, process.env.JWT_SECRET_KEY, {expiresIn: '30m'});
        res.json({message: 'Success', token});
    }
});

router.get('/verify_token', (req, res) => {
    const authHeader = req.headers.authorization;
    if(!authHeader || !authHeader.startsWith('Bearer ')) {
        return res.status(401).json({message: "User not authenticated"});
    }
    const token = authHeader.split(' ')[1];
    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET_KEY);
        return res.json({decoded});
    } catch(err) {
        return res.status(401).json({message: "Invalid token"});
    }
});

module.exports = router;