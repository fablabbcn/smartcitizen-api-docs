# Devices

## World Map of Devices

> ### Definition
GET https://new-api.smartcitizen.me/v0/devices/world_map

```shell
$ curl -G https://new-api.smartcitizen.me/v0/devices/world_map

HTTP/1.1 200 OK
{
  "added_at": "2015-02-02T15:59:48.435Z",
  "city": "Haarlem",
  "country_code": "NL",
  "data": {
    "12": 14.38578857421875,
    "12_raw": 25132,
    "13": 64.3577880859375,
    "13_raw": 30072,
    "14": 0.0,
    "14_raw": 0,
    "15": 133.482,
    "15_raw": 133482,
    "16": 41.951,
    "16_raw": 41951,
    "17": 80.0,
    "17_raw": 800,
    "18": 0,
    "21": 13,
    "7": 50.0,
    "7_raw": 0,
    "added_at": "2015-04-28T14:16:08.238Z",
    "calibrated_at": "2015-04-28T14:16:08.238Z",
    "recorded_at": "2015-04-28T14:16:08.238Z"
  },
  "description": "",
  "exposure": "indoor",
  "id": 625,
  "kit_id": 3,
  "latitude": 52.3781227,
  "longitude": 4.6291324,
  "name": "SmartHaarlem",
  "owner_id": 667,
  "owner_username": "SmartHaarlem",
  "status": "offline"
}
...
```

Returns an array with of summarized device objects for displaying on the world map.

<aside class='warning'>Note: This does not load super-fast right now, but it will load instantly in the next couple of days</aside>

<aside class='notice'>This endpoint will be cached, therefore you will not be able to use parameters to paginate, search or sort the results. We recommend that you filter the json on the client-side.</aside>

Parameter | Example | Description
--------- | ------- | -----------
**id**<br/>*integer* | 1619 | Unique ID of the device
**name**<br/>*string* | Long Lane, SE1 (new) | Name of the device
**description**<br/>*string* | An SCK in Southwark | Description of the device
**owner_id**<br/>*integer* | 848 | Unique ID of the device's owner
**owner_username**<br/>*string* | dankarran | Unique username of the device's owner
**latitude**<br/>*decimal* | 51.4996843 | Latitude of the device
**longitude**<br/>*decimal* | -0.086883400000033 | Longitude of the device
**city**<br/>*string* | Southwark | City of the device
**country_code**<br/>*string* | GB | Alpha-2 Country Code of the device
**kit_id**<br/>*integer* | 3 | Kit that the device belongs to
**status**<br/>*string* | offline | Can be offline, online or new
**exposure**<br/>*string* | indoor | Can be indoor or outdoor
**data**<br/>*object* | {<br/> 7: 50.0,<br/>7_raw: 0,<br/>recorded_at: "2015-04-30T17:56:04.432Z",<br/>calibrated_at: "2015-04-30T17:56:04.432Z",<br/>added_at: "2015-04-30T17:56:04.432Z" <br/>} | The latest readings stored for the device. Numerical keys are sensor ids. <br/><br/>So 7 is the calibrated reading of `/v0/sensors/7`<br/><br/>`7_raw` is what was posted to the platform.
**added_at**<br/>*datetime* | "2015-04-30T17:56:04.432Z" | When the device was added to the platform

## Add a Device

> ### Definition
POST https://new-api.smartcitizen.me/v0/devices

You must be authenticated to add a device. The currently authenticated user will be registered as the `owner` of the new device.

Parameter | Required? | Description
--------- | ------- | -----------
**name**<br/>*string* | ✓ | Name of the device
**description**<br/>*string* | | Description of the device
**mac_address**<br/>*string* | ✓ | MAC Address of the device
**kit_id**<br/>*integer* | | Unique ID of the [kit](#kits) for the device
**exposure**<br/>*string* | | Either `indoor` or `outdoor`
**latitude**<br/>*decimal* | | Latitude of the device
**longitude**<br/>*decimal* | | Longitude of the device

## Update a Device

> ### Definition
PATCH https://new-api.smartcitizen.me/v0/devices/:id

You must be authenticated and registered as the device's `owner` if you wish to update a device.

Parameter | Example | Description
--------- | ------- | -----------
**id**<br/>*integer* | 2 | Unique ID of the device
**name**<br/>*string* | Beach SCK | Name of the device
**description**<br/>*string* | A Smart Citizen on the Beach | Description of the device
**mac_address**<br/>*string* | 00:1C:B3:09:85:15 | MAC Address of the device
**kit_id**<br/>*integer* | 3 | Unique ID of the [kit](#kits) for the device
**exposure**<br/>*string* | | Either `indoor` or `outdoor`
**latitude**<br/>*decimal* | 41.401108 | Latitude of the device
**longitude**<br/>*decimal* | 2.215319 | Longitude of the device

## Get a Device

> ### Definition
GET https://new-api.smartcitizen.me/v0/devices/:id

```
$ curl -G https://new-api.smartcitizen.me/v0/devices/3
```

Returns a single device. Example of a complete response - [http://new-api.smartcitizen.me/v0/devices/1616](http://new-api.smartcitizen.me/devices/1616)

Parameter | Example | Description
--------- | ------- | -----------
**id**<br/>*integer* | 2 | Unique ID of the device
**owner**<br/>*object* | [user](#get-a-user) | The user that owns the device
**name**<br/>*string* | Beach SCK | Name of the device
**description**<br/>*string* | A Smart Citizen on the Beach | Description of the device
**status**<br/>*string* | new | `new` if never updated,<br/>`online` if updated less than 10 minutes ago,<br/> `offline` if updated more than 10 minutes ago
**added_at**<br/>*datetime* | 2015-02-02T15:59:48.109Z | When the device was added to the platform
**last_reading_at**<br/>*datetime* | 2015-02-02T15:59:48.109Z | When the device last posted a reading to the platform
**updated_at**<br/>*datetime* | 2015-02-02T15:59:48.109Z | When the device was last updated
**data**<br/>*object* | [data-object](#data-object) | The latest data for the device *(see table below)*
**kit**<br/>*object* | [kit](#kits) | Information about the kit that the device is
**mac_address**<br/>*string* | 00:1C:B3:09:85:15 | Shown if current_user is authenticated and is owner of the device. MAC Address of the device

#### Data Object

Parameter | Example | Description
--------- | ------- | -----------
**recorded_at**<br/>*datetime* | 2015-02-11T10:03:36.653Z | When the device's data was recorded
**added_at**<br/>*datetime* | 2015-02-11T10:03:36.653Z | When the device's data was posted to the platform
**calibrated_at**<br/>*datetime* | 2015-02-11T10:03:36.653Z | When the device's data was calibrated by the platform
**firmware**<br/>*string* | *[IGNORE]* | Ignore for now
**location.ip**<br/>*string* | | Ignore for now
**location.exposure**<br/>*string* | `indoor` or `outdoor` | Where the device is located
**location.elevation**<br/>*integer* | 500 | Measured in metres
**location.latitude**<br/>*decimal* | 39.1529768625514 | Latitude
**location.longitude**<br/>*decimal* | -77.2663983320978 | Longitude
**location.geohash**<br/>*string* | dqcn9z86d7 | [Geohash explanation](http://www.bigfastblog.com/geohash-intro)
**location.city**<br/>*string* | Germantown | City where the device is
**location.country_code**<br/>*string* | US | Alpha-2 country code where the device is
**location.country**<br/>*string* | United States | Country name generated from `country_code`
**sensors**<br/>*array* | [[sensor](#sensors), [sensor](#sensors)] | An array of sensor objects, with the `value` (final calibrated reading) and `raw_value` (uncalibrated reading) injected into them.

## Get All Devices

> ### Definition
GET https://new-api.smartcitizen.me/v0/devices

```
$ curl -G https://new-api.smartcitizen.me/v0/devices
```

Returns all devices, with the same data as [above](#get-a-device).

Parameter | Example | Description
--------- | ------- | -----------
**near**<br/>*string<br/>(lat,lng)* | 41.401108,<br/>2.215319 | When included, returns devices in order of distance from the coordinates

## Remove a Device

> ### Definition
`DELETE https://new-api.smartcitizen.me/v0/devices/102`

You can only delete devices that you own.
