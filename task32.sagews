import random

def randomGen(n, m):
    res = []
    for i in xrange(n):
        cur = []
        for j in xrange(m):
            if random.randrange(4) == 0:
                cur.append(1)
            else:
                cur.append(0)
        res.append(cur)
    return res

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
    q = [(ist, jst, 0)]
    work = {(ist, jst): 0}
    visited = []
    while len(q) != 0:
        (icur, jcur, curstep) = q.pop(0)
        if (icur, jcur) not in visited:
            work[(icur, jcur)] = curstep
            #print icur, jcur, curstep
            visited.append((icur, jcur))
            g += polygon([[jcur,-icur], [jcur+1,-icur], [jcur+1, -icur-1],[jcur, -icur-1]], rgbcolor = (0,1,0))
            if icur + 1 < len(lab) and lab[icur + 1][jcur] == 0:
                q.append((icur + 1, jcur, curstep + 1))
            if icur - 1 >= 0 and lab[icur - 1][jcur] == 0:
                q.append((icur - 1, jcur, curstep + 1))
            if jcur + 1 < len(lab[0]) and lab[icur][jcur + 1] == 0:
                q.append((icur, jcur + 1, curstep + 1))
            if jcur - 1 >= 0 and lab[icur][jcur - 1] == 0:
                q.append((icur, jcur - 1, curstep + 1))
            g.axes(False)
            frames.append(g)
    #generate last frame with path
    #find last empty cell
    for i in xrange(len(lab)):
        for j in xrange(len(lab[0])):
            if lab[i][j] == 0:
                ifin = i
                jfin = j
    icur = ifin
    jcur = jfin
    #print len(frames)
    #print work
    if work.has_key((ifin, jfin)):
        curstep = work[(ifin, jfin)]
        while curstep != 0:
            #print curstep
            g.axes(False)
            g += polygon([[jcur,-icur], [jcur+1,-icur], [jcur+1, -icur-1],[jcur, -icur-1]], rgbcolor = (0,0,1))
            frames.append(g)
            if work.has_key((icur - 1, jcur)) and work[(icur - 1, jcur)] == curstep - 1:
                icur -= 1
                curstep -= 1
            elif work.has_key((icur + 1, jcur)) and work[(icur + 1, jcur)] == curstep - 1:
                icur += 1
                curstep -= 1
            elif work.has_key((icur, jcur - 1)) and work[(icur, jcur - 1)] == curstep - 1:
                jcur -= 1
                curstep -= 1
            elif work.has_key((icur, jcur + 1)) and work[(icur, jcur + 1)] == curstep - 1:
                jcur += 1
                curstep -= 1
        g.axes(False)
        g += polygon([[jst,-ist], [jst+1,-ist], [jst+1, -ist-1],[jst, -ist-1]], rgbcolor = (0,0,1))
        frames.append(g)
    #print len(frames)
    return animate(frames)

@interact
def interaction (seed = input_box(default=50, label="seed", type=int), n = input_box(default=5, label="n", type=int), m = input_box(default=5, label="m", type=int)):
    random.seed(int(seed))
    lab = randomGen(n, m)
    g = draw(lab)
    animation = BFS(lab, g)
    animation.show(delay=40)