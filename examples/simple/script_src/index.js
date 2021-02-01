// Load the SDK for JavaScript
var AWS = require('aws-sdk');
// Set the Region
AWS.config.update({region: 'us-east-1'});

s3 = new AWS.S3({apiVersion: '2006-03-01'});

exports.handler = function(event, context, callback){
  s3.listBuckets(function(err, data) {
    if (err) {
      console.log("Error", err);
      callback(err);
    } else {
      console.log("Success", data.Buckets);
      callback(null, data.Buckets);
    }
  });
}
