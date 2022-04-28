Journey class

extract functionality from Oystercard class:
- touch_in (registering entry station)
- touch_out (registering exit_station, calculating fare)
- in_journey? (journey is complete?)

Instance Variables:
- entry_station (inside hash)
- exit_station (inside hash)


what we want to happen when touch_in:
- check balance (fail if balance is not enough)
- create a new journey (Journey class)
- store entry station inside current journey information hash

what we want to happen when touch out:

- store exit station inside current journey information hash
- calculate fare
- deduct money from card
