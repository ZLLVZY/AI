with open('words.txt', 'r') as f:
    L=f.read()
    a=L.split(' ')
    print(a)
    b=list(set(a))
    b.sort(key=a.index)
    print(b)
    C=[]
    i=0
    for item in b:
        C.append(item)
        C.append(i)
        C.append(a.count(item))
        i+=1
    print(C)
with open('Q1.txt', 'w') as f1:
    i=0
    for item in C:
        f1.write(str(item))
        i+=1
        if i%3!=0:
            f1.write(' ')
        if i%3==0:
            if i==len(C):
                break
            f1.write('\n')
