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

        try:
            if groups.group(1) == 'locations':
                pgreaper.copy_csv(
                    os.path.join('data', f),
                    name = name,
                    p_key = ('episode_id', 'event_id', 'location_index'),
                    compression='gzip',
                    dbname='us_wth')
                print("Loaded", name)
        except KeyError:
            # Upon manual inspection, it appears KeyErrors are caused by...
            # empty CSV files... you've got to be shitting me
            pass

# 21.567743573333335
if __name__ == '__main__':
    print(timeit.timeit(load, globals=globals(), number=1))