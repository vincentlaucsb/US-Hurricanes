ALTER TABLE storm_events_details_reject ALTER COLUMN magnitude TYPE double precision USING magnitude::double precision;
ALTER TABLE storm_events_details ALTER COLUMN tor_width TYPE double precision USING tor_width::double precision;
ALTER TABLE storm_events_details ALTER COLUMN tor_other_cz_fips TYPE text USING tor_other_cz_fips::text;
INSERT INTO storm_events_details SELECT * FROM storm_events_details_reject;
DROP TABLE storm_events_details_reject;