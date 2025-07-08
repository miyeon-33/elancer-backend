const express = require('express');
const router = express.Router();
const connection = require('../config/mysql');

// 10개씩 보내기 (더보기 데이터)
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

// 전체 데이터
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

// java 데이터만 필터링 (메인페이지에서 사용)
router.get('/project/java', (req, res) => {
  const countQuery = `
    SELECT COUNT(*) AS total 
    FROM project 
    WHERE LOWER(title) LIKE '%java%'
  `;

  const dataQuery = `
    SELECT 
      p.*, 
      c.category_name 
    FROM 
      project AS p 
    JOIN 
      category AS c ON p.category_id = c.category_id 
    WHERE 
      LOWER(p.title) LIKE '%java%'
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

// POST /project/by-keyword
router.post('/project/by-keyword', (req, res) => {
  const {
    keywords = [],
    proficiencies = [],
    durations = [],
    locations = [],
  } = req.body;

  const conditions = [];
  const values = [];

  if (durations.length > 0) {
    const durationConds = durations
      .map((label) => {
        switch (label) {
          case '1달 이하':
            return 'CAST(REGEXP_SUBSTR(p.project_duration, "[0-9]+") AS UNSIGNED) <= 1';
          case '3개월 이상':
            return 'CAST(REGEXP_SUBSTR(p.project_duration, "[0-9]+") AS UNSIGNED) >= 3';
          case '6개월 이상':
            return 'CAST(REGEXP_SUBSTR(p.project_duration, "[0-9]+") AS UNSIGNED) >= 6';
          case '1년 이상':
            return 'CAST(REGEXP_SUBSTR(p.project_duration, "[0-9]+") AS UNSIGNED) >= 12';
          default:
            return null;
        }
      })
      .filter(Boolean);

    if (durationConds.length > 0) {
      conditions.push(`(${durationConds.join(' OR ')})`);
    }
  }

  if (keywords.length > 0) {
    const keywordConds = keywords
      .map(() => `LOWER(p.title) LIKE ?`)
      .join(' OR ');
    conditions.push(`(${keywordConds})`);
    values.push(...keywords.map((kw) => `%${kw.toLowerCase()}%`));
  }

  if (proficiencies.length > 0) {
    const profConds = proficiencies.map(() => `p.proficiency = ?`).join(' OR ');
    conditions.push(`(${profConds})`);
    values.push(...proficiencies);
  }

  if (locations.length > 0) {
    const locationConds = locations.map(() => `p.location = ?`).join(' OR ');
    conditions.push(`(${locationConds})`);
    values.push(...locations);
  }

  const whereClause =
    conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';

  const query = `
    SELECT p.*, c.category_name
    FROM project AS p
    JOIN category AS c ON p.category_id = c.category_id
    ${whereClause}
    ORDER BY p.project_id ASC
  `;

  connection.query(query, values, (err, results) => {
    if (err) {
      console.error('검색 오류:', err.message);
      return res.status(500).send('Database error');
    }

    res.json({ projects: results });
  });
});

// GET /project/category/2 - 기획 카테고리만 조회
router.get('/project/category/:id', (req, res) => {
  const categoryId = parseInt(req.params.id, 10);

  const countQuery = `
    SELECT COUNT(*) AS total 
    FROM project 
    WHERE category_id = ?
  `;

  const dataQuery = `
    SELECT 
      p.*, 
      c.category_name 
    FROM 
      project AS p 
    JOIN 
      category AS c ON p.category_id = c.category_id 
    WHERE 
      p.category_id = ?
    ORDER BY 
      p.project_id ASC
  `;

  connection.query(countQuery, [categoryId], (err, countResult) => {
    if (err) return res.status(500).send('Database error (count)');

    const total = countResult[0].total;

    connection.query(dataQuery, [categoryId], (err, result) => {
      if (err) return res.status(500).send('Database error (data)');
      res.json({ total, projects: result });
    });
  });
});
module.exports = router;
