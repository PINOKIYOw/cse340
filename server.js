import express from 'express';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const app = express();
const PORT = process.env.PORT || 3000;

// EJS templates are stored in src/views.
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'src', 'views'));

// Files in public are served from the site root (for example, /css/main.css).
app.use(express.static(path.join(__dirname, 'public')));

app.get('/', (req, res) => {
  res.render('home', { title: 'Welcome to the CSE 340 Service Network' });
});

app.get('/organizations', (req, res) => {
  res.render('organizations', { title: 'Partner Service Organizations' });
});

app.get('/projects', (req, res) => {
  res.render('projects', { title: 'Service Projects' });
});

app.get('/categories', (req, res) => {
  res.render('categories', { title: 'Service Project Categories' });
});

// A simple not-found page keeps unknown routes from returning a blank response.
app.use((req, res) => {
  res.status(404).render('404', { title: 'Page Not Found' });
});

app.listen(PORT, () => {
  console.log(`Server is running at http://localhost:${PORT}`);
});
