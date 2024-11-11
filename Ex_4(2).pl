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

% DFS implementation
dfs(Start, Goal, Path) :-
    dfs(Start, Goal, [Start], Path).

% Base case: If the current node is the goal, return the path.
dfs(Goal, Goal, Path, Path).

% Recursive case: Explore unvisited neighbors recursively.
dfs(Node, Goal, Visited, Path) :-
    connected(Node, Next),
    \+ member(Next, Visited),  % Avoid cycles by checking if Next is already visited
    dfs(Next, Goal, [Next | Visited], Path).
