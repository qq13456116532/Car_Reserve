const http = require('http');
const fs = require('fs');

const hostname = 'localhost';
const port = 3000;
const path = require('path');
const filePath = path.join(__dirname, 'path/to/static/file.html');
const server = http.createServer((req, res) => {
  console.log(`Request for ${req.url} received.`);

  if (req.url === '/') {
    // Serve the home page
    const filePath = path.join(__dirname, 'login.html');
    const stream = fs.createReadStream(filePath);

    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/html');
    stream.pipe(res);
  } else {
    // Serve other static files
    const filePath = path.join(__dirname, req.url);
    const stream = fs.createReadStream(filePath);

    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/html');
    stream.pipe(res);
  }
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});
