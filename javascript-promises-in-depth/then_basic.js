// .then(fulfill, reject)

promiseThing.then(function(response) {
  console.log("Success!", response);
}, function(error) {
  console.log("Failed!", error);
});
