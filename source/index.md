---
title: SmartCitizen API Reference

toc_footers:
  - <a href='#'>Sign Up for a Developer Key</a>

includes:
  - errors

search: true
---

# Summary

> ### API Endpoint
> https://new-api.smartcitizen.me
> ### Summary of Resources
> * /v0/oauth
> * /v0/me
> * /v0/users/:id
> * /v0/devices/:id
> * /v0/kits/:id
> * /v0/sensors/:id

> ### Updates and Changes


The Smartcitizen V0 API is a publicly available interface allowing developers access to the smartcitizen dataset. The interface is stable and currently used by the Strava mobile applications. However, changes are occasionally made to improve performance and enhance features. See the changelog for more details.


# Access

> To authorize, use this code:

```shell
# With shell, you can just pass the correct header with each request
curl "api_endpoint_here"
  -H "Authorization: meowmeowmeow"
```

> Make sure to replace `meowmeowmeow` with your API key.

Kittn uses API keys to allow access to the API. You can register a new Kittn API key at our [developer portal](https://new-api.smartcitizen.me/developers).

Kittn expects for the API key to be included in all API requests to the server in a header that looks like the following:

`Authorization: meowmeowmeow`

<aside class="notice">
You must replace `meowmeowmeow` with your personal API key.
</aside>

<!-- # Rate Limiting -->

# Pagination

Most index responses

Parameter | Type | Default | Description
--------- | ------- | ------- | -----------
page | integer | 1 | page
per_page | integer | 25 | page

# Filtering

## Global Search

Searching Users and Devices

### Required Parameters

Parameter | Type | Description
--------- | ------- | -----------
q | string | Query string

## Filtering Responses

#### Examples

Parameter | Type | Description
--------- | ------- | -----------
q[first_name_eq] | string | First name equals
q[owner_id] | string | Owner ID equals

## Sorting Responses

Parameter | Type | Description
--------- | ------- | -----------
q[sort] | string | page

# Devices

## Update a Device

This updates a device

### Optional Parameters

Parameter | Type | Description
--------- | ------- | -----------
name | string | Name of the device
description | string | Description of the device
mac_address | mac_address | MAC Address of the device
latitude | decimal | Latitude of the device
longitude | decimal | Longitude of the device

## Get All Devices

> ### Definition
GET https://new-api.smartcitizen.me/v0/devices

```
$ curl -G https://new-api.smartcitizen.me/v0/devices
```

# Users

## Get Current User

> ### Definition
`GET https://new-api.smartcitizen.me/v0/me`

> ### Example Request

```
$ curl -G https://new-api.smartcitizen.me/v0/me \
    -H "Authorization: Bearer 94abeabdec09f6670863766f792ead24d61fe3f9"
```

This request is used to retrieve information about the currently authenticated user.
Returns a detailed representation of the user.

## Update Current User

> ### Definition
`GET https://new-api.smartcitizen.me/v0/me`

> ### Example Request

```
$ curl -G https://new-api.smartcitizen.me/v0/me \
    -H "Authorization: Bearer 94abeabdec09f6670863766f792ead24d61fe3f9"
```

This request is used to retrieve information about the currently authenticated user.
Returns a detailed representation of the user.

### Optional Parameters

Parameter | Default | Description
--------- | ------- | -----------
first_name | | First name of the user
last_name | | Last name of the user
email | | Email address of the user
username | | Username of the user
password | | Password of the user
city | | City where the user is
country_code | | [2 letter](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) country-code of the user
url | | Webpage of the user
avatar | | URL to the avatar of the user


## Get All Users

```shell
curl "https://new-api.smartcitizen.me/v0/users"
  -H "Authorization: meowmeowmeow"
```

> The above command returns JSON structured like this:

```json
[
  {
    "id": 1,
    "name": "Fluffums",
    "breed": "calico",
    "fluffiness": 6,
    "cuteness": 7
  },
  {
    "id": 2,
    "name": "Isis",
    "breed": "unknown",
    "fluffiness": 5,
    "cuteness": 10
  }
]
```

This endpoint retrieves all users.

### HTTP Request

`GET https://new-api.smartcitizen.me/users`

### Optional Parameters

Parameter | Default | Description
--------- | ------- | -----------
page | 1 | If set to true, the result will also include cats.
per_page | 25 | If set to false, the result will include users that have already been adopted.

## Get a Specific User

```shell
curl "https://new-api.smartcitizen.me/v0/users/3"
  -H "Authorization: meowmeowmeow"
```

> The above command returns JSON structured like this:

```json
{
  "id": 2,
  "name": "Isis",
  "breed": "unknown",
  "fluffiness": 5,
  "cuteness": 10
}
```

This endpoint retrieves a specific user.

### HTTP Request

`GET https://new-api.smartcitizen.me/users/<ID|username>`

### URL Parameters

Parameter | Description
--------- | -----------
ID or username | The ID or username of the user to retrieve

