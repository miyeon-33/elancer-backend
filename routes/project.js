const express = require('express');

const router = express.Router();
const connection = require('../config/mysql');

router.get('/project', (req, res) => {
  connection.query('SELECT * FROM project', (err, result) => {
    if (err) {
      console.error('프로젝트정보 가져오기 에러:', err.message);
      return res.status(500).send('Database error');
    }
    res.json(result);
  });
});

module.exports = router;
