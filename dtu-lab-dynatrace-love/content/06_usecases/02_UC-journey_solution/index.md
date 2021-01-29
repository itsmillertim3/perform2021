## UseCase JourneyUpdateSlow - Solution

### Please take 5 minutes and digest this information.

Dynatrace showed that the frontend calls 6 times the journeyService. 1 time the `findLocations()` (slight rt increase) and 5 times the `findJourneys()` with an increase of _~380 ms_ per call. The increase in `findJourneys()` is mostly in _Lock/Wait_ time, letting us know also that there are new querys being executed. The contribution of the queries itself is not the problem (responsetime wise except from one new query with _~ 80ms_) but the code, meaning the Database is performant but not the implementation. The rest of the time _~ +240ms_ is in _LockWait… time, meaning the calls are non performant and subsequent.

![](../../../../assets/images/meme_think.png)

Please take a moment and digest the amount and level of insights Dynatrace gave you with a few clicks. If you know how to filter and where to click, it is absolutely insane the depth and amount of insights that Dynatrace provides OOTB to the Developers and DevOps.
And again, we are just testing the Frontend URL and did not configure anything but how to record the loadtest (HTTP Headers).