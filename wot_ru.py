import urllib2
import json
from sys import argv

if len(argv) != 3:
	print "USAGE: %s <url> <html_file>" % ( argv[0] )

url = argv[1]
filename = argv[2]

json_string = urllib2.urlopen(url)
j = json.load(json_string)

f = open(filename, "w")
f.write("  var markers = [\n")
text = ""
for i in j:
	try:
		avg = int(i[5][u"average"])
		if avg == -1:
			continue
		if avg > 120:
			color = 0
		else:
			color = 120 - avg 
		img = "https://atlas.ripe.net/markers/cartography/img/templates/probe-default.png?hue=%d&text=%d" % ( color, avg)
		text += "    [%d, %s, %s, \"%s\"],\n" % (avg, i[3], i[4], img)
	except:
		continue
text=text[:-2]
f.write(text)
f.write("];\n")
f.close()
