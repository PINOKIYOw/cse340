import express from 'express';
import path from 'path';
import { fileURLToPath } from 'url';
import { testConnection } from './src/models/db.js';
import { getAllOrganizations } from './src/models/organizations.js';
import { getAllProjects } from './src/models/projects.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const app = express();
const PORT = process.env.PORT || 3000;

app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'src', 'views'));
app.use(express.static(path.join(__dirname, 'public')));

app.get('/', (req, res) => {
  res.render('home', { title: 'Welcome to the CSE 340 Service Network' });
});

app.get('/organizations', async (req, res, next) => {
  try {
    const organizations = await getAllOrganizations();
    res.render('organizations', {
      title: 'Our Partner Organizations',
      organizations
    });
  } catch (error) {
    next(error);
  }
});

app.get('/projects', async (req, res, next) => {
  try {
    const projects = await getAllProjects();
    console.log('Projects retrieved from database:', projects);
    res.render('projects', {
      title: 'Service Projects',
      projects
    });
  } catch (error) {
    next(error);
  }
});

app.get('/categories', (req, res) => {
  res.render('categories', { title: 'Service Project Categories' });
});

app.use((req, res) => {
  res.status(404).render('404', { title: 'Page Not Found' });
});

// Express error handler for database or rendering errors.
app.use((error, req, res, next) => {
  console.error('Application error:', error);
  res.status(500).render('404', { title: 'Something Went Wrong' });
});

app.listen(PORT, async () => {
  try {
    await testConnection();
    console.log(`Server is running at http://localhost:${PORT}`);
    console.log(`Environment: ${process.env.NODE_ENV || 'not set'}`);
  } catch (error) {
    console.error('Error connecting to the database:', error.message);
  }
});
