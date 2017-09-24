import pgreaper

pgreaper.copy_csv(
    'Allstorms.ibtracs_all.v03r09.csv.gz',
    compression='gzip',
    name='ibtracs_allstorms',
    dbname='us_wth',
    header=1,
    skip_lines=1)