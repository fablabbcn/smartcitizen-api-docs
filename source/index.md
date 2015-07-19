---
title: SmartCitizen API Reference

includes:
  - errors

search: true
---

# Summary

> ### Definition
https://new-api.smartcitizen.me

> ### Summary of Resources

```
/v0/me
/v0/users/:id
/v0/devices/:id
/v0/kits/:id
/v0/sensors/:id
```


The Smartcitizen V0 API is a publicly available interface allowing developers access to the smartcitizen dataset. The interface is stable and currently used by the Strava mobile applications. However, changes are occasionally made to improve performance and enhance features. See the changelog for more details.

## Versioning

By default, all requests receive the v0 version of the API. We encourage you to explicitly request this version via the URL or the HTTP Accept header.

 | endpoint
---- | ------------------------------------
**BAD** | https://new-api.smartcitizen.me/users
**GOOD** | https://new-api.smartcitizen.me/v0/users


`Accept: application/vnd.smartcitizen; version=0,application/json`

## Schema

All API access is over HTTPS (with the exception of `/add`) and accessed via `new-api.smartcitizen.me`.

<aside class="notice">This will eventually change to https://api.smartcitizen.me</aside>


Blank fields are included as `null` instead of being omitted.

All timestamps are returned in ISO 8601 format:

`YYYY-MM-DDTHH:MM:SSZ`

## Root Endpoint

You can issue a GET request to the root endpoint to get all the endpoint categories that the API supports:

`$ curl https://new-api.smartcitizen.me`


## JSON-P Callbacks

You can send a `?callback` parameter to any GET call to have the results wrapped in a JSON function.

## Postman

We recommend that you try our API using [Postman](https://www.getpostman.com/), we have created a shared collection that you can import from here [https://www.getpostman.com/collections/85a92402907e3cb07759](https://www.getpostman.com/collections/85a92402907e3cb07759)


# Authentication

There are 3 ways you can access the API. OAuth 2.0 is the recommended method.

## OAuth 2.0

```shell
# OAuth2 Token (sent as a parameter)
$ curl -G https://new-api.smartcitizen.me/v0/me?access_token=OAUTH-TOKEN

# OAuth2 Token (sent in a header)
$ curl -H "Authorization: token OAUTH-TOKEN" https://new-api.smartcitizen.me/v0/me
```

<aside class="success">This is the recommended and safest way to access the API.</aside>

A basic example resides here [https://example.smartcitizen.me](https://example.smartcitizen.me) and its source code is here [https://github.com/johnrees/smartcitizen-oauth-example](https://github.com/johnrees/smartcitizen-oauth-example).

[https://id.smartcitizen.me](https://id.smartcitizen.me) currently uses [Doorkeeper gem](https://github.com/doorkeeper-gem/doorkeeper) for managing the OAuth component but that is subject to change.

Applications can be added here [https://id.smartcitizen.me/oauth/applications](https://id.smartcitizen.me/oauth/applications). Whilst in development this is completely open for public access but this will change.

POSTman settings are as follows -

![Postman settings](https://i.imgur.com/TzIkLSQ.png)

The correct `Client ID` and `Client Secret` can be found at [https://id.smartcitizen.me/oauth/applications](https://id.smartcitizen.me/oauth/applications).


## HTTP Basic Auth

```shell
# Add a base64 encoded hash of 'username:password' in the header
curl 'https://new-api.smartcitizen.me/v0/me' -H 'Authorization: Basic am9objpzbWFydHBhc3M='

# NOT RECOMMENDED - add username and password in the header
curl 'https://new-api.smartcitizen.me/v0/me' --user username:password
```

This method enables you to authenticate your requests with your username and password. Despite using SSL we do not recommend this method as it can be very easy to accidentally share your secret credentials.

## HTTP Token Authentication

```shell
$ curl 'https://new-api.smartcitizen.me/v0/me' -IH "Authorization: Token token=b32a8e54b11c4de5a4a351734c80a14a"
```

<aside class="warning">This method will be deprecated soon, we are keeping it during the transition from the legacy API.</aside>

You should not use this approach for new applications.

# Filtering Responses

## Pagination

```shell
$ curl --include 'https://new-api.smartcitizen.me/v0/users?page=5'
HTTP/1.1 200 OK
Link: <https://new-api.smartcitizen.me/v0/users?page=1>; rel="first",
  <https://new-api.smartcitizen.me/v0/users?page=173>; rel="last",
  <https://new-api.smartcitizen.me/v0/users?page=6>; rel="next",
  <https://new-api.smartcitizen.me/v0/users?page=4>; rel="prev"
Total: 4321
Per-Page: 25
```

Most endpoints that return more than a single result e.g. `/v0/users`, `v0/devices` will return blocks of the result set that can be manipulated using the following parameters.

Parameter | Default | Description
--------- | ------- | -----------
**page**<br/>*integer* | 1 | page
**per_page**<br/>*integer* | 25 | page

The headers will include links to the `Total` results count, number of results shown `Per-Page` and `first`, `last`, `next` and `previous` results.

## Global Search

> ### Definition
GET https://new-api.smartcitizen.me/v0/search

```shell
curl "https://new-api.smartcitizen.me/v0/search?q=anastasia"
```

> The above command returns JSON structured like this:

```json
[
  {
    "id" : 32,
    "type" : "User",
    "username" : "anastasia",
    "avatar" : null,
    "city" : null,
    "country_code" : null
  },
  {
    "id" : 56,
    "type" : "Device",
    "name" : "nat kit",
    "description" : "nat kit at home",
    "owner_id" : 32,
    "owner_username" : "anastasia",
    "city" : "Barcelona",
    "country_code" : "ES"
  }
]
```


<aside class='warning'>THE RESPONSE FOR THIS ENDPOINT WILL PROBABLY CHANGE. But you can use it now and we will add ?version=1, ?version=2... to the URL so it is reliable.</aside>

To search both Users and Devices at the same time you can use the global search endpoint.

### Required Parameters

Parameter | Description
--------- | -----------
**q**<br/>*string* | Query string

### Response

There can be two types of object included in the response array, [Devices](#devices) and [Users](#users).

#### Device Object

Parameter | Description
--------- | -----------
**id**<br/>*integer* | Unique ID for the device
**name**<br/>*string* | Name of the device
**owner_id**<br/>*integer* | Unique ID of the device's owner
**owner_username**<br/>*string* | Unique username of the device's owner
**city**<br/>*string* | City the device is in
**country_code**<br/>*string* | Alpha-2 country code of the device

#### User Object

Parameter | Description
--------- | -----------
**id**<br/>*integer* | Unique ID for the user
**username**<br/>*string* | Unique username of the user
**avatar**<br/>*string* | URL of the user's avatar
**city**<br/>*string* | City the user is in
**country_code**<br/>*string* | Alpha-2 country code of the user

## Basic Searching

Similar to the [pagination](#pagination), you can filter and sort most responses that return more than one result. This is done with the [ransack](https://github.com/activerecord-hackery/ransack) library.

[https://github.com/activerecord-hackery/ransack/wiki/Basic-Searching](https://github.com/activerecord-hackery/ransack/wiki/Basic-Searching)

Query | Type | Value | Description
--------- | ------- | ------- | -----------
/users?q[**first_name_eq**]=adam | string | adam | Users where first name equals 'Adam'
/devices?q[**owner_id_eq**]=1 | integer | 1 | Devices where owner ID equals 1
/sensors?q[**id_lt**]=100 | integer | 100 | Sensors where ID less than 100
/users?q[**username_cont**]=sck | string | sck | Users where username contains 'sck'

## Sorting Results

You can order results with the `q[sort]` parameter

Parameter | Value | Description
--------- | ------- | -----------
**/users?q[sort]=username%20asc**<br/>*string* | username asc | Users ordered by username in ASCENDING order
**/devices?q[sort]=id%20desc**<br/>*integer* | id desc | Devices ordered by id in DESCENDING order

## Pretty Printing

```shell
# Default Minimal Response
curl "https://new-api.smartcitizen.me/v0/sensors/10"

{"id":10,"name":"Battery","description":"Custom Circuit","unit":"%","created_at":"2015-02-02T18:18:00.276Z","updated_at":"2015-02-02T18:18:00.276Z"}

# Pretty Response
curl "https://new-api.smartcitizen.me/v0/sensors/10?pretty=true"

{
  "id" : 10,
  "name" : "Battery",
  "description" : "Custom Circuit",
  "unit" : "%",
  "created_at" : "2015-02-02T18:18:00.276Z",
  "updated_at" : "2015-02-02T18:18:00.276Z"
}
```

You can format responses so that they are easier to read by adding `pretty=true` to a request.

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


# Readings

<aside class='notice'>Every device has readings. A reading is a value recorded by one of its sensors.</aside>

## Get Latest Readings

> ### Definition
`GET https://new-api.smartcitizen.me/v0/devices/:id`

**(for a device)**

The latest set of readings is included with the device, so if you call `/v0/devices/:id` you will see the most recent set of readings embedded in `data.sensors` as `value` and `raw_value`.

## Get Historical Readings

> ### Definition
`GET https://new-api.smartcitizen.me/v0/devices/:id/readings`

# Kits

At the moment, every [device](#devices) has one [kit](#kits). In the future this will change, as some devices might not be associated with a [kit](#kits). However, you can assume that every device is associated with a kit right now.

## Get All Kits

> ### Definition
`GET https://new-api.smartcitizen.me/v0/kits`

<aside class='notice'>There are currently 2 variations of kit, the SCK 1.0 and SCK 1.1.</aside>

More information about the current kits can be found on [github](https://github.com/fablabbcn/Smart-Citizen-Kit/blob/master/hardware/README.md)

# Users

## Add a User

> ### Definition
`POST https://new-api.smartcitizen.me/v0/users`

Most actions on the API require authenticated access. To obtain an [OAuth 2.0](#oauth-2.0) `access_token` the first step is to have a user account.

Parameter | Required? | Description
--------- | ------- | -----------
**first_name**<br/>*string* | | First name of the user
**last_name**<br/>*string* | | Last name of the user
**email**<br/>*string* | ✓ | Email address of the user
**username**<br/>*string* | ✓ | Username of the user
**password**<br/>*string* | ✓ | Password of the user
**city**<br/>*string* | | City where the user is located
**country_code**<br/>*string* | | [2 letter](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) country-code of the user
**url**<br/>*string* | | Webpage of the user
**avatar**<br/>*string* | | URL to the avatar of the user

## Get Current User

> ### Definition
`GET https://new-api.smartcitizen.me/v0/me`

> ### Example Request

``` shell
$ curl -G https://new-api.smartcitizen.me/v0/me \
    -H "Authorization: Bearer 94abeabdec09f6670863766f792ead24d61fe3f9"
```

Used to retrieve information about the currently authenticated user.
Returns a detailed representation of the user.

Parameter | Description
--------- | -----------
**id**<br/>*integer* | Unique ID for the user
**first_name**<br/>*string* | First name of the user
**last_name**<br/>*string* | Last name of the user
**email**<br/>*string* | Email address of the user
**username**<br/>*string* | Username of the user
**location.city**<br/>*string* | City where the user is located
**location.country_code**<br/>*string* | [2 letter](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) country-code of the user
**location.country**<br/>*string* | Automatically generated from country_code
**url**<br/>*string* | Webpage of the user
**avatar**<br/>*string* | URL to the avatar of the user
**joined_at**<br/>*datetime* | The date and time that the user joined the platform
**devices**<br/>*array* | Array of [devices](#devices) that the user manages on the platform

## Update Current User

> ### Definition
`PATCH https://new-api.smartcitizen.me/v0/me`

> ### Example Request

``` shell
$ curl -G https://new-api.smartcitizen.me/v0/me \
    -H "Authorization: Bearer 94abeabdec09f6670863766f792ead24d61fe3f9"
```
An authenticated user can update their own details. Same parameters used as [adding a user](#add-a-user)

## Reset a Password

1. `POST https://new-api.smartcitizen.me/v0/password_resets?username=USERNAME`
2. Email is sent to `User(username=USERNAME)` containing `PASSWORD_RESET_TOKEN`
3. `GET https://new-api.smartcitizen.me/v0/password_resets/PASSWORD_RESET_TOKEN` returns `User(username=USERNAME)` object
4. `PATCH https://new-api.smartcitizen.me/v0/password_resets/PASSWORD_RESET_TOKEN?password=NEW_PASSWORD`

## Get All Users

> ### Definition
GET https://new-api.smartcitizen.me/v0/users

```shell
curl -G https://new-api.smartcitizen.me/v0/users
```

This endpoint retrieves all users.

### HTTP Request

`GET https://new-api.smartcitizen.me/v0/users`

## Get a User

```shell
curl -G https://new-api.smartcitizen.me/v0/users/2

HTTP/1.1 200 OK
{
  "avatar": null,
  "devices": [
    {
      "added_at": "2015-02-02T15:59:50.225Z",
      "data": null,
      "description": "Test Kit for the Innovation Lab Kosovo, within the event Science for change / Citizen Science.",
      "id": 1357,
      "kit_id": 3,
      "last_reading_at": "2015-05-05T08:15:00.016Z",
      "latitude": 42.5813722,
      "longitude": 20.88935,
      "name": "Citizen Science Kit #1",
      "owner": "alex",
      "status": "new",
      "updated_at": "2015-02-11T18:48:42.663Z"
    }
  ],
  "first_name": null,
  "id": 2,
  "joined_at": "2015-02-02T15:54:37.656Z",
  "last_name": null,
  "location": {
    "city": null,
    "country": null,
    "country_code": null
  },
  "updated_at": "2015-02-02T15:54:37.656Z",
  "url": null,
  "username": "alex"
}
```

This endpoint retrieves a specific user.

### HTTP Request

`GET https://new-api.smartcitizen.me/v0/users/<ID|username>`

### URL Parameters

Parameter | Description
--------- | -----------
ID or username | The ID or username of the user to retrieve

