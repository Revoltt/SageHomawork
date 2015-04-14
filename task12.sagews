def generateFromText (s):
    lab = []
    temp = []
    for c in s:
        if c == '\n':
            lab.append(temp)
            temp = []
        elif c == '.':
            temp.append(0)
        elif c == '#':
            temp.append(1)
        else:
            return None
    return lab

def draw(lab):
    g = Graphics()
    for i in xrange(len(lab)):
        for j in xrange(len(lab[0])):
            if lab[i][j] == 1:
                g += polygon([[j,i], [j+1,i], [j+1, i+1],[j, i+1]], rgbcolor = (0,0,0))
            else:
                g += polygon([[j,i], [j+1,i], [j+1, i+1],[j, i+1]], rgbcolor = (0,1,1))
    
    g.axes(False)
    return g


lab = generateFromText(
"""##.....##
....#####
.##...###
.####.#..
...##...#
##....###
""")
lab
g = draw(lab)
g.show()