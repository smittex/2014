Promise.all(arrayOfPromises).then(function(arrayOfResults) {
  //...
});

-----------------------

Promise.all(arrayOfPromises).then(function(arrayOfResults) {
  //...
}, function(firstRejectionValue) {
  //...
});

//$.when()
