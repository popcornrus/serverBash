`use strict`;

const fs = require('fs');

let 	domain = process.argv[2],
	rootPath = process.argv[3],
	rawData = fs.readFileSync('settings/domains.json'),
	parseData = [];

try {
	parseData = JSON.parse(rawData);
} catch(e) {}

let error = false;
for (key in parseData)
	if (parseData[key].domain == domain)
		error = true;

if (!error) {
	parseData.push({domain: domain, rootpath: rootPath});

	fs.writeFileSync('settings/domains.json', JSON.stringify(parseData));

	console.log("true");
} else
	console.log("false");

return false;
