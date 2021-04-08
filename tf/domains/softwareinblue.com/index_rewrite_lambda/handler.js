'use strict';
const path = require('path');

exports.handler = (event, context, callback) => {
    //console.log(JSON.stringify(event));
    // Extract the request from the CloudFront event that is sent to Lambda@Edge 
    var request = event.Records[0].cf.request;

    // Extract the URI from the request
    var olduri = request.uri;

    // Match any '/' that occurs at the end of a URI. Replace it with a default index
    var newuri = olduri.replace(/\/$/, '\/index.html');
    
    // Match any pretty urls that have no file extention and no trailing / and
    // add /index.html
    if (!path.extname(newuri)) {
        newuri = newuri.replace(/\/?$/, '\/index.html');
    }
    // Log the URI as received by CloudFront and the new URI to be used to fetch from origin
    //console.log("Old URI: " + olduri);
    //console.log("New URI: " + newuri);
    
    // Replace the received URI with the URI that includes the index page
    request.uri = newuri;
    
    // Return to CloudFront
    return callback(null, request);
};
