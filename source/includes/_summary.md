# Summary

> ### Definition
https://new-api.smartcitizen.me

> ### Summary of Resources

```
/v0/components/:id
/v0/devices/:id
/v0/devices/:id/readings
/v0/kits/:id
/v0/me
/v0/measurements/:id
/v0/password_resets
/v0/search
/v0/sensors/:id
/v0/sessions
/v0/uploads
/v0/users/:id
```

The Smartcitizen V0 API is a publicly available interface allowing developers access to the smartcitizen dataset. The interface is stable and currently used by the Strava mobile applications. However, changes are occasionally made to improve performance and enhance features. See the changelog for more details.

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

## Versioning

By default, all requests receive the v0 version of the API. We encourage you to explicitly request this version via the URL or the HTTP Accept header.

 | endpoint
---- | ------------------------------------
**BAD** | https://new-api.smartcitizen.me/users
**GOOD** | https://new-api.smartcitizen.me/v0/users

`Accept: application/vnd.smartcitizen; version=0,application/json`
