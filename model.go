package main

import (
	"database/sql"
)

type Version struct {
	ID          int    `json:"id"`
	Number      string `json:"number"`
	PublishedAt string `json:"publishedAt"`
}

type Project struct {
	ID   int    `json:"id"`
	Name string `json:"name"`

	Versions []Version
}

func (p *Project) getProject(db *sql.DB) error {
	query := `SELECT 
	    projects.id as p_id, 
	    projects.identifier as name, 
	    
	    versions.id as v_id, 
	    versions.name as name, 
	    versions.published_at as published_at
	FROM projects
	JOIN versions ON versions.project_id = projects.id
	WHERE projects.identifier = ?
	ORDER BY versions.published_at`

	rows, err := db.Query(query, p.Name)
	if err != nil {
		return err
	}

	defer rows.Close()

	versions := []Version{}

	for rows.Next() {
		var v Version
		if err := rows.Scan(&p.ID, &p.Name, &v.ID, &v.Number, &v.PublishedAt); err != nil {
			return err
		}
		versions = append(versions, v)
	}

	p.Versions = versions

	return nil
}
