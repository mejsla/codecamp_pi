Code camp Raspberry pi 2014
===========================

På torsdag håller vi som ordnar årets Code camp i trådarna, och kommer att ha en introduktion till Raspberry pi.

Vi kommer att prata en del, men till större delen kommer torsdagen vara en workshop där ni får komma igång och experimentera lite med Raspberry pi.

Ni kommer alla att behöva era datorer.

Alla kommer att få installera sin raspberry pi, och därför är följande förberedelser viktiga.

Om ni har en eller flera micro-usb-laddare hemma (som kommer med de flesta android-telefoner), ta med dem! Vi har inte köpt strömförsörjning till pajerna.

- Leta upp en obokad ip-adress i arket nedan, fyll i ert namn och lägg ip-adressen på minnet
https://docs.google.com/a/mejsla.se/spreadsheets/d/1GTOoq3T8mp-kTrRYGb4eVAId90KPvLMou7PSaE2tQck/edit?usp=sharing

- För att kapa lite tid, så vill vi att alla öppnar en terminal, skapar en tom katalog, och i den kör följande kommando:
```bash <(curl https://raw.githubusercontent.com/mejsla/codecamp_pi/master/prepare.sh)```

Ni kommer att behöva ange ip-adressen från arket innan.

Scriptet tar ca 15-20 min, och därför är det bra om vi slipper ta tid från stepupen på torsdag.

(Kör ni windows kommer ni behöva köra detta i cygwin, dock är detta helt otestat)

För att detta ska fungera så behöver ni ha ett antal verktyg installerade, vilka även kontrolleras efter i scriptet: curl, xz, unzip, sed

Ni med cygwin måste installera detta manuellt, men på osx med homebrew och linux med apt-get så bör de kommandon som inte finns installeras automatiskt.

Hör av er om det är några problem att köra scriptet, så försöker vi hjälpa till så gott det går.

Väl mött på torsdag!
