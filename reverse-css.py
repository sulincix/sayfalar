import os, sys

if(len(sys.argv)>1):
    file=open(sys.argv[1],"r")
else:
    file=sys.stdin

content=file.read()
is_enabled=False
hxc="0123456789abcdef"
content=content.replace("white","@@@");
content=content.replace("black","white");
content=content.replace("@@@","black");
for c in content:
    if c == '#':
        is_enabled=True
    elif c == ';':
        is_enabled=False
    if c.lower() not in hxc or not is_enabled:
        sys.stdout.write(c)
    else:
        sys.stdout.write(hxc[len(hxc)-1-hxc.index(c.lower())]);
        
