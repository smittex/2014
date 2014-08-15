function loadImg(imgsrc, callback) {
  var i = new Image();
  i.onload = callback(i);
  i.src = imgsrc;
}

loadImg(url, function(img) {
  console.log("Img Loaded!");
  // take img and do something *
});
