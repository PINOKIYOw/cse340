import db from './db.js';

/**
 * Retrieves all service projects and the name of each project's organization.
 * The INNER JOIN connects project.organization_id to organization.organization_id.
 */
const getAllProjects = async () => {
  const query = `
    SELECT
      project.project_id,
      project.organization_id,
      project.title,
      project.description,
      project.location,
      project.date,
      organization.name AS organization_name
    FROM public.project AS project
    INNER JOIN public.organization AS organization
      ON project.organization_id = organization.organization_id
    ORDER BY project.date ASC, project.title ASC;
  `;

  const result = await db.query(query);
  return result.rows;
};

export { getAllProjects };
