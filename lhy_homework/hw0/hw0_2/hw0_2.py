from PIL import Image
im = Image.open('westbrook.JPG')
pix=im.load()
width=im.size[0]
height=im.size[1]
print(width)
print(height)
#R=[]
#G=[]
#B=[]
image=Image.new('RGB',(width,height))
for x in range(width):
    for y in range(height):
        r,g,b=pix[x,y]
        image.putpixel((x,y),(r//2,g//2,b//2))
#        R.append(r//2)
#        G.append(g//2)
#        B.append(b//2)
#for i in range(width):
#    for j in range(height):
#        image.putpixel((i,j),(R[height*i+j],G[height*i+j],B[height*i+j]))

image.save('Q2.jpg')

