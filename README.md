# libio-local
libio-local is a purpose made application that can be used to create (very) limited local instance of the libraries.io api.
The libraries.io api is rate limited at 60 requests/min. 
For some applications making more than 60 requests a minute is desired.
Luckily library.io offers offers dumps of their data online through [Libraries.io Open Data](https://libraries.io/data).
After importing the data into a database, this application can be queried in place of the libraries.io api.

## Limitation
For now the only need is to be able to query Maven packages for their released versions. 
Thus the only implemented api endpoint is the one for querying project information. 
Not even the complete project information is returned, but only the package name and released versions.
Other fields present in the official libraries.io api are omitted.


## Setup
1. Download the Libraries.io Open Data package and extract it.
2. Filter `versions.csv` to only keep Maven packages. For example with `grep ",Maven," version.csv`.
3. Edit the file location of the filtered `versions.csv` in `libio_import.sql` and use the script to import the data into the database. 
4. Build the libio-local go project with `go build`
5. Execute `libio-local` and the api will be available at http://localhost:8088/

## Links
- [Libraries.io api](https://libraries.io/api)

