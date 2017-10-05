--
    -- Build a geometry object of the entire path of the hurricane
	array_agg(ST_SetSRID(ST_MakePoint(longitude_for_mapping,
               latitude_for_mapping), 4269)) as points,

-- Fix issues with lines that cross +- 180deg longitude
CREATE FUNCTION shift_longitude(points float[]) RETURNS geom[] AS $$
    -- If an array of points, when converted to a line, crosses the 
    -- antimeridian, then add 360 to negative longitude coordinates
DECLARE
    boolean has_pos_pts := false;
    boolean has_neg_pts := false;
    float pt;
    geom[] ret_array;
BEGIN
    FOREACH pt IN ARRAY points LOOP
        IF pt < 0 THEN
            has_neg_pts := true;
        ELSIF pt > 0 THEN
            has pos_pts := true;
        END IF;
    END LOOP;
    
    FOREACH pt IN ARRAY points LOOP
        IF (has_pos_pts AND has_neg_pts) AND (pt < 0) THEN
            
    END LOOP;
END;
$$ LANGUAGE plpgsql;