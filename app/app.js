/**
 * simple nodejs service.
 */

const http = require("http")

http.createServer((req, res) => {
  res.end("hello world")
}).listen(5000)