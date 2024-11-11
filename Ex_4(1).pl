% Define edges of the graph
edge(a, b).
edge(a, c).
edge(b, d).
edge(b, e).
edge(c, f).
edge(d, g).
edge(e, h).
edge(f, i).

% Define bidirectional connections
connected(X, Y) :- edge(X, Y).
connected(X, Y) :- edge(Y, X).

% BFS implementation
bfs(Start, Goal, Path) :-
    bfs([[Start]], Goal, Path).

% Base case: If the head of the queue has reached the goal, we're done.
bfs([[Goal | Path] | _], Goal, FinalPath) :-
    reverse([Goal | Path], FinalPath).

% Recursive case: Expand the first path in the queue, add new paths to the queue.
bfs([[Node | Path] | Paths], Goal, Result) :-
    findall([Next, Node | Path],
            (connected(Node, Next), \+ member(Next, [Node | Path])),
            NewPaths),
    append(Paths, NewPaths, UpdatedQueue),
    bfs(UpdatedQueue, Goal, Result).
