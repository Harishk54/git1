% Define the jug capacities
capacity(jug1, 4).
capacity(jug2, 3).

% Define the goal state
goal(state(2, _)).

% Define the possible moves:
% Fill a jug
move(state(_, Y), fill(jug1), state(4, Y)).
move(state(X, _), fill(jug2), state(X, 3)).

% Empty a jug
move(state(_, Y), empty(jug1), state(0, Y)).
move(state(X, _), empty(jug2), state(X, 0)).

% Pour water from jug1 to jug2
move(state(X, Y), pour(jug1, jug2), state(XNew, YNew)) :-
    capacity(jug2, YMax),
    Transfer is min(X, YMax - Y),
    XNew is X - Transfer,
    YNew is Y + Transfer.

% Pour water from jug2 to jug1
move(state(X, Y), pour(jug2, jug1), state(XNew, YNew)) :-
    capacity(jug1, XMax),
    Transfer is min(Y, XMax - X),
    XNew is X + Transfer,
    YNew is Y - Transfer.

% Depth-first search to find a solution
solve(State, _, []) :- goal(State).
solve(State, Visited, [Move | Moves]) :-
    move(State, Move, NextState),
    \+ member(NextState, Visited),  % Avoid revisiting states
    solve(NextState, [NextState | Visited], Moves).

% Initialize and find the solution
water_jug_solution(Solution) :-
    InitialState = state(0, 0),
    solve(InitialState, [InitialState], Solution).
