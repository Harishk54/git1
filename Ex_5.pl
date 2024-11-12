% Define the initial state and goal state
initial_state((0,0)).   % Both jugs are empty at the start
goal_state((4,_)).      % The goal is to have 4 liters in the 4-liter jug

% Define the capacity of the jugs (jug1: 4 liters, jug2: 3 liters)
capacity_jug1(4).
capacity_jug2(3).

% Possible moves:
move((X,Y), (4,Y)) :- capacity_jug1(4), X < 4.  % Fill jug1 to full capacity
move((X,Y), (X,3)) :- capacity_jug2(3), Y < 3.  % Fill jug2 to full capacity
move((X,Y), (0,Y)) :- X > 0.                   % Empty jug1
move((X,Y), (X,0)) :- Y > 0.                   % Empty jug2

% Pour water from jug1 to jug2
move((X,Y), (X1,Y1)) :-
    X > 0,
    Y < 3,
    Z is min(X, 3 - Y),
    X1 is X - Z,
    Y1 is Y + Z.

% Pour water from jug2 to jug1
move((X,Y), (X1,Y1)) :-
    Y > 0,
    X < 4,
    Z is min(Y, 4 - X),
    X1 is X + Z,
    Y1 is Y - Z.

% Define a solution by searching for a sequence of moves from the initial state to the goal state
solve(State, [State]) :- goal_state(State).
solve(State, [State|RestOfMoves]) :-
    move(State, NextState),
    solve(NextState, RestOfMoves).

% Start the solution
start(Solution) :-
    initial_state(StartState),
    solve(StartState, Solution).
