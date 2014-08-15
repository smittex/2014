// "catch", is just sugar for .then(undefined, reject)

promiseThing.then(function(response) {
  console.log("Success!", response);
}).catch(function(error) {
  console.log("Failed!", error);
});

// equivalent to

promiseThing.then(function(response) {
  console.log("Success!", response);
}).then(undefined, function(error) {
  console.log("Failed!", error);
});

// just more readable

