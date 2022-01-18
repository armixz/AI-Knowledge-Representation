% Facts
% %
human(john).
human(mary).

weekday(monday).
weekday(tuesday).
weekday(wednesday).
weekday(thursday).
weekday(friday).
weekday(saturday).
weekday(sunday).

item(bagels).
item(loafbread).
item(buns).
item(cinnamonrolls).
item(doughnuts).
item(coffee).
item(bananas).
item(apples).
item(cookies).
item(muffins).
item(scones).

rack(bagels,1.1).
rack(loafbread,1.2).
rack(buns,1.3).
rack(scones,1.3).
rack(cinnamonrolls,1.4).
rack(doughnuts,1.5).
rack(coffee,1.6).
rack(bananas,1.7).
rack(apples,1.8).
rack(cookies,1.9).
rack(muffins,1.10).

shoppingcart(john,loafbread,1).
shoppingcart(john,bagels,2).

money(cash).
money(card).

grows_natural(bananas).
grows_natural(apples).

yesterday(X) :- weekday(X),X = wednesday.

%Rules
% %
person(X) :- human(X).
buy_from_utdbakery(X) :- person(X).
customer(X) :- buy_from_utdbakery(X).

utdbakery(X) :- item(X).

price(X) :- utdbakery(X).

sold_to_utdbakery(X) :-
    utdbakery(X),
    grows_natural(X).

edible(X) :- utdbakery(X).

location(X,Y) :-
    utdbakery(X),
    rack(X,Y).

buy(X,Y) :-
    customer(X),
    utdbakery(Y).

basket(X,Y) :-
    customer(X),
    shoppingcart(X,Y,Z),
    Z > 0.

payment(X,Y,Z) :-
    buy(X,Z),
    money(Y),
    price(Z).

card_payment(X,Y,Z) :-
    buy(X,Z),
    payment(X,Y,Z),
    Y = card.

cash_payment(X,Y,Z) :-
    buy(X,Z),
    payment(X,Y,Z),
    Y = cash.

atleast(X,Y) :-
    customer(X),
    buy(X,Y),
    shoppingcart(X,Y,Z),
    Z >= 2.

made_by_utdbakery(X) :-
    utdbakery(X),
    not(sold_to_utdbakery(X)).


to_buy_from_utdbakery(X,Y) :-
    customer(X),
    money(Y).


less_money_after_going_to_utdbakery(X) :-
    customer(X),
    payment(X,_,_),!.


does_edible(X,Y) :-
    customer(X),
    edible(Y),
    shoppingcart(X,Y,Z),
    Z > 0.


sell_from_utdbakery(X) :- utdbakery(X).


meet_each_other(X,Y,Z,R) :-
    customer(X),
    customer(Y),
    utdbakery(Z),
    location(Z,R),
    yesterday(_),!.
