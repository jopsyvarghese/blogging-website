const express = require('express');
const router = express.Router();
const db = require('../db.js');
const multer = require('multer');
const crypto = require('crypto');
const path = require('path');
const fs = require('fs');

const upload = multer({
    dest: 'public/uploads',
    limits: { fileSize: 15000000},
    fileFilter: (req, file, cb) => {
        const allowedMimeTypes = ['image/jpeg', 'image/png', 'video/mp4', 'video/quicktime'];
        if (allowedMimeTypes.includes(file.mimetype)) {
          // Extract extension from original filename
          const ext = file.originalname.split('.').pop();
          cb(null, true, (err, fieldValue) => {
            fieldValue.filename = `${fieldValue.fieldname}-${Date.now()}.${ext}`; // Add extension to generated filename
          });
        } else {
          cb(new Error('Only JPG, PNG, MP4, WAV, MOV files are allowed!'));
        }
      }
});

router.post('/add-blog', upload.single('file_upload'), async (req, res) => {
    if(req.file) {
        const fileName = req.file.filename;
        const originalName = req.file.originalname;
        
        const {title, description, category_id, sub_category_id} = req.body;
        const randomFileName = crypto.randomBytes(16).toString('hex') 
          + path.extname(originalName);
        req.file.filename = randomFileName;
        await fs.promises.rename(
          path.join('public/uploads/'+fileName),
          path.join('public/uploads/'+randomFileName)
        );

        const [result] = await db.query('INSERT INTO blogs(`title`, `description`,'+ 
             '`category_id`, `sub_category_id`, `image_url`,'+
             ' `original_file_name`, `created_by`) '+
             'VALUES(?,?,?,?,?,?,?)', 
             [title, description, category_id, sub_category_id, randomFileName, originalName, req.session.userId]);
        const insertedId = result.insertId;
        const [categories] = await db.query('SELECT * FROM category WHERE status=1');
        if(insertedId) res.redirect('/');
        else res.redirect('/protected');
    }
});

router.get('/', async (req,res) => {
    const role = req.session.userRole;
    const userName = req.session.userName;
    const [categories] = await db.query('SELECT * FROM category WHERE status=1');
    res.render('dashboard.ejs', {categories});
})

module.exports = router;