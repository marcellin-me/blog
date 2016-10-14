---
layout: post
title: App Deployment - Serve Emberjs app on s3
description: "Deploy Emberjs app on s3 and allow access to all routes using the hash"
modified: 2016-10-11T05:35:00-04:00
tags: [ember-cli@v1.13.14, emberjs, deployment, aws s3]
---

### Description
We want to serve an Emberjs application using s3 static site serving capability, and have it(s3) handle internal routing properly.

### End Goal

![Product](/images/s3-static-site-config.png)

### Step by step

* [Create an s3 bucket](https://console.aws.amazon.com/s3/home)

* Add entry documents

```shell
Index Document: index.html
Error Document: index.html
```

* Fix Redirection Rules for "no file found error"

```xml
<RoutingRules>
    <!-- no file found error -->
    <RoutingRule>
        <Condition>
            <HttpErrorCodeReturnedEquals>404</HttpErrorCodeReturnedEquals>
        </Condition>
        <Redirect>
            <ReplaceKeyPrefixWith>#/</ReplaceKeyPrefixWith>
        </Redirect>
    </RoutingRule>
</RoutingRules>

```

* Provide public access to your bucket

```json
{
  "Statement": [
    {
      "Sid": "AllowPublicRead",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::<bucket-name>/*"
    }
  ]
}
```

* Fix the CORS Configuration information

```xml
<!-- 
  required if you serve your assets using the secure s3 protocol 
  https://s3.amazonaws.com/<bucket-name>/assets/...
-->
<?xml version="1.0" encoding="UTF-8"?>
<CORSConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <CORSRule>
      <AllowedOrigin>*.amazonaws.com</AllowedOrigin>
      <AllowedMethod>GET</AllowedMethod>
      <MaxAgeSeconds>3000</MaxAgeSeconds>
      <AllowedHeader>*</AllowedHeader>
    </CORSRule>
</CORSConfiguration>
```

* Set your locationType to auto

```javascript
// config/environment.js

locationType: 'auto'

``` 

* Build your application

```shell
ember build --environment=production
```

* Upload content of the distribution folder to your s3 bucket.

```shell
# distribution folder = dist/
```

Now if you open the url provided to you in your s3 bucket properties, you will see your app running. Moreover, reloading the browser after visiting a new page, will bring you back to that currently visited page!

### GitHub resources:
* [Ember history api](https://ember-cli.com/user-guide/#history-api-and-root-url)
* [AWS S3 Redirect for an HTTP error](https://docs.aws.amazon.com/AmazonS3/latest/dev/HowDoIWebsiteConfiguration.html)
* [Ember cli](https://ember-cli.com/user-guide/#guide)

<!-- {% gist mmistakes/6589546 %} -->
