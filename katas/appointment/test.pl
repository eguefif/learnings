:- begin_tests(hello).

:- use_module('hello').

test('reservation, no appointment') :-
    assertion(book([])).

test('reservation, simple case') :-
    assertion(book([appointment(screening, hour(10), minute(15))])).

test('reservation, two appointments same time') :-
  assertion(\+ book([
    appointment(screening, hour(10), minute(15)), 
    appointment(screening, hour(10), minute(15))
  ])).

test('reservation, two appointments, two different times') :-
  assertion(book([
    appointment(screening, hour(10), minute(15)), 
    appointment(screening, hour(15), minute(15))
  ])).

:- end_tests(hello).
