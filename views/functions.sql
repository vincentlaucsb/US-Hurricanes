CREATE OR REPLACE FUNCTION array_min(input anyarray)
    RETURNS anyelement AS
$$ SELECT min(x) FROM unnest(input) x; $$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION array_max(input anyarray)
    RETURNS anyelement AS
$$ SELECT max(x) FROM unnest(input) x; $$
LANGUAGE sql;

-- Turns "TEXT" or 'text' into "Text"
CREATE OR REPLACE FUNCTION normal_case(input text) RETURNS TEXT AS
$$ SELECT upper(left(input, 1)) || lower(right(input, -1)); $$
LANGUAGE sql;

-- Return the path of a hurricane along with associated data
/*
Usage example
    SELECT * FROM hurricane_path('CAROL', 1954);
*/
DROP FUNCTION hurricane_path(text,integer);
CREATE OR REPLACE FUNCTION hurricane_path(name_ text, season_ int) RETURNS
    TABLE(
        hurricane_name text, lon float, lat float, wind_max_kt float, datetime text,
        sshs text) AS
$$
BEGIN
    -- TODO: Make this return "Tropical Storm X" and "Tropical Depression X" for
    -- applicable storms
    hurricane_name := format('Hurricane %s (%s)', normal_case(name_), season_);

    RETURN QUERY WITH hurricane AS
        (SELECT path_intensity FROM hurricane_summary
        WHERE name LIKE name_ AND season = season_)
    SELECT hurricane_name, * FROM json_to_recordset(
        array_to_json((SELECT * FROM hurricane)))
    AS x(lon float, lat float, wind_max_kt float, time text, sshs text);
END;
$$ LANGUAGE plpgsql;