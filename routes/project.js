const express = require('express');
const router = express.Router();
const connection = require('../config/mysql');

router.get('/project', (req, res) => {
  const query = `
    SELECT 
      p.*, 
      c.category_name
    FROM 
      project AS p
    JOIN 
      category AS c ON p.category_id = c.category_id
    ORDER BY 
      p.registration_date DESC
  `;

  connection.query(query, (err, result) => {
    if (err) {
      console.error('프로젝트정보 가져오기 에러:', err.message);
      return res.status(500).send('Database error');
    }
    res.json(result);
  });
});

module.exports = router;
