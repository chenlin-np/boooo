// Define namespaces
var northpoint = northpoint || {};
northpoint.components = northpoint.components || {};
northpoint.functions = northpoint.functions || {};

northpoint.functions.createPath = function(path, type, prop) {
	if (!type) type = "cq:Page";
	var conf = {
		type: 'POST',
		url: "/apps/northpoint/wcm/components/path-creator.html", 
		data: {"path": path, "type" : type, "prop" : prop},
		async: false
	};
	if (prop) {
		conf.data.prop = prop;
	}

	$.ajax(conf);
};
