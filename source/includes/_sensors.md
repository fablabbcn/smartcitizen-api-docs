# Sensors

<aside class='warning'>Sensors are currently READ-ONLY as they are an administration concern. This will change.</aside>

<aside class='notice'>Every device belongs to a kit. And every kit has many sensors. So every device has one kit, which has many sensors.</aside>

Every [device](#devices) has `sensor(s)`. A `sensor` is something on a `device` that can record data. This could be anything, some examples are - temperature, humidity, battery percentage, # wifi networks.

## Get all Sensors

> ### Definition
`GET https://new-api.smartcitizen.me/v0/sensors`

```shell
$ curl -G https://new-api.smartcitizen.me/v0/sensors
[
  {
    "id" : 3,
    "parent_id" : null,
    "name" : "DHT22",
    "description" : "Digital Temperature and Relative Humidity Sensor",
    "unit" : null,
    "created_at" : "2015-02-02T18:14:15.199Z",
    "updated_at" : "2015-02-02T18:14:15.199Z"
  },
  {
    "id" : 4,
    "parent_id" : 3,
    "name" : "DHT22 - Temperature",
    "description" : "Temperature",
    "unit" : "ºC",
    "created_at" : "2015-02-02T18:15:14.132Z",
    "updated_at" : "2015-02-02T18:15:14.132Z"
  },
  {
    "id" : 5,
    "parent_id" : 3,
    "name" : "DHT22 - Humidity",
    "description" : "Humidity",
    "unit" : "%",
    "created_at" : "2015-02-02T18:15:34.891Z",
    "updated_at" : "2015-02-02T18:15:34.891Z"
  }
...
```

Sensors can contain multiple sub-sensors, such as the DHT-22, which records temperature and humidity. In the CURL example `Sensor(id=3)` will not record any data, it is only in the database for organisational reasons.
