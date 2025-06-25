const express = require('express');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

app.get('/health', (req, res) => res.json({ status: 'ok' }));
app.get('/hello', (req, res) => res.send('Hello, world!'));

app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});
