Förberedelser inför Stepup inför Code camp Raspberry pi 2014
============================================================

Gör detta innan stepup:en

- Leta upp en obokad ip-adress i arket nedan, fyll i ert namn och lägg ip-adressen på minnet
https://docs.google.com/a/mejsla.se/spreadsheets/d/1GTOoq3T8mp-kTrRYGb4eVAId90KPvLMou7PSaE2tQck/edit?usp=sharing

- För att kapa lite tid, så vill vi att alla öppnar en terminal, skapar en tom katalog, och i den kör följande kommando:
```bash <(curl https://raw.githubusercontent.com/mejsla/codecamp_pi/master/prepare.sh)```

Ni kommer att behöva ange ip-adressen från arket innan.

Scriptet tar ca 15-20 min, och därför är det bra om vi slipper ta tid från stepupen på torsdag.

(Kör ni windows kommer ni behöva köra detta i cygwin, dock är detta helt otestat)

För att detta ska fungera så behöver ni ha ett antal verktyg installerade, vilka även kontrolleras efter i scriptet:
```
curl
xz
unzip
sed
```
I OSX och Linux så finns det en chans att scriptet automatiskt hanterar detta, om ni har homebrew på mac eller apt-get på linux.

Ni med cygwin måste installera detta manuellt, passa på när ni installerar [cygwin](https://www.cygwin.com) (om ni inte redan har det)

Efter scriptet är kört, bör ni ha en katalog under den ni körde scriptet i som innehåller:
```BUILD-DATA
INSTRUCTIONS-README.txt
RECOVERY_FILES_DO_NOT_EDIT
bootcode.bin
defaults
os
recovery.cmdline
recovery.cmdline.bak
recovery.elf
recovery.img
recovery.rfs
riscos-boot.bin
```

Under stepup:en skall detta kopieras över till det microSD-kort ni får. 

Har ni kommit så här långt, så kan ni slappna av och känna er duktiga och förberedda inför stepup:en!

Välkomna!
