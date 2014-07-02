BEGIN;
CREATE TABLE POINTS AS SELECT ST_MakePoint(x,y) g
FROM generate_series(1,100) x,
     generate_series(1,100) y;
CREATE INDEX on POINTS using spgist(g);
SET enable_seqscan to off;
EXPLAIN SELECT * FROM points WHERE g && ST_MakeLine(
  ST_MakePoint(0,0),
  ST_MakePoint(1,0)
);
COMMIT;
