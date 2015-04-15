def bfs(graph):
    vNum = set([i for i in graph.vertex_iterator()])
    start = 0
    vRGB = {'#00FFFF' : [start], '#FF0000': [i for i in vNum], '#00FF00':[]}
    frames = [graph.plot(save_pos=True, layout='circular', vertex_colors=vRGB)]
    q = [(start, 0)]
    #work1 = {}
    work = {}
    visited = []
    while len(q) != 0:
        #print q
        temp = q.pop(0)
        cur = temp[0]
        step = temp[1]
        if cur not in visited:
            #if work1.has_key(step):
            #    work1[step].append(cur)
            #else:
            #    work1[step] = [cur]
            work[cur] = step
            vRGB['#00FF00'].append(cur)
            vRGB['#FF0000'].remove(cur)
            visited.append(cur)
            connected = graph.edges_incident(cur)
            for i in connected:
                if i[1] not in visited:
                    q.append((i[1], step + 1))
                if i[0] not in visited:
                    q.append((i[0], step + 1))
            #print vRGB
            frames.append(graph.plot(save_pos=True, layout='circular', vertex_colors=vRGB))
    #print len(frames)
    #print work
    # now we should create last frame, whick shows the path
    cur = len(vNum) - 1
    vRGB['#0000FF'] = []
    if work.has_key(cur):
        curstep = work[cur]
        while curstep != 0:
            vRGB['#00FF00'].remove(cur)
            vRGB['#0000FF'].append(cur)
            for i in graph.edges_incident(cur):
                if work[i[0]] == curstep - 1:
                    curstep -= 1
                    cur = i[0]
                elif work[i[1]] == curstep - 1:
                    curstep -= 1
                    cur = i[1]
    frames.append(graph.plot(save_pos=True, layout='circular', vertex_colors=vRGB))
    animation = animate(frames)
    return animation
    #return frames

def graphGen(n, edgeCount):
    graph = {i:[] for i in xrange(int(n))}
    for i in xrange(edgeCount):
        v1 = random.randint(0, n - 1)
        v2 = random.randint(0, n - 1)
        while v2 == v1:
            v2 = random.randint(0, n - 1)
        graph[v1].append(v2)
        #graph[v2].append(v1)
    return Graph(graph)

@interact
def interaction(seed = input_box(default=50, label="seed", type=int), n = slider([1..30], default=9), edge_density = slider(0,1, 0.05, default=0.2)):
    graph = graphGen(n, (n*(n-1)/2 * edge_density).round())
    temp = bfs(graph)
    temp.show(delay=80)
