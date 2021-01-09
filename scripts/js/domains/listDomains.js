`use strict`;

const fs = require('fs');

let file = fs.readFileSync('settings/domains.json');

try {
	let data = JSON.parse(file),
		i = 1;

	for (key in data) {
		console.log(i+". "+data[key].domain+" => /srv/"+data[key].domain+"/web/"+data[key].rootpath);

		i++;
	}
} catch (e) {}
 