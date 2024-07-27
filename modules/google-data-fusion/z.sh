read -p "Enter the new project_id: " project_id
grep -q 'project_id' variables.tf && sed -i "s/project_id =.*/project_id = \"$project_id\"/" variables.tf

