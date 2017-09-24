import pgreaper
import psycopg2
import timeit
import re
import os

csvs = [f for f in os.listdir('data') if '.csv.gz' in f]
csvs.reverse()
        
# Load to Postgres
def load():    
    for f in csvs:
        groups = re.match('StormEvents_(.*)-ftp_v1.0_d([1234567890]*)', f)
        
        # Merge related datasets into one table
        name = 'storm_events_' + groups.group(1)

        if groups.group(1) == 'details':
            pgreaper.copy_csv(
                os.path.join('data', f),
                name = name,
                compression='gzip',
                p_key = 'event_id',
                dbname='us_wth')
            print("Loaded", name)

# 148.26134997333332 seconds --> 1.16 GB uncompressed
# 237.47146666666666 to merge all into one table
if __name__ == '__main__':
    print(timeit.timeit(load, globals=globals(), number=1))