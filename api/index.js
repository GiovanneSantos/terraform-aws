import express from 'express';

const app = express();
const port = 8080;

app.get('/', (req, res) => {
  res.send('API running');
});

app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
