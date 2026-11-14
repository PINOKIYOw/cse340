-- Organization Table 
CREATE TABLE organization
(
	organization_id SERIAL PRIMARY KEY,
	name VARCHAR(150) NOT NULL,
	description TEXT NOT NULL,
	contact_email VARCHAR(255) NOT NULL,
	logo_filename VARCHAR(255) NOT NULL
);

-- Insert Sample Data: Organization 
INSERT INTO organization
	(name, description, contact_email, logo_filename)
VALUES
	('BrightFutureBuilders', 'A nonprofit focused on improving community infrastructure through sustainable construction projects.', 'info@brightfuturebuilders.org', 'brightfuture-logo.png'),
	('GreenHarvest Growers', 'An urban farming collective promoting food sustainability and education in local neighborhoods.', 'contact@greenharvest.org', 'greenharvest-logo.png'),
	('UnityServe Volunteers', 'A volunteer coordination group supporting local charities and service initiatives.', 'hello@unityserve.org', 'unityserve-logo.png');

-- =========================================
-- SERVICE PROJECT TABLE
-- =========================================

CREATE TABLE project (
    project_id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(200) NOT NULL,
    date DATE NOT NULL,

    CONSTRAINT fk_project_organization
        FOREIGN KEY (organization_id)
        REFERENCES organization(organization_id)
        ON DELETE RESTRICT
);

-- =========================================
-- INSERT SAMPLE SERVICE PROJECTS
-- =========================================

-- BrightFutureBuilders (5 projects)
INSERT INTO project
	(organization_id, title, description, location, date)
SELECT organization_id, data.title, data.description,
	data.location, data.date::DATE
FROM organization
CROSS JOIN (VALUES
		('Community School Renovation',
			'Help improve classrooms and learning facilities.',
			'Johannesburg',
			'2026-12-05'),
		('Youth Skills Workshop',
			'Help young people develop practical construction skills.',
			'Soweto',
			'2026-12-12'),
		('Library Improvement Project',
			'Assist with improving community library facilities.',
			'Roodepoort',
			'2026-12-19'),
		('Community Centre Upgrade',
			'Help renovate and improve a local community centre.',
			'Randburg',
			'2027-01-09'),
		('Sustainable Housing Initiative',
			'Support sustainable housing improvement activities.',
			'Westonaria',
			'2027-01-16')
) AS data(title, description, location, date)
WHERE organization.name = 'BrightFutureBuilders';

-- GreenHarvest Growers (5 projects)
INSERT INTO project
	(organization_id, title, description, location, date)
SELECT organization_id, data.title, data.description,
	data.location, data.date::DATE
FROM organization
CROSS JOIN (VALUES
		('Community Vegetable Garden',
			'Help establish and maintain a community vegetable garden.',
			'Johannesburg',
			'2026-12-06'),
		('Urban Farming Workshop',
			'Teach residents about sustainable urban farming.',
			'Soweto',
			'2026-12-13'),
		('Tree Planting Campaign',
			'Plant trees to improve local green spaces.',
			'Krugersdorp',
			'2026-12-20'),
		('Food Sustainability Education',
			'Educate communities about sustainable food production.',
			'Roodepoort',
			'2027-01-10'),
		('Community Garden Maintenance',
			'Assist with maintaining shared community gardens.',
			'Randfontein',
			'2027-01-17')
) AS data(title, description, location, date)
WHERE organization.name = 'GreenHarvest Growers';

-- UnityServe Volunteers (5 projects)
INSERT INTO project
	(organization_id, title, description, location, date)
SELECT organization_id, data.title, data.description,
	data.location, data.date::DATE
FROM organization
CROSS JOIN (VALUES
		('Community Food Drive',
			'Collect food donations for families in need.',
			'Johannesburg',
			'2026-12-07'),
		('Elderly Support Programme',
			'Assist elderly residents with community activities.',
			'Krugersdorp',
			'2026-12-14'),
		('Community Clean-up Day',
			'Work together to clean public community spaces.',
			'Westonaria',
			'2026-12-21'),
		('Winter Clothing Collection',
			'Collect clothing donations for vulnerable residents.',
			'Soweto',
			'2027-01-11'),
		('Youth Volunteer Programme',
			'Encourage young people to participate in community service.',
			'Roodepoort',
			'2027-01-18')
) AS data(title, description, location, date)
WHERE organization.name = 'UnityServe Volunteers';

-- =========================================
-- VERIFY INSERTED PROJECTS
-- =========================================

SELECT
	p.project_id,
	p.title,
	p.description,
	p.location,
	p.date,
	o.name AS organization_name
FROM project p
	INNER JOIN organization o
	ON p.organization_id = o.organization_id
ORDER BY p.date;