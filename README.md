# Helm-Chart-Superset

Deployment Superset and Trino

VNC and SSH services are included to allow remote access through Guacamole

## Usage

There is a shortcut in the desktop for opening the Superset web interface in the browser.  
The credentials for accessing are (username/password): admin/admin

Once in the Superset dashboard you can go to "Data" -> "Database", 
now go to the bottom section "choose from a list" and select in "SUPPORTED DATABASES" the "trino".
Now in the field "SQLALCHEMY URI" you should write:  
`trino://trino@localhost:8080/chaimeleon`
