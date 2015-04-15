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
                g += polygon([[j,-i], [j+1,-i], [j+1, -i-1],[j, -i-1]], rgbcolor = (0,0,0))
            else:
                g += polygon([[j,-i], [j+1,-i], [j+1, -i-1],[j, -i-1]], rgbcolor = (0,1,1))
    g.axes(False)
    return g

def BFS(lab, g):
    frames = [g]
    ist = 0
    jst = 0
    f = True
    #find first empty cell
    for i in xrange(len(lab)):
        for j in xrange(len(lab[0])):
            if lab[i][j] == 0 and f:
                ist = i
                jst = j
                f = False
    #print ist, jst
    #BFS from that cell
    q = [(ist, jst)]
    visited = []
    while len(q) != 0:
        (icur, jcur) = q.pop(0)
        if (icur, jcur) not in visited:
            visited.append((icur, jcur))
            g += polygon([[jcur,-icur], [jcur+1,-icur], [jcur+1, -icur-1],[jcur, -icur-1]], rgbcolor = (0,1,0))
            if icur + 1 < len(lab) and lab[icur + 1][jcur] == 0:
                q.append((icur + 1, jcur))
            if icur - 1 >= 0 and lab[icur - 1][jcur] == 0:
                q.append((icur - 1, jcur))
            if jcur + 1 < len(lab[0]) and lab[icur][jcur + 1] == 0:
                q.append((icur, jcur + 1))
            if jcur - 1 >= 0 and lab[icur][jcur - 1] == 0:
                q.append((icur, jcur - 1))
            g.axes(False)
            frames.append(g)
    return animate(frames)
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
animation = BFS(lab, g)
animation.show(delay=40)