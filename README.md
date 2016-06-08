# Apache Hadoop latest Docker image
derived from: [![DockerPulls](https://img.shields.io/docker/pulls/sequenceiq/hadoop-docker.svg)](https://registry.hub.docker.com/u/sequenceiq/hadoop-docker/)

# Build the image
```bash
docker build  -t hadoop-docker .
```

# Pull the image

```bash
docker pull p4km9y/hadoop-docker
```

# Start a container
```
docker run -it p4km9y/hadoop-docker /etc/bootstrap.sh -bash
```

## Testing
You can run one of the stock examples:

```bash
cd $HADOOP_PREFIX
# run the mapreduce
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.x.jar grep input output 'dfs[a-z.]+'
# check the output
bin/hdfs dfs -cat output/*
```

