const express = require('express');
const router = express.Router();
const connection = require('../config/mysql');

router.get('/project', (req, res) => {
  const count = parseInt(req.query.count) || 0;
  const limit = 10;
  const offset = count * limit;
  const countQuery = `SELECT COUNT(*) AS total FROM project`;
  const query = `
    SELECT 
      p.*, 
      c.category_name
    FROM 
      project AS p
    JOIN 
      category AS c ON p.category_id = c.category_id
    ORDER BY 
      p.project_id ASC
    LIMIT ? OFFSET ? 
  `;

  connection.query(countQuery, (err, countResult) => {
    if (err) return res.status(500).send('Database error (count)');

    const total = countResult[0].total;

    connection.query(query, [limit, offset], (err, result) => {
      if (err) return res.status(500).send('Database error (data)');
      res.json({ total, projects: result });
    });
  });
});

router.get('/project/all', (req, res) => {
  const countQuery = `SELECT COUNT(*) AS total FROM project`;
  const dataQuery = `
    SELECT 
      p.*, 
      c.category_name
    FROM 
      project AS p
    JOIN 
      category AS c ON p.category_id = c.category_id
    ORDER BY 
      p.project_id ASC
  `;

  connection.query(countQuery, (err, countResult) => {
    if (err) return res.status(500).send('Database error (count)');
    const total = countResult[0].total;

    connection.query(dataQuery, (err, result) => {
      if (err) return res.status(500).send('Database error (data)');
      res.json({ total, projects: result });
    });
  });
});

// 프로젝트 제목에 키워드 포함 여부로 필터링
router.post('/project/by-keyword', (req, res) => {
  const { keyword } = req.body;

  if (!keyword || typeof keyword !== 'string' || !keyword.trim()) {
    return res.status(400).send('유효한 키워드를 입력해주세요');
  }

  const query = `
    SELECT 
      p.*, 
      c.category_name
    FROM 
      project AS p
    JOIN 
      category AS c ON p.category_id = c.category_id
    WHERE 
      p.title LIKE CONCAT('%', ?, '%')
    ORDER BY 
      p.project_id ASC
  `;

  connection.query(query, [keyword], (err, results) => {
    if (err) {
      console.error('제목 검색 오류:', err.message);
      return res.status(500).send('Database error');
    }

    res.json({ projects: results });
  });
});

module.exports = router;
