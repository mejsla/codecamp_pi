# Växtvakten
Målet är att skapa en mindre bevattningsanläggning för automatisk vattning av en blomkruka.  kan användas för t.ex. schemalagd vattning eller vattning efter behov.

## Projektbeskrivning
När fuktnivån, indidkerad av sensorn, når under en specificerad nivå skall vattenpumpen starta och köra tills dess att fuktnivån är återställd. 

Eftersom fuktsensorn är analog (spänningen varierar mellan 0 och 4,2V beroende på fuktigheten) krävs något som omvandlar signalen till en digital, som pajen kan tolka. Därför måste en AD-omvanlare användas.

För att driva pumpen måste en extern spänningskälla användas. Denna källa skall styras m.h.a. ett relä på reläbrädan.

[Intruktion för ett liknande projekt] (http://computers.tutsplus.com/tutorials/build-a-raspberry-pi-moisture-sensor-to-monitor-your-plants--mac-52875)


## Utrustning
 * [Fuktsensor - Octopus Soil Moisture Sensor Brick]
 (http://www.elecfreaks.com/store/octopus-soil-moisture-sensor-brick-p-422.html)
 * [AD-omvandlare - MCP3008 (8-Channel 10-Bit A/D Converter with SPI Serial Interface]  
(http://www.adafruit.com/datasheets/MCP3008.pdf)
 * [Vattenpump]
 (https://www.m.nu/peristaltic-liquid-pump-with-silicone-tubing-p-875.html)
 * [12V spänningsmatning]  
 (https://www.m.nu/batterieliminator-12v-dc-7a-p-1215.html)
 * [Reläbräda]  
(https://www.m.nu/relay-board-5vlogic-level-operation-4channel-assembled-p-1094.html)

## Tips på vägen
Doppa inte er raspberry pi i blöt jord

## Möjliga utökningar
* Schemalägg bevattning
* Videomonitorering av bevattning
* Statistik för hur mycket vatten som har distribuerats samt med vilka intervall
* Web-gränssnitt för att sätta gränsvärden, övervaka nuvarande fukthalt, och manuellt slå på/av kran.
