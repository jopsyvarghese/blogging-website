const db = require("../db");

class Blogs {
  static async findAll(limit, offset) {
    const [rows] = await db.query("SELECT * FROM blogs LIMIT ? OFFSET ?", [
      limit,
      offset,
    ]);
    return rows;
  }

  static async count() {
    const [rows] = await db.query("SELECT COUNT(*) as count FROM blogs");
    return rows[0].count;
  }
}

module.exports = Blogs;
