-- Enable debugger
create extension pldbgapi;

CREATE OR REPLACE FUNCTION pdi (data jsonb[]) RETURNS double precision AS $$
DECLARE
    pdi double precision = 0;
    timeframe jsonb;
    wind_speed double precision;
    wind_speeds double precision[];
    times timestamp[];
BEGIN
    -- Get wind speeds and times into an array
    FOREACH timeframe IN ARRAY data LOOP
        wind_speed := (timeframe->>'wind_max_kt')::double precision;
        -- Ignore non-tropical cyclone force winds
        IF (wind_speed < 33) THEN
            wind_speeds := array_append(wind_speeds, 0::float);
        ELSE
            wind_speeds := array_append(wind_speeds, wind_speed);
        END IF;
        
        times := array_append(times, (timeframe->>'time')::timestamp);
    END LOOP;
    
    -- Calculate integral
    FOR i IN 1..array_length(wind_speeds, 1) LOOP
        -- Avoid index error on last wind speed and time
        IF i != array_length(wind_speeds, 1) THEN
            pdi := pdi + (wind_speeds[i]^3 * (EXTRACT(hours FROM times[i + 1] - times[i]))/6);
        ELSE
            pdi := pdi + wind_speeds[i]^3;
        END IF;
    END LOOP;
    
    RETURN pdi;
END $$ LANGUAGE plpgsql;