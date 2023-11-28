import sys
from operator import add
from pyspark.sql import SparkSession

sc = SparkSession.builder.appName("pywc").master("spark://nodo1:7077").getOrCreate()
lines = sc.read.text("/tmp/expand/P1/2000-0.txt").rdd.map(lambda r: r[0])
counts = lines.flatMap(lambda x: x.split(' ')) \
              .map(lambda x: (x, 1)) \
              .reduceByKey(add) \
              .sortBy(lambda x: x[1], False)
output = counts.collect()
print(counts.take(10))
counts.saveAsTextFile("/tmp/expand/P1/pg2000-w")
sc.stop()
quit()
