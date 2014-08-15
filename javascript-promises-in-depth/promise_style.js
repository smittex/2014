function loadImg(imgsrc) {
  return new Promise(function(resolve, reject) {
    var i = new Image();
    i.onload = resolve(i);
    i.src = imgsrc;
  }
}

loadImg(url).then(function() {
  console.log("Img Loaded!")
  // take img and do something
});
