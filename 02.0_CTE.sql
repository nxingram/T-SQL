Un esempio di utilizzo delle CTE

Faccio un esempio pratico per spiegare meglio l’utilizzo delle CTE. 
  Supponiamo di avere la tabella Fatture contenente le colonne IdFattura, DataFattura e Importo e che ci venga chiesto di calcolare l’importo annuo medio, vale a dire la media degli importi calcolati per ogni anno. 
  Molti sviluppatori si imbatteranno in un vicolo cieco cercando di scrivere un’unica query che risolva direttamente il problema. 
  Molti tentativi daranno errori di sintassi perché si cercherà di annidare le due funzioni di aggregazione AVG, SUM. 
  Ancor peggio è la situazione in cui la query compila, ma fornisce delle informazioni errate perché manca, ad esempio, la clausola GROUP BY.

Un approccio migliore che semplifica la vita dello sviluppatore consiste nel suddividere preliminarmente il problema in due sotto problemi più semplici:

    calcolare per ogni anno il totale degli importi;
    calcolare la media dei valori ottenuti precedentemente.

Questi due task sono risolvibili con due semplicissime query SQL che utilizzano solo le funzionalità di base: per il primo basterà una group by sull’anno e una funzione di aggregazione, 
      mentre per il secondo basterà calcolare la media di una colonna. 
      Il problema che si pone però è il seguente: come faccio a mettere insieme le due query per estrarre il risultato finale? 
      Per rispondere a questa domanda l’SQL ci mette a disposizione più strumenti differenti come le CTE, le subquery, le tabelle temporanee e le viste. 
      In questo articolo ci concentreremo sullo strumento a mio parere più flessibile: le CTE.
CTE: Common Table Expression in SQL

Partiamo scrivendo la query per risolvere il primo sotto-problema: calcolare per ogni anno il totale degli importi. Supponendo di lavorare in ambiente Microsoft Sql Server, ci basterà scrivere una query come

SELECT 
   YEAR(DataFattura) AS Anno, 
   SUM(Importo) AS ImportoTotaleAnnuo
FROM Fatture
GROUP BY YEAR(DataFattura);

Sugli altri RDBMS la situazione è molto simile. Osserviamo nella prossima tabella un possibile output della query precedente.
Anno	ImportoTotaleAnnuo
2016	105.27
2017	261.10
2018	215.07

L’output di una query si presenta ai nostri occhi come una comune tabella: ci sono delle colonne con un’intestazione e una serie di righe contenenti le informazioni. 
  Immaginiamo un attimo di avere realmente questa tabella salvata fisicamente nel nostro DB (non solo sullo schermo) e che questa tabella si chiami ad esempio ImportiFattureAnnui. 
  Quanto sarebbe difficile rispondere ora alla seconda domanda “calcolare la media dei fatturati precedenti“? Si tratterebbe di un gioco da ragazzi, basterebbe scrivere

SELECT   
   AVG(ImportoTotaleAnnuo) AS ImportoAnnuoMedio
FROM  ImportiFattureAnnui;

Ora è facile capire che non è pensabile creare una vera tabella e occupare spazio sul disco per ogni sotto-task di ogni richiesta che arriva a un team di Data Analyst. 
  Ma per questo ci vengono in soccorso le CTE: con un po’ di approssimazione possiamo dire che l’effetto è quello di creare la tabella in memoria solo per il tempo necessario a svolgere l’intera l’analisi. La sintassi è molto semplice:

WITH ImportiFattureAnnui AS(
    SELECT 
      YEAR(DataFattura) AS Anno,
      SUM(Importo) AS ImportoTotaleAnnuo
    FROM Fatture
    GROUP BY YEAR(DataFattura)
    )
SELECT 
  AVG(ImportoTotaleAnnuo) AS ImportoAnnuoMedio
FROM  ImportiFattureAnnui;

Se dopo aver eseguito la query provo a rilanciare le ultime due righe di codice

SELECT 
  AVG(ImportoTotaleAnnuo) AS ImportoAnnuoMedio
FROM   ImportiFattureAnnui;

otterrò l’errore “ImportiFattureAnnui non esiste”. 
  Utilizzando la CTE non creiamo nessuna tabella, stiamo solo definendo un’espressione SQL il cui output può essere utilizzato al pari di una tabella all’interno dello stessa esecuzione.

source: https://www.yimp.it/cte-come-e-quando-utilizzarle-nel-tuo-codice-sql/
