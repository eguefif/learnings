#!/usr/bin/env swipl

:- module(hello,[book/1, appointment/3]).

screening(minute(15), minute(15)).
behavioral(minute(45), minute(30)).
technical(minute(120), minute(60)).

appointment(Type, Hour, Minute).

book([]) :-
  true.

book([_]) :-
  true.

book([appointment(T1, hour(H1), M1),appointment(T2, hour(H2), M2)]) :-
  H1 =\= H2.


:- initialization(main).
main(_) :-
  print("Hello World"),
  book([
    appointment(screening, hour(10), minute(15)), 
    appointment(screening, hour(15), minute(15))
  ]),
  true.


% * Appointment types: Screening, Behavioral, Technical
% * Durations:
%        Screening: 15 minutes
%        Behavioral: 45 minutes
%        Technical: 2 hours

%  * After-interview buffer:
%     Screening: 15 minutes
%     Behavioral: 30 minutes
%     Technical: 1 hour

%     * Number limit:
% 

% Screening
% - Max 3 per day
% - 2 hours ahead
% Behavioral
% - Max 2 per day (no other interview)
% - 4 hours ahead
% Technical
% - No other interview earlier, or the day before
% - 2 days ahead
