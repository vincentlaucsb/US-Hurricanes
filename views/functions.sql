CREATE OR REPLACE FUNCTION array_min(input anyarray)
    RETURNS anyelement AS
$$ SELECT min(x) FROM unnest(input) x; $$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION array_max(input anyarray)
    RETURNS anyelement AS
$$ SELECT max(x) FROM unnest(input) x; $$
LANGUAGE sql;