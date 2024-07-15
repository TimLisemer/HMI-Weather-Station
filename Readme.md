# HMI - Projekt

## Projektbeschreibung
Dieses Projekt wurde im Rahmen des Fachs Human Machine Interfaces durchgeführt und verwendet einen Raspberry Pi, um Umweltdaten mit Hilfe von zwei verschiedenen Sensoren zu erfassen. Diese Daten werden anschließend über eine benutzerfreundliche Oberfläche visualisiert.

### Hardware
Raspberry Pi: Zentrale Steuereinheit des Projekts.
Lichtsensor: Misst die Helligkeit und gibt Werte zwischen 0 und 1 aus, je nach Lichtintensität.
Umgebungssensor: Misst Temperatur, Luftdruck und Luftfeuchtigkeit.

### Software
WiringPi: Bibliothek zur Kommunikation mit den Sensoren.
Qt: Framework für die Schnittstellenprogrammierung.
QML: Sprache zur Gestaltung der grafischen Benutzeroberfläche (GUI) bzw. der natürlichen Benutzeroberfläche (NUI).
Benutzeroberfläche
HomeScreen
Der HomeScreen zeigt alle aktuellen Sensordaten auf einen Blick an:

Lichtsensorwert
Temperatur
Luftdruck
Luftfeuchtigkeit
Uhrzeit
Datum
IP-Adresse
Hostname des Geräts

### Detailansicht
Für jeden der angezeigten Werte gibt es einen Button im Header. Durch Anklicken eines Buttons kann man detailliertere Informationen zu dem jeweiligen Wert anzeigen lassen.

### Messwertvisualisierung
Für die Messwerte der Luftfeuchtigkeit, des Luftdrucks und der Temperatur wird zusätzlich ein Balkendiagramm angezeigt, um die Daten anschaulich zu visualisieren.

### Installation
Systemanforderungen: Raspberry Pi, Python, Qt und QML installiert.
Clone das Repository:


### Nutzung
Starten Sie den Raspberry Pi und verbinden Sie die Sensoren gemäß der Anleitung.
Starten Sie die Anwendung und navigieren Sie durch die Benutzeroberfläche, um die Sensordaten zu überwachen.
Verwenden Sie die Buttons im Header, um detailliertere Informationen zu den einzelnen Messwerten zu erhalten.

### Autoren
Tim Lisemer, Nico Ljubicic, Anastasia Tsaava