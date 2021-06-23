file = open("Task2_text")

parent = pNum = None
child = cNum = None

for line in file:
    if line[0].lower() == 'p':
         temp = line.split("=")
         parent = temp[0]
         pNum = temp[1].strip()
    elif line[0] == '-':
        temp = line.split("=")
        child = temp[0][1:]
        cNum = temp[1].strip()
        print("{} - {}={}~{}".format(parent, child, pNum, cNum))
    else:
        ValueError("Text provided does not contain a recognized character, first index must be - or p")
