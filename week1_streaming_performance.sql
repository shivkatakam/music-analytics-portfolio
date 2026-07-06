CREATE TABLE tracks (
  track_id INT PRIMARY KEY,
  track_name TEXT, artist TEXT, genre TEXT, release_date DATE
);
CREATE TABLE streams_daily (
  stream_id INT, track_id INT, stream_date DATE,
  platform TEXT, streams INT, saves INT, playlist_adds INT
);
INSERT INTO tracks VALUES
 (1,'Midnight Reverb','Aria Cole','Pop','2026-06-15'),
 (2,'Concrete Halo','Aria Cole','Pop','2026-05-20'),
 (3,'Gasoline Sunday','The Vale','Rock','2026-06-01'),
 (4,'Slow Static','The Vale','Rock','2026-06-28'),
 (5,'Neon Prayer','Juno Sky','Hip-Hop','2026-06-10');
INSERT INTO streams_daily VALUES
 (1,1,'2026-06-29','Spotify',42000,3100,210),
 (2,1,'2026-06-29','TikTok',88000,400,15),
 (3,2,'2026-06-29','Spotify',51000,1200,90),
 (4,3,'2026-06-29','Spotify',18000,2600,340),
 (5,4,'2026-06-29','AppleMusic',9000,1400,180),
 (6,5,'2026-06-29','YouTube',73000,900,60),
 (7,1,'2026-06-30','Spotify',39000,2900,195),
 (8,2,'2026-06-30','Spotify',47000,1050,85),
 (9,3,'2026-06-30','Spotify',21000,3000,410),
 (10,4,'2026-06-30','AppleMusic',11000,1700,220),
 (11,5,'2026-06-30','YouTube',69000,850,55);
-- Q1: Fan conversion — save rate + playlist conversion, ranked
SELECT
  t.track_name, t.artist,
  SUM(s.streams)       AS total_streams,
  SUM(s.saves)         AS total_saves,
  SUM(s.playlist_adds) AS total_playlist_adds,
  ROUND(100.0 * SUM(s.saves) / SUM(s.streams), 2)         AS save_rate_pct,
  ROUND(100.0 * SUM(s.playlist_adds) / SUM(s.streams), 2) AS playlist_conv_pct
FROM streams_daily s
JOIN tracks t ON t.track_id = s.track_id
GROUP BY t.track_name, t.artist
ORDER BY save_rate_pct DESC;

-- Q2: Which platform drives plays but weak saves?
SELECT
  platform,
  SUM(streams) AS total_streams,
  ROUND(100.0 * SUM(saves) / SUM(streams), 2) AS avg_save_rate_pct
FROM streams_daily
GROUP BY platform
ORDER BY total_streams DESC;
