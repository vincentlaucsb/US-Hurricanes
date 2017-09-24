import pgreaper
import psycopg2
import timeit
import re
import os

csvs = [f for f in os.listdir('data') if '.csv.gz' in f]

# Reverse the list so newest files get added first
# (Newer files have less NULL values --> better schema inference)
csvs.reverse()

# # Spot check renaming
# for i, j in enumerate(csvs):
    # if i%10 == 0:
        # groups = re.match('StormEvents_(.*)-ftp_v1.0_d([1234567890]*)', j)
        # print('storm_events_' + groups.group(1) + '_' + groups.group(2))
        
# Load to Postgres
def load():    
    for f in csvs:
        groups = re.match('StormEvents_(.*)-ftp_v1.0_d([1234567890]*)', f)
        
        # Merge related datasets into one table
        name = 'storm_events_' + groups.group(1)

        if groups.group(1) == 'fatalities':
            pgreaper.copy_csv(
                os.path.join('data', f),
                name = name,
                p_key = ('fatality_id', 'event_id'),
                compression='gzip',
                dbname='us_wth')
            print("Loaded", name)

# 4.66612992 seconds
if __name__ == '__main__':
    print(timeit.timeit(load, globals=globals(), number=1))