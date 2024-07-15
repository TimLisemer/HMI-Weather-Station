# HMI - Projekt

## Projektbeschreibung

Dieses Projekt wurde im Rahmen des Fachs Human Machine Interfaces durchgeführt und verwendet einen Raspberry Pi, um Umweltdaten mit Hilfe von zwei verschiedenen Sensoren zu erfassen. Diese Daten werden anschließend über eine benutzerfreundliche Oberfläche visualisiert.

## Hardware

- **Raspberry Pi**: Zentrale Steuereinheit des Projekts.
- **Lichtsensor**: Misst die Helligkeit und gibt Werte zwischen 0 und 1 aus, je nach Lichtintensität.
- **Umgebungssensor**: Misst Temperatur, Luftdruck und Luftfeuchtigkeit.

## Software

- **WiringPi**: Bibliothek zur Kommunikation mit den Sensoren.
- **Qt**: Framework für die Schnittstellenprogrammierung.
- **QML**: Sprache zur Gestaltung der grafischen Benutzeroberfläche (GUI) bzw. der natürlichen Benutzeroberfläche (NUI).

## Benutzeroberfläche

### HomeScreen

Der HomeScreen zeigt alle aktuellen Sensordaten auf einen Blick an:
- Lichtsensorwert
- Temperatur
- Luftdruck
- Luftfeuchtigkeit
- Uhrzeit
- Datum
- IP-Adresse
- Hostname des Geräts

### Detailansicht

Für jeden der angezeigten Werte gibt es einen Button im Header. Durch Anklicken eines Buttons kann man detailliertere Informationen zu dem jeweiligen Wert anzeigen lassen.

Für die Umweltsensor-Werte (Humidity, Pressure, Temperature) gilt folgendes:

- **Erstes Anklicken des Header-Buttons**: Ein Balkendiagramm wird angezeigt.
- **Zweites Anklicken desselben Header-Buttons**: Eine scrollbare Listenansicht wird angezeigt.



### Messwertvisualisierung

Für die Messwerte der Luftfeuchtigkeit, des Luftdrucks und der Temperatur wird zusätzlich ein Balkendiagramm angezeigt, um die Daten anschaulich zu visualisieren.

## Installation

1. **Systemanforderungen**: Raspberry Pi, Qt und QML installiert.
2. **Clone das Repository**:
    Mit HTTPS:
    ```sh
    git clone https://code.fbi.h-da.de/istniljub/hmi.git
    ```
    Mit SSH:
    ```sh
    git clone git@code.fbi.h-da.de:istniljub/hmi.git
    ```

3. **Starte die Anwendung**:
    ```sh
    qmake
    make
    ./hmi-04
    ```

## Nutzung

1. **Starten Sie den Raspberry Pi** und verbinden Sie die Sensoren gemäß der Anleitung.
2. **Stoppen Sie den Qt Launcher** in dem sie in der Konsole den Befehl "systemctl stop qtlauncher" eingeben.
3. **Starten Sie die Anwendung** und navigieren Sie durch die Benutzeroberfläche, um die Sensordaten zu überwachen.
4. **Verwenden Sie die Buttons** im Header, um detailliertere Informationen zu den einzelnen Messwerten zu erhalten.

## Autoren

- Tim Lisemer
- Nico Ljubicic
- Anastasia Tsaava