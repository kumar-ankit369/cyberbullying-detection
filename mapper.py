import sys
import csv
import re

reader = csv.reader(sys.stdin)

for row in reader:
    try:
        text = row[0]   # tweet column
        words = text.lower().split()
        for word in words:
            print(f"{word}\t1")
    except:
        continue
