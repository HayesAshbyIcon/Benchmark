var express = require('express');
var app = express();

app.get('/target', function (req, res) {
  res.send("avacado")
})

var server = app.listen(8081, function () {
   console.log("Example app listening at http://127.0.0.1:8081/")
})