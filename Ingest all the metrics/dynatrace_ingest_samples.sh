#! using dynatrace_ingest tool for simple metrics ingest via OneAgent
# Metric format: metric.key[,dimension_key=dimension_value] payload
# E.g.: cpu.temperature cpu=cpu1 55

#Sample 1 - 2 different metrics (cpu-idle and cpu-user) split by core
mpstat -P ALL | tail -n +5 | awk {'print "mymetric.host.cpu.usr,core="$2" "$3"\nmymetric.host.cpu.idle,core="$2" "$12;'} | dynatrace_ingest -v
#Sample 2 - 1 metric, top 10 process cpu usage split by process-id
ps -eo pcpu,pid,user,args --no-headers | sort -k 1 -r | head -10 | awk {'print "mymetric.cpu_pid,pid="$2" " $1;'} | dynatrace_ingest -v
