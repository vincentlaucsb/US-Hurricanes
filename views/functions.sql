CREATE OR REPLACE FUNCTION array_min(input anyarray)
    RETURNS anyelement AS
$$ SELECT min(x) FROM unnest(input) x; $$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION array_max(input anyarray)
    RETURNS anyelement AS
$$ SELECT max(x) FROM unnest(input) x; $$
LANGUAGE sql;

-- Return the path of a hurricane along with associated data
/*
Usage example
    SELECT * FROM hurricane_path('CAROL', 1954);
*/
CREATE OR REPLACE FUNCTION hurricane_path(name_ text, season_ int) RETURNS
    TABLE(lon float, lat float, wind_max_kt float, datetime text, sshs text) AS
$$
WITH hurricane AS (SELECT path_intensity FROM hurricane_summary
WHERE name LIKE name_ AND season = season_)
SELECT * FROM json_to_recordset(array_to_json((SELECT * FROM hurricane)))
AS x(lon float, lat float, wind_max_kt float, time text, sshs text)
$$
LANGUAGE sql;