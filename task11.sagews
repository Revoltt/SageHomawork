graph = graphs.CompleteGraph(7);

def t11(graph):
    view = Graphics() + graph.plot()
    view.show(axes=False)

t11(graph)