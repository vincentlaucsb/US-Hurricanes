WITH possible_pts AS (SELECT * FROM storm_events
WHERE begin_yearmonth = 200508 OR begin_yearmonth = 200509)
SELECT *
FROM
	possible_pts
JOIN
	(SELECT * FROM hurricane_summary WHERE name = 'KATRINA' and season = 2005) as katrina
ON
	(ST_Distance(begin_point, katrina.path) < 150 OR ST_Distance(end_point, katrina.path) < 150)
    OR
    (tsrange(katrina.begin - interval '24 hours', katrina.end + interval '24 hours') @> begin_date_time2)


-- Get all hurricanes that made landfall in Florida
SELECT serial_num, name, season, sshs_peak, st_length(path)
FROM hurricane_summary
WHERE wind_max_kt > 50
AND (ST_Crosses((SELECT geom FROM us_states WHERE name = 'Louisiana'), path)
OR ST_Crosses((SELECT geom FROM us_states WHERE name = 'Florida'), path))
AND name != 'UNNAMED'
AND st_length(path) < 300; -- Flipped minus sign error causes typhoons to be teleported across the world