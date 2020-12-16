import requests, time, sched, random, datetime, sys, statsd

def send_test_metrics():
    #Create StatsD Client Connection - Port 18125 = default OneAgent
    c = statsd.StatsClient('localhost', 18125, prefix='statsd_custom')

    #Define & Push Metrics via StatsD
    print("Sending sample metrics via statsd...")
    #simple incrementing counter
    c.incr('bar')
    c.incr('counter_with_dim', tags = {"key1": "value1", "key2":"value2"})
    #Simple timer
    c.timing('example.response_time', 80) # record 80ms response time
    #Gauges
    c.gauge('foo', 70)  # Set the 'foo' gauge to 70.
    c.gauge('samplevalue', random.randint(100,500))
    #Send metric with tags (= dimensions)
    c.gauge('gauge_with_dim', 42, tags = {"key1": "value1", "key2":"value2"})    

def doit():
    scheduler.enter(60, 1, doit)
    send_test_metrics()

scheduler = sched.scheduler(time.time, time.sleep)
scheduler.enter(1, 1, doit)
scheduler.run()
