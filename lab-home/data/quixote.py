import sys
import argparse
from   operator import add
from   pyspark.sql import SparkSession

parser = argparse.ArgumentParser()
parser.add_argument("--master",  help="spark://nodo1:7077")
parser.add_argument("--minput",  help="/home/lab/data/2000-0.txt")
parser.add_argument("--moutput", help="/home/lab/data/2000-wc")
args = parser.parse_args()

master  = "spark://nodo1:7077"
minput  = "/home/lab/data/2000-0.txt"
moutput = "/home/lab/data/2000-wc"
if args.master:
    master  = args.master
if args.minput:
    minput  = args.minput
if args.moutput:
    moutput = args.moutput

sc = SparkSession.builder.appName("pywc").master(master).getOrCreate()
lines = sc.read.text(minput).rdd.map(lambda r: r[0])
counts = lines.flatMap(lambda x: x.split(' ')) \
              .map(lambda x: (x, 1)) \
              .reduceByKey(add) \
              .sortBy(lambda x: x[1], False)
output = counts.collect()
print(counts.take(10))
counts.saveAsTextFile(moutput)
sc.stop()

quit()
