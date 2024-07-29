const express = require("express");
const router = express.Router();
const db = require("../db.js");
const bcrypt = require("bcryptjs");
const Blogs = require("../models/Blogs.js");

const limit = 2;

router.get("/login", (req, res) => {
  res.sendFile("login.html", { root: "public" });
});

router.post("/login", async (req, res) => {
  const { username, password } = req.body;
  const [rows] = await db.query(
    "SELECT id, username, user_role, user_password FROM users WHERE username=?",
    [username]
  );
  if (!rows[0] || !rows[0].id) {
    res.send("Invalid username or password given");
    return;
  }
  const isPasswordMatching = await bcrypt.compare(
    password,
    rows[0].user_password
  );
  if (!isPasswordMatching) {
    res.send("Invalid username or password given");
    return;
  } else {
    req.session.userId = rows[0].id;
    req.session.userName = rows[0].username;
    req.session.userRole = rows[0].user_role;
    if (rows[0].user_role === "User") {
      req.session.isAdmin = false;
    } else {
      req.session.isAdmin = true;
    }
    res.redirect("/protected");
    return;
  }
});

router.get("/register", (req, res) => {
  res.sendFile("register.html", { root: "public" });
});

router.get("/logout", (req, res) => {
  req.session.destroy();
  res.redirect("/");
});

router.post("/register", (req, res) => {
  const { username, title, first_name, last_name, email, password } = req.body;
  const userNameExists = db
    .query("SELECT id FROM users WHERE username=?", [username])
    .then((result) => {
      if (result[0] && result[0][0] && result[0][0].id) {
        res.redirect("/register");
        return;
      }
    })
    .catch((err) => {
      res.send(err);
      return;
    });
  const hashRounds = 10;
  bcrypt.genSalt(hashRounds, (err, salt) => {
    if (err) {
      res.send("Unable to generate Salt");
      return;
    }
    bcrypt.hash(password, salt, (err, hash) => {
      if (err) {
        res.send("Unable to create Hash");
        return;
      }
      db.query(
        "INSERT INTO USERS(`username`, `title`, `first_name`, " +
          "`last_name`, `user_role`, `email`, `user_password`) " +
          "VALUES('" +
          username +
          "', '" +
          title +
          "', '" +
          first_name +
          "', '" +
          last_name +
          "', 'User', '" +
          email +
          "', '" +
          hash +
          "')"
      )
        .then((result) => {
          res.redirect("/login");
          return;
        })
        .catch((err) => {
          if (!res.headersSent) {
            res.send(err);
            return;
          }
        });
    });
  });
});

router.get("/", async (req, res) => {
  const isLoggedIn = req.session.userId > 0;
  const [categories] = await db.query("SELECT * FROM category WHERE status=1");
  const page = parseInt(req.query.page) || 1;
  const offset = (page - 1) * limit;
  try {
    const blogs = await Blogs.findAll(limit, offset);
    const count = await Blogs.count();
    const totalPages = Math.ceil(count / limit);

    res.render("blogs.ejs", {
      isLoggedIn,
      categories,
      blogs,
      currentPage: page,
      totalPages,
    });
  } catch (err) {
    console.error(err);
    res.status(500).send("Error fetching data");
  }
});

module.exports = router;
