# Errors

<aside class="notice">This error section is stored in a separate file in `includes/_errors.md`. Slate allows you to optionally separate out your docs into many files...just save them to the `includes` folder and add them to the top of your `index.md`'s frontmatter. Files are included in the order listed.</aside>

The Kittn API uses the following error codes:


Error Code | Meaning
---------- | -------
400 | Bad Request -- Your request sucks
401 | Unauthorized -- Your API key is wrong
403 | Forbidden -- The kitten requested is hidden for administrators only
404 | Not Found -- The specified kitten could not be found
405 | Method Not Allowed -- You tried to access a kitten with an invalid method
406 | Not Acceptable -- You requested a format that isn't json
410 | Gone -- The kitten requested has been removed from our servers
418 | I'm a teapot
429 | Too Many Requests -- You're requesting too many kittens! Slown down!
500 | Internal Server Error -- We had a problem with our server. Try again later.
503 | Service Unavailable -- We're temporarially offline for maintanance. Please try again later.



200: Request succeeded for a GET call, for a DELETE or PATCH call that completed synchronously, or for a PUT call that synchronously updated an existing resource

201: Request succeeded for a POST call that completed synchronously, or for a PUT call that synchronously created a new resource

202: Request accepted for a POST, PUT, DELETE, or PATCH call that will be processed asynchronously

206: Request succeeded on GET, but only a partial response returned: see above on ranges

Pay attention to the use of authentication and authorization error codes:

401 Unauthorized: Request failed because user is not authenticated
403 Forbidden: Request failed because user does not have authorization to access a specific resource

Return suitable codes to provide additional information when there are errors:

422 Unprocessable Entity: Your request was understood, but contained invalid parameters
429 Too Many Requests: You have been rate-limited, retry later
500 Internal Server Error: Something went wrong on the server, check status site and/or report the issue



Always provide the full resource on 200 and 201 responses

202 responses will not include the full resource representation, e.g.:


Generate structured errors
{
  "id":      "rate_limit",
  "message": "Account reached its API rate limit.",
  "url":     "https://docs.service.com/rate-limits"
}

Show rate limit status