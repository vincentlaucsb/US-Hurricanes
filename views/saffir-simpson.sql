CREATE OR REPLACE FUNCTION saffir_simpson(knots double precision)
RETURNS text AS $$
BEGIN
    IF knots >= 137 THEN
        RETURN 'Category 5';
    ELSIF knots >= 113 THEN
        RETURN 'Category 4';
    ELSIF knots >= 96 THEN
        RETURN 'Category 3';
    ELSIF knots >= 83 THEN
        RETURN 'Category 2';
    ELSIF knots >= 64 THEN
        RETURN 'Category 1';
    ELSIF knots >= 34 THEN
        RETURN 'Tropical Storm';
    ELSE
        RETURN 'Tropical Depression';
    END IF;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

CREATE OR REPLACE FUNCTION saffir_simpson_color(knots double precision)
RETURNS text AS $$
BEGIN
    IF knots >= 137 THEN
        RETURN '#ff6060';
    ELSIF knots >= 113 THEN
        RETURN '#ff8f20';
    ELSIF knots >= 96 THEN
        RETURN '#ffc140';
    ELSIF knots >= 83 THEN
        RETURN '#ffe775';
    ELSIF knots >= 64 THEN
        RETURN '#ffffcc';
    ELSIF knots >= 34 THEN
        RETURN '#00faf4';
    ELSE
        RETURN '#5ebaff';
    END IF;
END;
$$ LANGUAGE plpgsql IMMUTABLE;