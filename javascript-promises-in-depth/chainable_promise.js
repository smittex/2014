function loadImg(imgsrc) {
  return new Promise(function(resolve, reject) {
    var i = new Image();
    i.onload = resolve(i);
    i.src = imgsrc;
  }
}

loadImg(url).then(function(resp) {
  console.log("Img Loaded!")
  return processImg(resp) // also 'thenable'
}).then(function(resp){
  // insert in DOM or something...
}, function(err) {
  console.log("img processing failed (sadface)")
});
