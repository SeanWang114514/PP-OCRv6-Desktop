from pathlib import Path
import struct

def dib(w,h):
    px=[]
    for y in range(h):
        for x in range(w):
            # deep blue background with teal OCR accent
            edge=min(x,y,w-1-x,h-1-y)
            if edge<2: c=(22,48,76,255)
            else: c=(30,92,125,255)
            cx,cy=w*.43,h*.43; rr=min(w,h)*.22
            if (x-cx)**2+(y-cy)**2 <= rr*rr and ((x-cx)**2+(y-cy)**2 >= (rr-4)**2): c=(245,250,252,255)
            if x>w*.58 and y>h*.58 and abs(x-y)<4: c=(245,250,252,255)
            px.append(c)
    rows=[]
    for y in range(h-1,-1,-1):
        rows.append(b''.join(bytes((b,g,r,a)) for r,g,b,a in px[y*w:(y+1)*w]))
    return struct.pack('<IiiHHIIiiII',40,w,h*2,1,32,0,w*h*4,0,0,0,0)+b''.join(rows)

imgs=[(16,dib(16,16)),(32,dib(32,32)),(48,dib(48,48))]
o=struct.pack('<HHH',0,1,len(imgs)); off=6+16*len(imgs); entries=[]; data=b''
for size,b in imgs:
    entries.append(struct.pack('<BBBBHHII',size if size<256 else 0,size if size<256 else 0,0,0,1,32,len(b),off+len(data)))
    data+=b
Path('ppocr_icon.ico').write_bytes(o+b''.join(entries)+data)
