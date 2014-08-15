# "catch", is just sugar for .then(undefined, reject)

promiseThing.then( response ->
  console.log("Success!", response)
).catch( error ->
  console.log("Failed!", error)
)

# equivalent to

promiseThing.then( response ->
  console.log("Success!", response)
).then( undefined, error ->
  console.log("Failed!", error)
)

# just more readable

