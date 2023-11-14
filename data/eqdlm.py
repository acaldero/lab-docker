import sys
from operator import add
from pyspark.sql import SparkSession

sc = SparkSession.builder.appName("pywc").master("spark://nodo1:7077").getOrCreate()
lines = sc.read.text("/home/lab/data/2000-0.txt").rdd.map(lambda r: r[0])
counts = lines.flatMap(lambda x: x.split(' ')) \
              .map(lambda x: (x, 1)) \
              .reduceByKey(add)
output = counts.collect()
counts.saveAsTextFile("/home/lab/data/pg2000-w")
sc.stop()
quit()
