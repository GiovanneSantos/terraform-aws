import http from "http";

// Testa se a API responde "Hello Node API!"
const options = {
  hostname: 'localhost',
  port: 8080,
  path: '/',
  method: 'GET'
};

const req = http.request(options, res => {
  let data = '';
  res.on('data', chunk => data += chunk);
  res.on('end', () => {
    if (data === 'Hello Node API!') {
      console.log('✅ Test passed');
    } else {
      console.error('❌ Test failed:', data);
      process.exit(1);
    }
  });
});

req.on('error', err => {
  console.error('❌ Test failed:', err);
  process.exit(1);
});

req.end();
