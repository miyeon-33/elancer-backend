const express = require('express');
const router = express.Router();
const connection = require('../config/mysql');

router.get('/category', (req, res) => {
  const query = 'SELECT * FROM category';

  connection.query(query, (err, result) => {
    if (err) {
      console.error('카테고리 불러오기 실패:', err.message);
      return res.status(500).json({ error: 'Database error' });
    }
    res.json(result);
  });
});

module.exports = router;
