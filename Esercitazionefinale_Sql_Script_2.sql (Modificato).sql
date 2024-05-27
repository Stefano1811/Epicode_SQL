/*1. Verificare che i campi definiti come PK siano univoci.
 2. Esporre l’elenco dei soli prodotti venduti e per ognuno di questi il fatturato totale per anno.
 3. Esporre il fatturato totale per stato per anno. Ordina il risultato per data e per fatturato decrescente.
 4. Rispondere alla seguente domanda: qual è la categoria di articoli maggiormente richiesta dal mercato?
 5. Rispondere alla seguente domanda: quali sono, se ci sono, i prodotti invenduti? Proponi due approcci risolutivi differenti.
 6. Esporre l’elenco dei prodotti con la rispettiva ultima data di vendita (la data di vendita più recente).*/
 
 
 /* Rispetto al file precedente ho modificato il punto 4 lasciando solo una soluzione della query perchè mi sono accorto che avrei dovuto creare una nuova tabella Categoria
 per risolvero come l avevo pensato...mi ero confuso e avevo cercato il nome del prodotto invece della categoria*/
 
 
 /*1. Verificare che i campi definiti come PK siano univoci.*/
 
SELECT count(P.idprodotto) PK, count(DISTINCT P.idprodotto) PK_univoca
FROM prodotti P 
;

SELECT count(AG.idarea_geografica) PK, count(DISTINCT AG.idarea_geografica) PK_univoca
FROM area_geografica AG
;

SELECT count(V.idvendita) PK, count(DISTINCT V.idvendita) PK_univoca
FROM vendite V 
;

/*2. Esporre l’elenco dei soli prodotti venduti e per ognuno di questi il fatturato totale per anno.*/

SELECT P.nome_prodotto Prodotto, YEAR(V.data_vendita) Anno, sum(V.totale) Fatturato
FROM vendite V 
LEFT JOIN prodotti P ON V.idprodotto = P.idprodotto
GROUP BY 1,2 
ORDER BY 1 
;

/*3. Esporre il fatturato totale per stato per anno. Ordina il risultato per data e per fatturato decrescente.*/

SELECT AG.stato, YEAR(V.data_vendita) Anno, sum(V.totale) Fatturato
FROM vendite V 
LEFT JOIN area_geografica AG ON V.idarea_geografica = AG.idarea_geografica
GROUP BY 1,2 
ORDER BY 2 DESC, 3 DESC
;

/* 4. Rispondere alla seguente domanda: qual è la categoria di articoli maggiormente richiesta dal mercato?*/

SELECT P.categoria Categoria,sum(V.quantità) Tot_Quantità_Richieste
FROM vendite V 
LEFT JOIN prodotti P ON V.idprodotto = P.idprodotto
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1 
;


/*5.Rispondere alla seguente domanda: quali sono, se ci sono, i prodotti invenduti? Proponi due approcci risolutivi differenti.*/

SELECT PR.nome_prodotto Prodotto
FROM prodotti PR 
WHERE PR.nome_prodotto NOT IN
(SELECT distinct P.nome_prodotto
FROM vendite V
LEFT JOIN prodotti P ON V.idprodotto = P.idprodotto)
;

/*5.Rispondere alla seguente domanda: quali sono, se ci sono, i prodotti invenduti? Proponi due approcci risolutivi differenti.*/

SELECT P.nome_prodotto Prodotto, V.idprodotto IdProdottoVendite
FROM prodotti P 
LEFT JOIN vendite V ON P.idprodotto = V.idprodotto
WHERE V.idprodotto IS NULL
;

/*6. Esporre l’elenco dei prodotti con la rispettiva ultima data di vendita (la data di vendita più recente)*/

SELECT P.nome_prodotto Prodotto , max(V.data_vendita) Ultima_data_vendita
FROM vendite V
LEFT JOIN prodotti P ON V.idprodotto = P.idprodotto
GROUP BY 1
ORDER BY 2 DESC
;