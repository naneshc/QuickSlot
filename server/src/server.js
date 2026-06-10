const app = require('./app');
const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
  console.log(`QuickSlot Server listening on port ${PORT} (local mode)`);
});
