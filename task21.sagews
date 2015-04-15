#graph = graphs.CompleteGraph(7);
graph = Graph({0: [1,4,5], 1: [2,6], 2: [3,7], 3: [4,8], 4: [9], 5: [7, 8], 6: [8,9], 7: [9]})
#graph = Graph({0:[1,2], 1:[0, 4], 2:[0, 4], 3:[4], 4:[1,2,3]})
def bfs(graph):
    vNum = set([i for i in graph.vertex_iterator()])
    start = 0
    vRGB = {'#00FFFF' : [start], '#FF0000': [i for i in vNum], '#00FF00':[]}
    frames = [graph.plot(save_pos=True, layout='circular', vertex_colors=vRGB)]
    q = [start]
    visited = []
    while len(q) != 0:
        #print q
        cur = q.pop(0)
        if cur not in visited:
            vRGB['#00FF00'].append(cur)
            vRGB['#FF0000'].remove(cur)
            visited.append(cur)
            connected = graph.edges_incident(cur)
            for i in connected:
                if i[1] not in visited:
                    q.append(i[1])
                if i[0] not in visited:
                    q.append(i[0])
            #print vRGB
            frames.append(graph.plot(save_pos=True, layout='circular', vertex_colors=vRGB))
    #print len(frames)
    animation = animate(frames)
    return animation
    #return frames

temp = bfs(graph)
temp.show(delay=80)
