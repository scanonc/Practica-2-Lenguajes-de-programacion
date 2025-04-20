% PARTE 1

% Lista de vehiculos
% vehiculo(Marca, Modelo, Tipo, Precio, A�o)

vehiculo(toyota, corolla, sedan, 22000, 2022).
vehiculo(toyota, rav4, suv, 28000, 2023).
vehiculo(toyota, yaris, sedan, 18000, 2021).
vehiculo(toyota, hilux, pickup, 35000, 2023).

vehiculo(ford, mustang, sport, 45000, 2022).
vehiculo(ford, ranger, pickup, 33000, 2021).
vehiculo(ford, fiesta, sedan, 20000, 2020).
vehiculo(ford, explorer, suv, 48000, 2023).

vehiculo(bmw, serie3, sedan, 42000, 2021).
vehiculo(bmw, x5, suv, 60000, 2022).
vehiculo(bmw, m4, sport, 72000, 2023).
vehiculo(bmw, x1, suv, 40000, 2020).

vehiculo(chevrolet, onix, sedan, 17000, 2022).
vehiculo(chevrolet, tracker, suv, 25000, 2023).
vehiculo(chevrolet, s10, pickup, 30000, 2021).
vehiculo(chevrolet, camaro, sport, 50000, 2020).

vehiculo(honda, civic, sedan, 23000, 2022).
vehiculo(honda, accord, sedan, 27000, 2023).
vehiculo(honda, crv, suv, 31000, 2021).
vehiculo(honda, ridgeline, pickup, 36000, 2022).


% PARTE 2

% Filtrar por presupuesto y modelo
filtrar_presupuesto_y_modelo(Modelo, PresupuestoMax) :-
    vehiculo(_, Modelo, _, Precio, _),
    Precio =< PresupuestoMax.

% Filtrar por presupuesto y tipo
filtrar_presupuesto_y_tipo(Tipo, PresupuestoMax) :-
    vehiculo(_, _, Tipo, Precio, _),
    Precio =< PresupuestoMax.

% Filtrar por marca
filtrar_marca(Marca, Vehiculos) :-
    findall(Modelo, vehiculo(Marca, Modelo, _, _, _), Vehiculos).


% PARTE 3

% Extraer los pares (Precio, Modelo) filtrados
pares_filtrados(Marca, Tipo, Presupuesto, Pares) :-
    findall((Precio, Modelo),( vehiculo(Marca, Modelo, Tipo, Precio,_),Precio =< Presupuesto),Pares).

% Ordenar los pares de menor a mayor
ordenar_por_precio(Pares, ParesOrd) :-
    sort(1, @=<, Pares, ParesOrd).

% Extraer solo el modelo de los pares
extraer_modelos([], []).
extraer_modelos([(_,Modelo)|Resto], [Modelo|Ms]) :-
extraer_modelos(Resto, Ms).

valor_total(ModelosOrd, Total) :-
    findall(Precio, (member(Modelo, ModelosOrd), vehiculo(_, Modelo, _, Precio, _)), Precios),
    sumlist(Precios, Total).


% generar el reporte
generar_reporte(Marca, Tipo, Presupuesto, (ModelosOrd, Total)) :-
    pares_filtrados(Marca, Tipo, Presupuesto, Pares),
    ordenar_por_precio(Pares, ParesOrd),
    extraer_modelos(ParesOrd, ModelosOrd),
    valor_total(ModelosOrd, Total).

% PARTE 4

% casos de prueba

% Case 1: List all Toyota SUV references priced under $30,000.
caso_1 :-
    findall(Modelo, (vehiculo(toyota, Modelo, suv, Precio, _), Precio < 30000), Resultado),
    write(Resultado).

% Case 2: Show Ford brand vehicles using bagof/3, grouped by type and year.
caso_2 :-
    bagof((Modelo, Tipo, A�o), vehiculo(ford, Modelo, Tipo, _, A�o), Resultado),
    write(Resultado).

% Case 3: Calculate the total value of an inventory filtere by type
% sedan without exceeding 500000
caso_3 :-
    findall(Modelo, (vehiculo(_, Modelo, sedan, Precio, _), Precio =< 500000), Lista),
    valor_total(Lista, Total),
    Total =< 500000,
    write((Lista, Total)).
