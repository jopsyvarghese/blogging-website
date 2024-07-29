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

        const accessToken = jwt.sign(payload, process.env.ACCESS_SECRET, {expiresIn: process.env.ACCESS_KEY_EXPIRY});
        const refreshToken = jwt.sign(payload, process.env.REFRESH_SECRET, {expiresIn: process.env.REFRESH_KEY_EXPIRY});

        await db.query('INSERT INTO refresh_tokens (user_id, token, expiry_date) VALUES (?, ?, ?)', [
            rows[0].id, refreshToken, new Date(Date.now() + (1000 * 60 * 2))
          ]);

        res.json({message: 'Success', accessToken, refreshToken});
    }
});

router.post('/refresh-token', async (req,res) => {
    const refreshToken = req.body.refresh_token;
    if(!refreshToken) {
        return res.status(400).json({message: "Missing refresh token"});
    }
    try {
        const decoded = jwt.verify(refreshToken, process.env.REFRESH_SECRET);
        const userId = decoded.userId;
        
        const refreshTokenData = await db.query('SELECT * FROM refresh_tokens WHERE user_id=? AND token=? AND expiry_date > now()', [userId, refreshToken])
        if(!refreshToken.length) {
            return res.status(401).json({message: "Invalid refresh token"});
        }
        
        const newAccessToken = jwt.sign({userId}, process.env.ACCESS_SECRET, {expiresIn: process.env.ACCESS_KEY_EXPIRY});
        res.json({accessToken: newAccessToken});
    } catch(err) {
        return res.status(401).json({message: "Invalid refresh token"});
    }
});

router.get('/verify_token', (req, res) => {
    const authHeader = req.headers.authorization;
    if(!authHeader || !authHeader.startsWith('Bearer ')) {
        return res.status(401).json({message: "User not authenticated"});
    }
    const token = authHeader.split(' ')[1];
    try {
        const decoded = jwt.verify(token, process.env.ACCESS_SECRET);
        return res.json({decoded});
    } catch(err) {
        return res.status(401).json({message: "Invalid token"});
    }
});

router.get('/subcategories/:categoryId', async (req, res) => {
    const categoryId = req.params.categoryId;
    const [subcategories] = await db.query('SELECT id, sub_category_name FROM sub_category WHERE category_id=?', [categoryId]);
    res.json(subcategories);
});

module.exports = router;