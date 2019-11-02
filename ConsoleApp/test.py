import lxml.etree as ET

dom = ET.parse('scan001.xml')
xslt = ET.parse('make_text.xslt')
transform = ET.XSLT(xslt)
newdom = transform(dom)
print str(newdom)