const express = require('express');
const router = express.Router();
const connection = require('../config/mysql');

router.get('/technology', (req, res) => {
  const query = `SELECT t.*, GROUP_CONCAT(d.detail_name) AS detail_name
                FROM technologies AS t
                JOIN technology_details AS d 
                ON t.technology_id = d.technology_id
                GROUP BY t.technology_id`;

  connection.query(query, (err, result) => {
    if (err) {
      console.error('프로젝트정보 가져오기 에러:', err.message);
      return res.status(500).send('Database error');
    }
    res.json(result);
  });
});

module.exports = router;
